# c-ares website

The c-ares website uses [Jekyll](https://jekyllrb.com/) as a templating system
to generate static html content, which is then hosted on
[GitHub Pages](https://pages.github.com/).

Some content, such as the manpages, are generated externally by the `Makefile`.
Manpages in particular depend on [roffit](https://github.com/bagder/roffit)
for conversion to HTML.

The c-ares source code is expected to exist in a directory named `c-ares.git`
to pull in manpage content along with some other files like `LICENSE.md` and
`SECURITY.md`.

## Building and testing locally

Dependencies:
 - Git
 - [Install Jekyll](https://jekyllrb.com/docs/installation/)
 - GNU Make
 - [Roffit](https://github.com/bagder/roffit), available via some package
   managers, such as Ubuntu.

Building:
 1. Git checkout https://github.com/c-ares/c-ares.github.io
 2. Inside of `c-ares.github.io `checkout, checkout the
    [c-ares](https://github.com/c-ares/c-ares) source code as `c-ares.git`.
 3. Build external files such as manpages via `make`
 4. Install Jekyll dependencies for site via (`bundle install`)
 5. Build and self-host test site (`bundle exec jekyll serve -V`)

Example:
```bash
git clone https://github.com/c-ares/c-ares.github.io
cd c-ares.github.io
git clone --depth=1 https://github.com/c-ares/c-ares c-ares.git
make
bundle install
bundle exec jekyll serve -V
```
