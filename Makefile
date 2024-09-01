.DEFAULT_GOAL := all
ROOT=.
DEPDIR=.deps
SRCDIR=c-ares.git
DOCSDIR=$(SRCDIR)/docs
DOCSDEST=docs
MAN2HTML=roffit --bare --mandir=$(DOCSDIR) --hrefdir=/$(DOCSDEST)
MANPAGES_SRC=$(sort $(shell find $(DOCSDIR) -name "*.3"))
MANPAGES=$(addprefix $(DOCSDEST)/,$(sort $(notdir $(MANPAGES_SRC:.3=.html))))
MANPAGES_NAMES=$(sort $(notdir $(MANPAGES_SRC)))
DEPFILES=$(MANPAGES_NAMES:%.3=$(DEPDIR)/%.d)

PAGES=$(MANPAGES) features.md security.md license.md

$(DOCSDEST):
	mkdir -p $@

$(DEPDIR): $(DOCSDEST)
	mkdir -p $@

$(DEPDIR)/%.d: $(DOCSDIR)/%.3
	sed -n -e 's|^\.so man[0-9]/\(.*\.[0-9]\).*|/$(DOCSDEST)/$*.html: $(DOCSDIR)/\1|p' < $< > $@

$(DOCSDEST)/%.html: $(DOCSDIR)/%.3 $(DEPDIR)/%.d
	$(MAN2HTML) < $< > $(DOCSDEST)/$*.raw
	echo "---\nlayout: page\ntitle: $*\n---" > $(DOCSDEST)/$*.html
	cat $(DOCSDEST)/$*.raw >> $(DOCSDEST)/$*.html
	rm -f $(DOCSDEST)/$*.raw

security.md: c-ares.git/SECURITY.md
	echo "---\nlayout: page\ntitle: \"c-ares Security Policies and Procedures\"\n---" > $@
	cat $< >> $@

license.md: c-ares.git/LICENSE.md
	echo "---\nlayout: page\ntitle: \"c-ares License\"\nmenu: License\n---" > $@
	cat $< >> $@

features.md: c-ares.git/FEATURES.md
	echo "---\nlayout: page\ntitle: \"\"\nmenu: Features\npermalink: /features/\n---" > $@
	cat $< >> $@

$(DEPFILES): $(DEPDIR)

include $(DEPFILES)

all: $(PAGES)

.PHONY: all

clean:
	find . -name "*~" -exec rm {} \;
	rm -rf $(PAGES) $(DOCSDEST)/*.raw
	rm -rf $(DEPDIR)

