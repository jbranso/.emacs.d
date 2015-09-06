;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;;(require 'init-benchmarking) ;; Measure startup time

;; I don't use it, why have it?
;;(defconst *spell-check-support-enabled* t) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
;; initialize cedet before elpa, just in case.
;;(load-file "/home/joshua/.emacs.d/cedet/cedet-devel-load.el")
;; https://github.com/jwiegley/use-package

(require 'init-utils)
(require 'init-elpa)      ;; Machinery for installing required packages
;;(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
;;(require 'init-preload-local nil t)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

;;I can't get use-package to work.
;;(require-package 'use-package)
;;(require-package 'wgrep)
;;(require-package 'project-local-variables)
;; this helps you minizize modeline clutter by hidding some modes on the mode line.
;; http://www.emacswiki.org/emacs/DiminishedModes

;; this will be cool to monitor my commands.
;; But I have to initialize it...It will not record commands by default.
(require-package 'mwe-log-commands)
(mwe:log-keyboard-commands)

(require 'init-powerline-evil)
(require 'init-gnus)
(require 'init-vc)
(require 'init-gui-frames)
(require 'init-recentf)
(require 'init-dired)
(require 'init-grep)
(require 'init-erc)
(require 'init-eshell)
;; Nicer naming of buffers for files with identical names
;; Instead of Makefile<1> and Makefile<2>, it will be
;; Makefile | tmp  Makefile | lisp
;; It's a nice mode, but I'm not sure that I use it
;;(require 'init-uniquify)
;; this sets up paradox to use my private token to access public repos.
(require 'init-paradox)
(require 'init-recentf)
;;yasnippet needs to be loaded before auto complete to let them play nicely together
(require 'init-yasnippet)
(require 'init-cedet)
;; since I don't use it... why enable it?
;; this file saves all open buffers. It is so useful!
;;(require 'init-sessions)
(require 'init-helm)
;; projectile is not working, so why have it?
;;(require 'init-projectile)
(require 'init-org)
(require 'init-hydra)
(require 'sx) ;;searching stack exchange via emacs!  C-c S
(require 'init-editing-utils)
(require 'init-evil)

;; http://alexott.net/en/writings/emacs-vcs/EmacsDarcs.html
;;(require 'init-darcs)
(require 'init-git)
;;(require 'init-github)

(require 'init-lisp)
(require 'init-javascript)

(require 'init-html)
;;(require 'init-org2blog)
;;(require 'init-css)
;;(require 'init-python-mode)
(require 'init-defuns)

(require 'init-misc)

;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
