;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;;(require 'init-benchmarking) ;; Measure startup time

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------

;; this is supposed to be a big performance win
;; https://www.reddit.com/r/emacs/comments/4c0mi3/the_biggest_performance_improvement_to_emacs_ive/h
;; (remove-hook 'find-file-hooks 'vc-find-file-hook)

(require 'init-utils)
(require 'init-elpa)     ;; Machinery for installing required packages


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
;;(require 'init-preload-local nil t)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require-package 'use-package)
;; diminish hides packages from being on the modeline.  You can use use-package to do this
(use-package diminish :ensure t)
;; to use :bind with use-package, require bind-key
(use-package bind-key :ensure t)
;; make use-package tell me which packages take longer than 0.1s to load
(setq use-package-verbose t)
;;Make Emacs load in bug hunter early.  That way I can almost always
;; easily debug my init file.
(org-babel-load-file "~/.emacs.d/lisp/init-bug-hunter.org")
;; let's get modal keybinding working!
;; And let's load it in quickly, so I can always use evil-mode
;; even when my config is broken.
(require 'init-evil)
;;(require 'init-pdf-tools)
;; make opening specific types of files,
;; autoinsert a yasnippet
(org-babel-load-file "~/.emacs.d/lisp/init-autoinsert.org")
;;load is many packages
(org-babel-load-file 	"~/.emacs.d/lisp/init-load-small-packages.org")
;; make emacs indent your code all the time, so you don't have to
(org-babel-load-file 	"~/.emacs.d/lisp/init-aggressive-indent.org")
;; emacs can read email
(org-babel-load-file 	"~/.emacs.d/lisp/init-gnus.org")
;; some graphical configurations
(org-babel-load-file 	"~/.emacs.d/lisp/init-gui-frames.org")
;; my org configurations
(org-babel-load-file 	"~/.emacs.d/lisp/init-org.org")
(org-babel-load-file 	"~/.emacs.d/lisp/init-lisp.org")
(org-babel-load-file 	"~/.emacs.d/lisp/init-javascript.org")
(org-babel-load-file 	"~/.emacs.d/lisp/init-editing-utils.org")
;;an irc client for Emacs
(org-babel-load-file 	"~/.emacs.d/lisp/init-erc.org")


;; read email in emacs
;;(require 'init-mu4e)
(require 'init-html)
(require 'init-projectile)
;; let's write my wordpress blog in emacs
;;(require 'init-org2blog)
(require 'init-defuns)
;; Let's make a smart mode-line
(require 'init-smart-mode-line)
;; Make my evil keybindings work pretty much everywhere
(require 'init-evil-rebellion-clone)

(org-babel-load-file 	"~/.emacs.d/lisp/init-misc.org")
;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; ert is the emacs lisp regression test.  It lets you test that your lisp files
;; pass defined tests
(require 'init-ert)

;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init.el ends here
;;(put 'scroll-left 'disabled nil)
;;(put 'set-goal-column 'disabled nil)
