.DEFAULT_GOAL := all
ROOT=.
DEPDIR=.deps

MAINPARTS= $(ROOT)/doctype.t body.t footer.t $(ROOT)/setup.t \
 menu.t Makefile docmenu.t css.t
OPTS=-WWW -Uunix -H -C -V -I$(ROOT) -LL
FCPP=fcpp
ACTION=$(FCPP) $(OPTS) $< $@
SRCDIR=ares-cvs
DOCSDIR=$(SRCDIR)/docs
MAN2HTML= roffit --bare --mandir=$(DOCSDIR) --hrefdir=.
MARKDOWN=markdown
MANPAGES_SRC=$(sort $(shell find $(DOCSDIR) -name "*.3"))
MANPAGES=$(sort $(notdir $(MANPAGES_SRC:.3=.html)))
DEPFILES=$(MANPAGES:%.html=$(DEPDIR)/%.d)

PAGES = 					\
 adv_20160929.html				\
 adv_20170620.html				\
 adv_20210810.html				\
 changelog.html					\
 docs.html					\
 index.html					\
 indexbot.html					\
 indextop.html					\
 license.html					\
 mailbot.html					\
 mailhead.html					\
 mailtop.html					\
 old.html					\
 otherlibs.html					\
 security.html					\
 vulns.html					\
 why.html 					\
 $(MANPAGES)

$(DEPDIR):
	mkdir -p $@

$(DEPDIR)/%.d: $(DOCSDIR)/%.3
	sed -n -e 's|^\.so man[0-9]/\(.*\.[0-9]\).*|$*.html: $(DOCSDIR)/\1|p' < $< > $@

%.html: $(DOCSDIR)/%.3 $(DEPDIR)/%.d
	$(MAN2HTML) < $< >$*.raw
	$(FCPP) $(OPTS) -Dfunc=$* -Ddocs_$* -Dfuncinc=\"$*.raw\" ares_func.t $@

$(DEPFILES): $(DEPDIR)
include $(DEPFILES)

all: $(PAGES)
	make -C download

.PHONY: all

index.html: index.t $(MAINPARTS)
	$(ACTION)

changelog.html: changelog.t $(MAINPARTS) changelog.gen
	$(ACTION)

changelog.gen: changelog.md
	$(MARKDOWN) < $< > $@

vulns.html: vulns.t $(MAINPARTS)
	$(ACTION)

security.html: security.t $(MAINPARTS) security.gen
	$(ACTION)

security.gen: $(SRCDIR)/SECURITY.md
	$(MARKDOWN) < $< > $@

license.gen: $(SRCDIR)/LICENSE.md
	$(MARKDOWN) < $< > $@

adv_20160929.html: adv_20160929.t $(MAINPARTS) adv_20160929.gen
	$(ACTION)
adv_20160929.gen: adv_20160929.md
	$(MARKDOWN) < $< > $@

adv_20170620.html: adv_20170620.t $(MAINPARTS) adv_20170620.gen
	$(ACTION)
adv_20170620.gen: adv_20170620.md
	$(MARKDOWN) < $< > $@

adv_20210810.html: adv_20210810.t $(MAINPARTS) adv_20210810.gen
	$(ACTION)
adv_20210810.gen: adv_20210810.md
	$(MARKDOWN) < $< > $@

old.html: old.t $(MAINPARTS)
	$(ACTION)

otherlibs.html: otherlibs.t $(MAINPARTS)
	$(ACTION)

why.html: why.t $(MAINPARTS)
	$(ACTION)

docs.gen: $(MANPAGES)
	@echo "$(MANPAGES)" | sed 's/\([a-zA-Z0-9_]*\)\.html/<li><a href="\1.html">\1<\/a>\n/g' > $@

docs.html: docs.t docs.gen $(MAINPARTS)
	$(ACTION)

license.html: license.t $(MAINPARTS) license.gen
	$(ACTION)

mailhead.html: mailhead.t $(MAINPARTS)
	$(ACTION)

mailtop.html: mailtop.t $(MAINPARTS) mailmenu.t
	$(ACTION)
mailbot.html: mailbot.t $(MAINPARTS)
	$(ACTION)
indextop.html: indextop.t $(MAINPARTS) mailmenu.t
	$(ACTION)
indexbot.html: indexbot.t $(MAINPARTS)
	$(ACTION)

clean:
	find . -name "*~" -exec rm {} \;
	rm -f *.raw *.html *.gen
	rm -rf $(DEPDIR)
	make -C download clean

