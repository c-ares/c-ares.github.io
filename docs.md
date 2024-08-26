---
menu: Docs
title: c-ares documentation
layout: page
---

- [Manpages](#manpages)
- [Examples](#examples)

c-ares provides a set of library functions, datatypes, and enumerations
which integrators will use for their implementations.  When you install c-ares,
you get man pages which describe their use and meanings.

## Manpages

{% assign docs_paths = site.pages | where_exp: "page", "page.path contains 'docs/'" | map: "path" | sort -%}
{%- for path in docs_paths -%}
	{%- assign my_page = site.pages | where: "path", path | first -%}
- [{{ my_page.path | replace: "docs/", "" | replace: ".html", "" }}](/{{ my_page.path }})
{% endfor -%}

## Examples

### Event Thread example (recommended)

`example_ev.c`:
{% highlight C %}
#include <stdio.h>
#include <string.h>
#include <ares.h>

/* Callback that is called when DNS query is finished */
static void addrinfo_cb(void *arg, int status, int timeouts,
                        struct ares_addrinfo *result)
{
  (void)arg; /* Example does not use user context */
  printf("Result: %s, timeouts: %d\n", ares_strerror(status), timeouts);

  if (result) {
    struct ares_addrinfo_node *node;
    for (node = result->nodes; node != NULL; node = node->ai_next) {
      char        addr_buf[64] = "";
      const void *ptr          = NULL;
      if (node->ai_family == AF_INET) {
        const struct sockaddr_in *in_addr =
          (const struct sockaddr_in *)((void *)node->ai_addr);
        ptr = &in_addr->sin_addr;
      } else if (node->ai_family == AF_INET6) {
        const struct sockaddr_in6 *in_addr =
          (const struct sockaddr_in6 *)((void *)node->ai_addr);
        ptr = &in_addr->sin6_addr;
      } else {
        continue;
      }
      ares_inet_ntop(node->ai_family, ptr, addr_buf, sizeof(addr_buf));
      printf("Addr: %s\n", addr_buf);
    }
  }
  ares_freeaddrinfo(result);
}

int main(int argc, char **argv)
{
  ares_channel_t            *channel = NULL;
  struct ares_options        options;
  int                        optmask = 0;
  struct ares_addrinfo_hints hints;

  if (argc != 2) {
    printf("Usage: %s domain\n", argv[0]);
    return 1;
  }

  /* Initialize library */
  ares_library_init(ARES_LIB_INIT_ALL);

  if (!ares_threadsafety()) {
    printf("c-ares not compiled with thread support\n");
    return 1;
  }

  /* Enable event thread so we don't have to monitor file descriptors */
  memset(&options, 0, sizeof(options));
  optmask      |= ARES_OPT_EVENT_THREAD;
  options.evsys = ARES_EVSYS_DEFAULT;

  /* Initialize channel to run queries, a single channel can accept unlimited
   * queries */
  if (ares_init_options(&channel, &options, optmask) != ARES_SUCCESS) {
    printf("c-ares initialization issue\n");
    return 1;
  }

  /* Perform an IPv4 and IPv6 request for the provided domain name */
  memset(&hints, 0, sizeof(hints));
  hints.ai_family = AF_UNSPEC;
  hints.ai_flags  = ARES_AI_CANONNAME;
  ares_getaddrinfo(channel, argv[1], NULL, &hints, addrinfo_cb,
                   NULL /* user context not specified */);

  /* Wait until no more requests are left to be processed */
  ares_queue_wait_empty(channel, -1);

  /* Cleanup */
  ares_destroy(channel);

  ares_library_cleanup();
  return 0;
}
{% endhighlight %}

Compilation:
{% highlight bash %}
cc -I/usr/local/include -o example_ev example_ev.c -Wl,-rpath /usr/local/lib -lcares
{% endhighlight %}

### Sock State Callback example

`example_ss.c`:
{% highlight C %}
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <poll.h>
#include <ares.h>

typedef struct {
  ares_channel_t *channel;
  struct pollfd  *fds;
  size_t          nfds;
} dnsstate_t;

void sock_state_cb(void *data, ares_socket_t socket_fd, int readable, int writable)
{
  dnsstate_t *state = data;
  size_t      idx;

  /* Find match */
  for (idx=0; idx<state->nfds; idx++) {
    if (state->fds[idx].fd == socket_fd) {
      break;
    }
  }

  /* Not found */
  if (idx >= state->nfds) {
    /* Do nothing */
    if (!readable && !writable) {
      return;
    }

    /* Add */
    state->nfds++;
    state->fds = realloc(state->fds, sizeof(*state->fds) * state->nfds);
  } else {
    /* Remove */
    if (!readable && !writable) {
      memmove(&state->fds[idx], &state->fds[idx+1],
        sizeof(*state->fds) * (state->nfds - idx - 1));
      state->nfds--;
      return;
    }
  }

  state->fds[idx].fd     = socket_fd;
  state->fds[idx].events = 0;
  if (readable) {
    state->fds[idx].events |= POLL_IN;
  }
  if (writable) {
    state->fds[idx].events |= POLLOUT;
  }
}

void process(dnsstate_t *state)
{
  struct timeval tv;

  while (1) {
    int    rv;
    int    timeout;
    size_t i;

    /* Since we don't have any other program state to wait on, we'll just
     * stop looping when we know there are no remaining queries, which is
     * easily indicated by ares_timeout() returning NULL when maxtv is NULL */
    if (ares_timeout(state->channel, NULL, &tv) == NULL) {
      break;
    }

    timeout = tv.tv_sec * 1000 + tv.tv_usec / 1000;

    rv = poll(state->fds, state->nfds, timeout);
    if (rv < 0) {
      continue;
    } else if (rv == 0) {
      /* Process timeouts */
      ares_process_fd(state->channel, ARES_SOCKET_BAD, ARES_SOCKET_BAD);
      continue;
    }

    for (i=0; i<state->nfds; i++) {
      if (state->fds[i].revents == 0) {
        continue;
      }

      /* Notify about read/write events per FD */
      ares_process_fd(state->channel,
        (state->fds[i].revents & (POLLERR|POLLHUP|POLLIN))?
          state->fds[i].fd:ARES_SOCKET_BAD,
        (state->fds[i].revents & POLLOUT)?
          state->fds[i].fd:ARES_SOCKET_BAD);
    }
  }
}

/* Callback that is called when DNS query is finished */
static void addrinfo_cb(void *arg, int status, int timeouts,
                        struct ares_addrinfo *result)
{
  (void)arg; /* Example does not use user context */
  printf("Result: %s, timeouts: %d\n", ares_strerror(status), timeouts);

  if (result) {
    struct ares_addrinfo_node *node;
    for (node = result->nodes; node != NULL; node = node->ai_next) {
      char        addr_buf[64] = "";
      const void *ptr          = NULL;
      if (node->ai_family == AF_INET) {
        const struct sockaddr_in *in_addr =
          (const struct sockaddr_in *)((void *)node->ai_addr);
        ptr = &in_addr->sin_addr;
      } else if (node->ai_family == AF_INET6) {
        const struct sockaddr_in6 *in_addr =
          (const struct sockaddr_in6 *)((void *)node->ai_addr);
        ptr = &in_addr->sin6_addr;
      } else {
        continue;
      }
      ares_inet_ntop(node->ai_family, ptr, addr_buf, sizeof(addr_buf));
      printf("Addr: %s\n", addr_buf);
    }
  }
  ares_freeaddrinfo(result);
}

int main(int argc, char **argv)
{
  dnsstate_t                 state;
  struct ares_options        options;
  int                        optmask = 0;
  struct ares_addrinfo_hints hints;

  memset(&state, 0, sizeof(state));

  if (argc != 2) {
    printf("Usage: %s domain\n", argv[0]);
    return 1;
  }

  /* Initialize library */
  ares_library_init(ARES_LIB_INIT_ALL);

  /* Enable sock state callbacks, we should not use ares_fds() or ares_getsock()
   * in modern implementations. */
  memset(&options, 0, sizeof(options));
  optmask                   |= ARES_OPT_SOCK_STATE_CB;
  options.sock_state_cb      = sock_state_cb;
  options.sock_state_cb_data = &state;

  /* Initialize channel to run queries, a single channel can accept unlimited
   * queries */
  if (ares_init_options(&state.channel, &options, optmask) != ARES_SUCCESS) {
    printf("c-ares initialization issue\n");
    return 1;
  }

  /* Perform an IPv4 and IPv6 request for the provided domain name */
  memset(&hints, 0, sizeof(hints));
  hints.ai_family = AF_UNSPEC;
  hints.ai_flags  = ARES_AI_CANONNAME;
  ares_getaddrinfo(state.channel, argv[1], NULL, &hints, addrinfo_cb,
                   NULL /* user context not specified */);

  /* Wait until no more requests are left to be processed */
  process(&state);

  /* Cleanup */
  ares_destroy(state.channel);
  free(state.fds);

  ares_library_cleanup();
  return 0;
}
{% endhighlight %}

Compilation:
{% highlight bash %}
cc -I/usr/local/include -o example_ss example_ss.c -Wl,-rpath /usr/local/lib -lcares
{% endhighlight %}
