#
# Makefile for simple dotfiles.  We make dotfiles for several different
# TARGETS (e.g., "my_laptop", "work_laptop", "generic", and so on).  Each
# dotfiles consists of concatenating dotfiles from one of several source GROUPS
# (e.g., "base", "work", "macos", and so on).
#
# You configure this by updating 
#

.DEFAULT_GOAL: all

#
# For each new set of dotfiles (a TARGET), you'll want to set:
#
#     DOTFILES_$target		relative paths to dotfiles you want to create
#
#     SOURCES_$target		names of source groups whose dotfiles will be
#     				concatenated to produce each target dotfile
#
# You'll also want to:
#
#   - update ALLDOTFILES as shown below.
#
#   - define a target as shown below, under Targets
#
DOTFILES_spike		 = .bashrc .bash_profile
SOURCES_spike		 = base joyent
ALLDOTFILES		+= $(DOTFILES_spike:%=$(OUTDIR)/spike/%)
out/spike/%: force
	$(MKDOTFILE) $* out/spike $(SOURCES_spike)

DOTFILES_sharptooth	 = .bashrc .bash_profile
SOURCES_sharptooth	 = base joyent sharptooth
ALLDOTFILES		+= $(DOTFILES_sharptooth:%=$(OUTDIR)/sharptooth/%)
out/sharptooth/%: force
	$(MKDOTFILE) $* out/sharptooth $(SOURCES_sharptooth)

DOTFILES_generic	 = .bashrc .bash_profile
SOURCES_generic	 	 = base
ALLDOTFILES		+= $(DOTFILES_generic:%=$(OUTDIR)/generic/%)
out/generic/%: force
	$(MKDOTFILE) $* out/generic $(SOURCES_generic)

#
# You shouldn't need to modify anything below this line.
#

# Global configuration
OUTDIR			 = out
TARFILE			 = /tmp/dotfiles-bundle.tar
MKDOTFILE		 = ./tools/mkdotfile

# Targets
all: $(ALLDOTFILES)

clean:
	rm -rf $(OUTDIR) $(TARFILE)

#
# Publish dotfiles to /$MANTA_USER/public/lib/dotfiles
#
publish: $(TARFILE)
	muntar -f $(TARFILE) /$$MANTA_USER/public/lib/dotfiles
	rm -f $(TARFILE)

$(TARFILE): $(ALLDOTFILES) out/fetch-dotfiles
	tar cf $@ -C out $(^:out/%=%)

out/fetch-dotfiles: tools/fetch-dotfiles
	cp $^ $@

.PHONY: force
force:
