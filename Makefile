#
# Makefile for simple dotfiles.  We make dotfiles for several different
# TARGETS (e.g., "my_laptop", "work_laptop", "generic", and so on).  Each
# dotfiles consists of concatenating dotfiles from one of several source GROUPS
# (e.g., "base", "work", "macos", and so on).
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

# "zathras" is my personal laptop
DOTFILES_zathras	 = .bashrc .bash_profile .editrc .gitignore .gitconfig .ssh/config
SOURCES_zathras		 = base oxide zathras
ALLDOTFILES		+= $(DOTFILES_zathras:%=$(OUTDIR)/zathras/%)
out/zathras/%: force
	$(MKDOTFILE) $* out/zathras $(SOURCES_zathras)

# "ivanova" is a Helios development machine
DOTFILES_ivanova	 = .bashrc .bash_profile .editrc .gitignore .gitconfig
SOURCES_ivanova		 = base oxide ivanova
ALLDOTFILES		+= $(DOTFILES_ivanova:%=$(OUTDIR)/ivanova/%)
out/ivanova/%: force
	$(MKDOTFILE) $* out/ivanova $(SOURCES_ivanova)

#
# "generic" is a general-purpose target that might be useful for random machines
# I want to copy a bashrc to.
#
DOTFILES_generic	 = .bashrc .bash_profile .editrc 
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
# The COPYFILE_DISABLE prevents OS X tar from creating extra files for extended
# attributes.
#
$(TARFILE): $(ALLDOTFILES)
	COPYFILE_DISABLE=1 tar cf $@ -C out $(^:out/%=%)

.PHONY: force
force:
