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
DOTFILES_zathras	 = .bashrc .bash_profile .gitignore .gitconfig .ssh/config
SOURCES_zathras		 = base zathras
ALLDOTFILES		+= $(DOTFILES_zathras:%=$(OUTDIR)/zathras/%)
out/zathras/%: force
	$(MKDOTFILE) $* out/zathras $(SOURCES_zathras)

# "vir" is a Helios development VM on "zathras"
DOTFILES_vir	 	 = .bashrc .bash_profile .gitignore .gitconfig
SOURCES_vir		 = base vir
ALLDOTFILES		+= $(DOTFILES_vir:%=$(OUTDIR)/vir/%)
out/vir/%: force
	$(MKDOTFILE) $* out/vir $(SOURCES_vir)

#
# "generic" is a general-purpose target that might be useful for random machines
# I want to copy a bashrc to.
#
DOTFILES_generic	 = .bashrc .bash_profile
SOURCES_generic	 	 = base
ALLDOTFILES		+= $(DOTFILES_generic:%=$(OUTDIR)/generic/%)
out/generic/%: force
	$(MKDOTFILE) $* out/generic $(SOURCES_generic)

# "awsdns" is for my personal DNS servers hosted on AWS.
DOTFILES_awsdns		 = .bashrc .bash_profile .gitignore .gitconfig
SOURCES_awsdns		 = base awsdns
ALLDOTFILES		+= $(DOTFILES_awsdns:%=$(OUTDIR)/awsdns/%)
out/awsdns/%: force
	$(MKDOTFILE) $* out/awsdns $(SOURCES_awsdns)

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
