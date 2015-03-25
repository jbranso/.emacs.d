# My reasonable Emacs config

Not so long ago I forked Steve Purcell's emacs config.  You can find the original config here: https://github.com/purcell/emacs.d

My emacs config is still structured like Steve Purcell's.  All of my code for my init.el is in my lisp/ folder. Mostly, I have removed
some of the features that he added to his emacs config.  Most notably, I do not use mmm-mode (more than one major mode).  To edit web
pages, I use web-mode.el. This config also assumes you want to use evil-mode with a dvorak keyboard.  *If you like the qwerty keyboard layout and the default non-modal behavior of emacs, then you probably should not use this config.*

Emacs itself comes with support for many programming languages. This
config adds improved defaults and extended support for the following:

* CSS
* Javascript
* Python
* PHP (web-mode.el).
* Common Lisp (with Slime ?)
* evil-mode (vim like keybindings).
* evil-dvorak-mode (restructures vim's keybindings to work for dvorak keyboard layouts).
* helm (because ido is not nearly as cool)
* projectile (which I'm still trying to learn how to use)

Flycheck is used to immediately highlight syntax errors in Ruby, HAML,
Python, Javascript, PHP and a number of other languages.

## Requirements

* Emacs 23.3 or greater (note that Emacs 24 is required for some
  functionality, and will likely become the minimum required version
  some time soon.)
* To make the most of the programming language-specific support in
  this config, further programs will likely be required, particularly
  those that [flycheck](https://github.com/flycheck/flycheck) uses to
  provide on-the-fly syntax checking.

## Installation

To install, clone this repo to `~/.emacs.d`, i.e. ensure that the
`init.el` contained in this repo ends up at `~/.emacs.d/init.el`:

```
git clone https://github.com/purcell/emacs.d.git ~/.emacs.d
```

Upon starting up Emacs for the first time, further third-party
packages will be automatically downloaded and installed.

## Important note about helm

I use helm-mode instead of ido.  You should consider to use helm too. Helm-swoop alone is super amazing (although swiper.el, is nice too).  This config uses "C-c h" as the default helm keybinding.

## Important note about projectile

I also use projectile, which is a way to quickly navigate your way through lots of source code files.  Type "C-c p" to see a list
of options. I really like "C-c p h", which uses helm to navigate projectile's sources!

## Updates

Update the config with `git pull`. You'll probably also want/need to update
the third-party packages regularly too:

<kbd>M-x package-list-packages</kbd>, then <kbd>U</kbd> followed by <kbd>x</kbd>.

## Adding your own customization

To add your own customization, use <kbd>M-x customize</kbd> and/or
create a file `~/.emacs.d/lisp/init-local.el` which looks like this:

```el
... your code here ...

(provide 'init-local)
```

If you need initialisation code which executes earlier in the startup process,
you can also create an `~/.emacs.d/lisp/init-preload-local.el` file.

If you plan to customize things more extensively, you should probably
just fork the repo and hack away at the config to make it your own!

## Similar configs

You might also want to check out `emacs-starter-kit` and `prelude`.

## Support / issues

If you hit any problems, please first ensure that you are using the latest version
of this code, and that you have updated your packages to the most recent available
versions (see "Updates" above). If you still experience problems, go ahead and
[file an issue on the github project](https://github.com/jbranso/emacs.d).

-Joshua Branson

<hr>

[jbranso](http://web.ics.purdue.edu/~jbranso)
