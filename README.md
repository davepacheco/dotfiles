# dotfiles

Lots of people have written tools to manage their dotfiles.  This one's mine.
It's not written for anyone else, but you're welcome to try.

The design principles are:

* There are several different configurations: my home laptop, my work laptop,
  work development machines, and so on.
* To the extent possible, these should share common file fragments so that when
  I add aliases or the like, I don't have to do it in several places.
* Each configuration may have its own custom fragments, since lots of
  configuration applies only to one or two of them.
* It should be very easy to apply dotfiles to a brand new machine.
* I want the implementation to be very straightforward.  I don't care too much
  about UX.  It's a dev tool, only intended for me.

## Dotfiles fragments

In the top-level of this repo are directories for the various configurations.
There are also directories for common hunks (e.g., "base", which is incorporated
into all configurations; or "joyent", which is incorporated into several
work-related configurations).  These directories contain fragments of dotfiles.

## Configuring and building

The configurations are defined in the top-level Makefile, and you build all
dotfiles by just typing "make".  Here's an example configuration for my machine
"spike":

    DOTFILES_spike               = .bashrc .bash_profile
    SOURCES_spike                = base joyent
    ALLDOTFILES                 += $(DOTFILES_spike:%=$(OUTDIR)/spike/%)
    out/spike/%: force
        $(MKDOTFILE) $* out/spike $(SOURCES_spike)

This says that for "spike", we're building ".bashrc" and ".bash\_profile", and
we do it by combining the fragments from the "base" and "joyent" configurations.

When you type "make", the dotfiles for each configuration are built from the
various fragments, as configured in the Makefile.  The outputs go into
"out/$config\_name" in the root of the repository.
