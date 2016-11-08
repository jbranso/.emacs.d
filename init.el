;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(package-initialize)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;;(require 'init-benchmarking) ;; Measure startup time

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------

;; this is supposed to be a big performance win
;; https://www.reddit.com/r/emacs/comments/4c0mi3/the_biggest_performance_improvement_to_emacs_ive/h
(remove-hook 'find-file-hooks 'vc-find-file-hook)

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
;;(require 'init-pdf-tools)
(dolist (file '(
                ;; make opening specific types of files,
                ;; autoinsert a yasnippet
                ;;"init-autoinsert"
                ;;load is many packages
                "init-load-small-packages"
                ;; make emacs indent your code all the time, so you don't have to
                "init-aggressive-indent"
                ;; emacs can read email
                "init-gnus"
                ;; some graphical configurations
                "init-gui-frames"
                ;; my org configurations
                "init-org"
                "init-lisp"
                "init-javascript"
                "init-editing-utils"
                ;;an irc client for Emacs
                "init-erc"
                "init-misc"
                ))
  (org-babel-load-file (concat "~/.emacs.d/lisp/" file ".org")))
;; read email in emacs
;;(require 'init-mu4e)
;; let's get modal keybinding working!
(require 'init-evil)
(require 'init-html)
(require 'init-projectile)
;; let's write my wordpress blog in emacs
;;(require 'init-org2blog)
(require 'init-defuns)
;; Let's make a smart mode-line
(require 'init-smart-mode-line)
;; Make my evil keybindings work pretty much everywhere
(require 'init-evil-rebellion-clone)
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
(put 'set-goal-column 'disabled nil)
