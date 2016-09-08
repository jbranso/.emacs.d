;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

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
(eval-when-compile
  (require 'use-package))
;; diminish hides packages from being on the modeline.  You can use use-package to do this
(require 'diminish)
;; to use :bind with use-package, require bind-key
(require 'bind-key)
(require 'use-package)
;; make use-package tell me which packages take longer than 0.1s to load
(setq use-package-verbose t)
;; this was for our emacs meetup group
;; slack is proprietary.  We should not use it
;;(require 'init-pdf-tools)
(dolist (file '(
                "init-autoinsert.org"
                ;; turn on abbrev mode.  it implements autocorrect
                ;; load in many packages that don't really need their own file.
                "init-load-small-packages.org"
                ;; make emacs indent your code all the time, so you don't have to
                "init-aggressive-indent.org"
                ;; emacs can read email
                "init-gnus.org"
                ;; some graphical configurations
                "init-gui-frames.org"
                ;; my org configurations
                "init-org.org"
                ))
  (org-babel-load-file (concat "~/.emacs.d/lisp/" file)))
;; read email in emacs
;;(require 'init-mu4e)
;; an irc client for emacs
(require 'init-erc)
;; ido mode stinks, I'm so glad helm is here.
(require 'init-helm)
(require 'init-editing-utils)
;; let's get modal keybinding working!
(require 'init-evil)
;; the upstream git repo is apparently broken now,  I'll get this fixed later
(require 'init-lisp)
(require 'init-javascript)
(require 'init-html)
(require 'init-org2blog)
(require 'init-defuns)
(require 'init-misc)
;; woo hoo!  I should customize it a bit to make it even prettier
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

(org-babel-load-file "~/.emacs.d/lisp/init-misc.org")

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
