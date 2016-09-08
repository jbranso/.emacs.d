;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

;; I can define some emacs testing of variables.  This will hopefully help me spot errors. cool.
;; (ert-deftest pp-test-quote ()
;;   "Tests the rendering of `quote' symbols in `pp-to-string'."
;;   (should (equal (pp-to-string '(quote quote)) "'quote"))
;;   (should (equal (pp-to-string '((quote a) (quote b))) "('a 'b)\n"))
;;   (should (equal (pp-to-string '('a 'b)) "('a 'b)\n")))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;;(require 'init-benchmarking) ;; Measure startup time

;; I don't use it, why have it?
;;(defconst *spell-check-support-enabled* t) ;; Enable with t if you prefer
;;(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
;; initialize cedet before elpa, just in case.
;;(load-file "/home/joshua/.emacs.d/cedet/cedet-devel-load.el")
;; https://github.com/jwiegley/use-package

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
(require 'init-eshell)
;;(require 'init-term)
;; paradox adds some nice features to emacs install packages
;; this sets up paradox to use my private token to access public repos.
;;(require 'init-paradox)
;; Nicer naming of buffers for files with identical names
;; Instead of Makefile<1> and Makefile<2>, it will be
;; Makefile | tmp  Makefile | lisp
;;(require 'init-uniquify)
;;I don't really use media wiki so.
;;(require 'init-mediawiki)
;; collection of IDE like features.  I can't get 'em to work
;; I should probably just try out company mode and forget about cedet.  Apparently semantic will work with
;; company mode anyway
;;(require 'init-cedet)
(dolist (file '(
                ;;I am having some issues with this at the moment.
                ;; "init-polymode.org"
                ;;yasnippet needs to be loaded before company to let them play nicely together
                "init-yasnippet.org"
                ))
  (org-babel-load-file (concat "~/.emacs.d/lisp/" file)))
(require 'init-company)
;; downcase words like THe and BEautiful
;; This is probably how I can embed yasnippets into various modes
;;(require 'init-dubcaps)
;; let's check for poor writing style
;;(require 'init-writegood)
;; let's check our code syntax of all program modes
(require 'init-flycheck)
;; id mode stinks, I'm so glad helm is here.
(require 'init-helm)
(require 'init-editing-utils)
;; let's get modal keybinding working!
(require 'init-evil)
;; the upstream git repo is apparently broken now,  I'll get this fixed later
(require 'init-lisp)
(require 'init-javascript)
(require 'init-html)
;;(require 'init-org2blog)
(require 'init-css)
;;(require 'init-python-mode)
(require 'init-defuns)
;; emacs can play music and stream it! (when streaming works)
;;(require 'init-emms)
;;get weather forcast in emacs
;;(require 'init-wttrin)
;; load a zenburn
(require 'init-misc)
;; woo hoo!  I should customize it a bit to make it even prettier
(require 'init-smart-mode-line)

;; make --> and /arrow look like utf8 chars
(require 'init-prettify)
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

;; I don't have autocorrect on this machine.
;;(require 'init-autocorrect)
;; until I get autocorrect on melpa, I'll have to manually turn on abbrev mode

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
