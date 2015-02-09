
;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(let ((minver "23.3"))
  (when (version<= emacs-version "23.1")
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* t) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))


;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
(require 'init-preload-local nil t)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

;;I can't get use-package to work.
;;(require-package 'use-package)
;; I haven't used this yet so...
;; but it allows you to use grep and edit the grep buffer, which will also write to the files.
;;(require-package 'wgrep)
(require-package 'project-local-variables)
;; this helps you minizize modeline clutter by hidding some modes on the mode line.
;; http://www.emacswiki.org/emacs/DiminishedModes
(require-package 'diminish)
;; Scratch lets you make a buffer for a particular mode.  It lets you play with some code, and then put it in your own file.
;; kind of silly.
;;(require-package 'scratch)
;; But I have to initialize it...It will not record commands by default.
;;(require-package 'mwe-log-commands)

;;(require 'init-frame-hooks)
;;(require 'init-xterm)
;;(require 'init-gui-frames)
;; I don't think I'll need this.
;; (require 'init-dired)
;; (require 'init-isearch)
;; (require 'init-grep)
;; (require 'init-uniquify)
;; (require 'init-ibuffer)

;;(require 'init-recentf)
(require 'init-cedet)
;; (require 'init-yasnippet)
;; (require 'init-windows)
;; this file saves all open buffers. It is so useful!
;; (require 'init-sessions)
;; (require 'init-fonts)
(require 'init-helm)
(require 'init-projectile)

(require 'init-editing-utils)
;; (require 'init-evil)

(require 'init-vc)
;; I've no idea what this does
;; http://alexott.net/en/writings/emacs-vcs/EmacsDarcs.html
;;(require 'init-darcs)
(require 'init-git)
(require 'init-github)

;; (require 'init-compile)

(require 'init-javascript)
(require 'init-org)
(require 'init-text)
(require 'init-html)
(require 'init-css)
(require 'init-python-mode)
(require 'init-sql)

;; (require 'init-paredit)
(require 'init-lisp)
(require 'init-clojure)
(when (>= emacs-major-version 24)
  (require 'init-clojure-cider))
(require 'init-common-lisp)

(require 'init-misc)

;; use the command line accounting tool ledger
;;(require 'init-ledger)
;; Extra packages which don't require any configuration

;; (require-package 'gnuplot)
;; (require-package 'lua-mode)
;; (require-package 'htmlize)
;; (require-package 'dsvn)

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
;; (require 'server)
;; (unless (server-running-p)
;;   (server-start))

;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(when (file-exists-p (expand-file-name "init-local.el" user-emacs-directory))
  (error "Please move init-local.el to ~/.emacs.d/lisp"))
(require 'init-local nil t)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)

(add-hook 'after-init-hook
          (lambda ()
            (message "init completed in %.2fms"
                     (sanityinc/time-subtract-millis after-init-time before-init-time))))


(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
