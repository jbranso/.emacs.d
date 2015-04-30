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

## Default C-c <key> bindings

All of these key bindings can be found in lisp/init-editing-utilities.el

Keybinding         | Description
-------------------|------------------------------------------------------------
<kbd> C-c a </kbd> | highlight the whole buffer
<kbd> C-c b </kbd> | eval the whole buffer. ie: if it's lisp code, evaluate the code (eval-buffer)
<kbd> C-c d </kbd> | open dired in the current directory (dired-jump)
<kbd> C-c e </kbd> | use helm to select an emacs command (helm-M-x)
<kbd> C-c E </kbd> | open eshell (eshell)
<kbd> C-c f </kbd> | do a regexp search forward (isearch-forward-regexp)
<kbd> C-c F </kbd> | do a regular search forward (isearch-forward)
<kbd> C-c g </kbd> | open gnus (gnus)
<kbd> C-c h </kbd> | this is helm's command prefix and does nada
<kbd> C-c i </kbd> | prompts for an info manual name then opens it
<kbd> C-c l </kbd> | evaluate the last elisp express ie (dired-jump)
<kbd> C-c m </kbd> | opens up helm-mini, which is a nice way to open up recently visited files (helm-mini)
<kbd> C-c M </kbd> | ace-jump-mode
<kbd> C-c R </kbd>     | insert to the left of point
<kbd> C-c q </kbd>   | insert to the right of point
<kbd> C-c s </kbd> | undo last command
<kbd> C-c t </kbd>     | redo last command
<kbd> C-c x </kbd> | check the spelling of the current word
<kbd> j </kbd>     | join the lower line to the end of this line
<kbd> J </kbd>   | join the current line the end of the previous line
<kbd> m KEY </kbd>     | mark the current spot in the buffer with KEY
<kbd> ' KEY </kbd> | go to the marked KEY in the buffer
<kbd> ; </kbd>     | comment-dwin. This is an emacs command that either adds a comment to the current line, or if the line is highlighted, then it comments out the line
<kbd> q </kbd>     | save and quit the current buffer. This is the same as (save-buffer) (kill-buffer)
<kbd> C-w [h \| t \| n \| s] </kbd>     |  move to the up, down, left, or right window.  The syntax [ h \| t \| n \| s ] means that you have to pick either h, t, n, s.  So the only valid commands are C-w h, C-w t, C-w n, C-w s
<kbd> C-c r </kbd> |  This begins to define an evil macro.  In emacs state the binding for this in C-x (
<kbd> C-h </kbd>   |  insert a new line below point and switch to insert state
<kbd> C-t </kbd>   | insert a new line above point and switch to insert state.  The reader should not that this conflicts with the emacs binding of (transpose-chars), which I have rebound to (global-set-key (kbd "C-c t") 'transpose-chars)
<kbd> spacebar  </kbd> |  inserts a space.
<kbd> \>  </kbd>  | move point to the beginning of the buffer
<kbd> \<  </kbd>  | move point to the end of the buffer



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
