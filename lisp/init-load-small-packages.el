(dolist (hook '(org-mode-hook
                prog-mode-hook
                text-mode-hook))
  (add-hook hook (lambda ()
                   (abbrev-mode 1)
                   (diminish 'abbrev-mode))))

(use-package avy
  :ensure t
  :defer t
  :config
  (setq avybackground t
   avy-highlight-first t)
  ;; https://github.com/abo-abo/avy
  (setq  avy-keys (number-sequence ?e ?t )))

(dolist (hook '(org-mode-hook
                prog-mode-hook
                text-mode-hook))
  (add-hook hook (lambda ()
                   (abbrev-mode 1)
                   (diminish 'abbrev-mode))))

(org-babel-load-file "/home/joshua/programming/emacs/autocorrect/autocorrect.org" )

(use-package which-key :ensure t
  :config (which-key-mode))

(use-package bug-hunter :ensure t :defer t)

(add-hook 'prog-mode-hook (lambda ()
                            (flyspell-prog-mode)
                            (unbind-key (kbd "C-c $") flyspell-mode-map)
                            (global-set-key (kbd "C-c $") #'endless/ispell-word-then-abbrev)))

;; enable flyspell mode for all of my text modes.  This will enable flyspell to underline misspelled words.
(add-hook 'text-mode-hook (lambda ()
                            (flyspell-mode)
                            (unbind-key (kbd "C-c $") flyspell-mode-map)
                            (global-set-key (kbd "C-c $") #'endless/ispell-word-then-abbrev)))

(use-package aggressive-indent :ensure t :defer t)
;; it's probably a good idea NOT to enable aggressive indent mode globally.  web-mode has a hard time
;; indenting everything when the file gets big
(dolist (hook '(js2-mode-hook cc-mode css-mode emacs-lisp-mode-hook css-mode))
  (add-hook hook #'aggressive-indent-mode))

(use-package async
  :ensure t
  :defer t
  :config
  ;; enable async dired commands
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (dired-async-mode 1)
  ;; enable async compilation of melpa packages
  (async-bytecomp-package-mode 1))

(require 'bookmark)
(defhydra hydra-bookmark (:color pink :hint nil)
  "
^Edit^                   ^Jump^                    ^Set^
^^^^^^------------------------------------------------------
_e_: edit bookmarks     _j_ump to bookmark         _s_: set bookmark
_r_: rename             _J_ump to gnus bookmark    _S_: set a gnus bookmark
"
  ;; Edit
  ("e" edit-bookmarks :exit t)                ; Up
  ("r" helm-bookmark-rename :exit t)                ; Up

  ;; Jump
  ("j" bookmark-jump :exit t)          ; Show (expand) everything
  ("J" gnus-bookmark-jump :exit t)          ; Show (expand) everything

  ;; Set
  ("s" bookmark-set :exit t)    ; Hide everything but the top-level headings
  ("S" gnus-bookmark-set :exit t)    ; Hide everything but the top-level headings

  ("z" nil "leave"))

;; I want to set this hydra to a keybinding.  So I don't have to remember all of the keybindings
(global-set-key (kbd "C-c C-b") 'hydra-bookmark/body)
;; a ton of other modes try to set C-c C-b to a keybinding.  I am overriding them.
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-b") 'hydra-bookmark/body))
(with-eval-after-load 'web-mode
  (define-key web-mode-map (kbd "C-c C-b") 'hydra-bookmark/body))
(with-eval-after-load 'php-mode
  (define-key php-mode-map (kbd "C-c C-b") 'hydra-bookmark/body))

(use-package diff-hl
  :defer t
  :ensure t)
(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)

(use-package f :ensure t)

(cond
 ((string-equal system-name "antelope")
  (setq epg-gpg-program "gpg"))
 ((string-equal system-name "parabola")
  (setq epg-gpg-program "gpg2"))
 ((string-equal system-name "GuixSD")
  (setq epg-gpg-program "gpg")))

(setq epg-gpg-program "gpg")

(when (f-file? "~/.authinfo.gpg")
  ;; only use the encrypted file.
  (setq auth-sources '("~/.authinfo.gpg"))
  ;;(require 'auth-source)
  )

(use-package golden-ratio
  :defer t
  :ensure t
  :config (setq golden-ratio-exclude-modes
                '( "sr-mode" "ediff-mode" "ediff-meta-mode" "ediff-set-merge-mode" "gnus-summary-mode" ))
  :diminish golden-ratio-mode)
(add-hook 'after-init-hook 'golden-ratio-mode)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(when (display-graphic-p)
   (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

(defun my-recentf-startup ()
"My configuration for recentf."
(recentf-mode 1)

(setq recentf-max-saved-items 1000
      recentf-exclude '("/tmp/"
            "^.*autoloads.*$"
            "^.*TAGS.*$"
            "^.*COMMIT.*$"
            "^.*pacnew.*$"
                        ;; in case I ever want to exclude shh files, I can add this next line.
                        ;;  "/ssh:"
            ))

(add-to-list 'recentf-keep "^.*php$//")
(recentf-auto-cleanup))

(add-hook 'after-init-hook 'my-recentf-startup)

(setq-default grep-highlight-matches t
              grep-scroll-output t)

;; ag is the silver searcher.  It lets you search for stuff crazy fast
(when (executable-find "ag")
  (use-package ag
    :defer t
    :ensure t)
  (use-package wgrep-ag
    :defer t
    :ensure t)
  (setq-default ag-highlight-search t))

(setenv "PAGER" "cat")

(add-hook 'eshell-mode-hook (lambda ()
                              (setq
                               shell-aliases-file "~/.emacs.d/alias"
                               )))

(define-key Info-mode-map (kbd "C-w h") 'windmove-down)
(define-key Info-mode-map (kbd "C-w t") 'windmove-up)
(define-key Info-mode-map (kbd "C-w n") 'windmove-left)
(define-key Info-mode-map (kbd "C-w s") 'windmove-right)

(use-package smart-comment
  :ensure t
  :bind ("C-c ;" . smart-comment)
  :config
  (with-eval-after-load 'org
    (local-unset-key "C-c ;")))

(use-package wttrin
  :ensure t
  :commands (wttrin)
  :init
  (setq wttrin-default-cities
  '("West Lafayette")))

(defun weather ()
  "Show the local weather via wttrin"
  (interactive)
  (wttrin))

(add-hook 'after-init-hook 'global-prettify-symbols-mode)

(use-package suggest :ensure t)

(require 'uniquify)

(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator " • ")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

(provide 'init-load-small-packages)
