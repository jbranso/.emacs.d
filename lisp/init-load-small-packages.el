;; -*- lexical-binding: t -*-

(global-auto-revert-mode 1)

(setq auto-revert-verbose nil)

(setq global-auto-revert-non-file-buffers t)

(add-hook 'after-init-hook 'show-paren-mode)
;;(show-paren-mode 1)

(add-hook 'after-init-hook 'electric-pair-mode)
;;(electric-pair-mode t)

(use-package anzu
    :ensure t
    :diminish anzu-mode
    :config (global-anzu-mode 1)
    :defer t)

;;(add-hook 'after-init-hook 'global-anzu-mode)

(add-hook 'after-init-hook 'global-visual-line-mode)
(global-set-key (kbd "C-c q") #'fill-paragraph)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.mdwn\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package avy
  :ensure t
  :defer t
  :config
  (setq avybackground t
   avy-highlight-first t)
  ;; https://github.com/abo-abo/avy
  ;; What does that do?
  (setq avy-keys (number-sequence ?e ?t )))

(add-to-list 'auto-mode-alist '("\\.defs?\\'" . c-mode))

(use-package which-key :ensure t :config (which-key-mode))

(add-hook 'prog-mode-hook (lambda ()
                            (flyspell-prog-mode)))
                            ;;(unbind-key (kbd "C-c $") flyspell-mode-map)
                            ;;(global-set-key (kbd "C-c $") #'endless/ispell-word-then-abbrev))

;; enable flyspell mode for all of my text modes.  This will enable flyspell to underline misspelled words.
(add-hook 'text-mode-hook (lambda ()
                            (flyspell-mode)))

;;(unbind-key (kbd "C-c $") flyspell-mode-map)
;;(global-set-key (kbd "C-c $") #'endless/ispell-word-then-abbrev))

(use-package aggressive-indent :ensure t
    :defer t
    :config
    (add-to-list 'aggressive-indent-excluded-modes 'web-mode)
    (add-to-list 'aggressive-indent-excluded-modes 'org-mode))
    (aggressive-indent-mode 1)
    ;;(add-hook 'after-init-hook 'global-aggressive-indent-mode)
;;    (add-hook 'prog-mode-hook #'aggressive-indent-mode)

(use-package async
  :ensure t
  :defer t
  ;;:config
  ;; enable async compilation of melpa packages
  ;;(async-bytecomp-package-mode 1)
)

(use-package helm-projectile :ensure t :defer t)
(use-package projectile :diminish projectile-mode
  :config
  (setq projectile-enable-caching t)
  (eval-after-load 'projectile-mode 'helm-projectile-on)
  (setq projectile-completion-system 'helm)
  (projectile-global-mode)
  :ensure t)

;;(add-hook 'after-init-hook #'projectile-global-mode)

(use-package diff-hl :defer t :ensure t)
(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)

(use-package alert :ensure t :defer t)

(use-package restclient :ensure t
  :mode (("\\.http\\'" . restclient-mode)))

(use-package f :ensure t)
(require 'f)

(cond
 ((string-equal system-name "antelope")
  (setq epg-gpg-program "gpg"))
 ((string-equal system-name "parabola")
  (setq epg-gpg-program "gpg2"))
 ((string-equal system-name "GuixSD")
  (setq epg-gpg-program "gpg")))

(setq epg-gpg-program "gpg")

(when (and (display-graphic-p) (f-file? "~/.authinfo.gpg"))
  ;; only use the encrypted file.
  (setq auth-sources '("~/.authinfo.gpg"))
  ;;(require 'auth-source)
  )

(use-package golden-ratio
  :defer t
  :ensure t
  ;;let's not use golden ratio on various modes
  :config (setq golden-ratio-exclude-modes
                  '( "sr-mode" "ediff-mode" "ediff-meta-mode" "ediff-set-merge-mode" "gnus-summary-mode"
                     "magit-status-mode" "magit-popup-mode" "org-export-stack-mode"))
                     (golden-ratio-mode)

                     :diminish golden-ratio-mode)
;;  (add-hook 'after-init-hook 'golden-ratio-mode)

(defun my-ediff-turn-off-golden-ratio ()
    "This function turns off golden ratio mode, when I
  enter ediff."
    (interactive)
    (remove-hook 'window-configuration-change-hook 'golden-ratio)
    (remove-hook 'post-command-hook 'golden-ratio--post-command-hook)
    (remove-hook 'mouse-leave-buffer-hook 'golden-ratio--mouse-leave-buffer-hook)
    ;; I'm not sure what these functions did, but I guess golden ratio doesn't need them anymore?
    ;;(ad-deactivate 'other-window)
    ;;(ad-deactivate 'pop-to-buffer)
)

(add-hook 'ediff-mode-hook #'my-ediff-turn-off-golden-ratio)

(add-hook 'ediff-quit-merge-hook #'golden-ratio)

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
  (use-package ag :defer t :ensure t)
  (use-package wgrep-ag :defer t :ensure t)
  (setq-default ag-highlight-search t))

(setenv "PAGER" "cat")

(add-hook 'eshell-mode-hook '(lambda ()
                              (setq shell-aliases-file "~/.emacs.d/alias")))

(use-package smart-comment
  :ensure t
  :bind ("C-c ;" . smart-comment)
  :config
  (with-eval-after-load 'org
    (local-unset-key "C-c ;")))

(defun my/add-extra-prettify-symbols ()
  (global-prettify-symbols-mode 1)
  (mapc (lambda (pair) (push pair prettify-symbols-alist))
        '(
          (">=" . ?≥)
          ("<=" . ?≤)
          ("\\geq" . ?≥)
          ("\\leq" . ?≤)
          ("\\neg" . ?¬)
          ("\\rightarrow" . ?→)
          ("\\leftarrow" . ?←)
          ("\\infty" . ?∞)
          ("-->" . ?→)
          ("<--" . ?←)
          ("\\exists" . ?∃)
          ("\\nexists" . ?∄)
          ("\\forall" . ?∀)
          ("\\or" . ?∨)
          ("\\and" . ?∧)
          (":)" . ?☺)
          ("):" . ?☹)
          (":D" . ?☺)
          ("\\checkmark" . ?✓)
          ("\\check" . ?✓)
          ("1/4" . ?¼)
          ("1/2" . ?½)
          ("3/4" . ?¾)
          ("1/7" . ?⅐)
          ;; ⅕ ⅖ ⅗ ⅘ ⅙ ⅚ ⅛ ⅜ ⅝ ⅞
          ("ae" . ?æ)
          ("^_^" . ?☻)
          ("function" .?ϝ)
          )))
(add-hook 'after-init-hook 'my/add-extra-prettify-symbols)

(use-package suggest :ensure t :defer t)

(require 'uniquify)

(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator " • ")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

(use-package all-the-icons :ensure t :defer t)
(use-package all-the-icons-dired :ensure t :defer)

(use-package json-mode :ensure t
  :mode
  ("\\.json\\'" . json-mode))

(use-package hideshow
  :bind (("C-x C-h" . hs-toggle-hiding)
         ("C-x C-S-+" . hs-show-all))
  :init (add-hook #'prog-mode-hook #'hs-minor-mode)
  :diminish hs-minor-mode
  :config
  (setq hs-special-modes-alist
        (mapcar 'purecopy
                '((c-mode "{" "}" "/[*/]" nil nil)
                  (c++-mode "{" "}" "/[*/]" nil nil)
                  (java-mode "{" "}" "/[*/]" nil nil)
                  (js-mode "{" "}" "/[*/]" nil)
                  (json-mode "{" "}" "/[*/]" nil)
                  (javascript-mode  "{" "}" "/[*/]" nil)))))

(after-load 'dired
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (dired-async-mode 1))

(use-package dired+ :ensure t)

(use-package dired-details :ensure t
  :config
  (setq-default dired-details-hidden-string "--- "))

(use-package dired
  ;; before loading dired, set these variables
  :init (setq-default diredp-hide-details-initially-flag nil
                      dired-dwim-target t
                      ;;omit boring auto save files in dired views
                      dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$")
  :config ;; after loading dired, do this stuff
  (load "dired-x")
  (setq wdired-allow-to-change-permissions t)
  :bind
  (:map dired-mode-map
        ("/" . helm-swoop)
        ([mouse2] . dired-find-file)))

(with-eval-after-load 'dired
  (add-hook 'dired-mode-hook 'dired-omit-mode)
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(defun ora-ediff-files ()
  (interactive)
  (let ((files (dired-get-marked-files))
        (wnd (current-window-configuration)))
    (if (<= (length files) 2)
        (let ((file1 (car files))
              (file2 (if (cdr files)
                         (cadr files)
                       (read-file-name
                        "file: "
                        (dired-dwim-target-directory)))))
          (if (file-newer-than-file-p file1 file2)
              (ediff-files file2 file1)
            (ediff-files file1 file2))
          (add-hook 'ediff-after-quit-hook-internal
                    (lambda ()
                      (setq ediff-after-quit-hook-internal nil)
                      (set-window-configuration wnd))))
      (error "no more than 2 files should be marked"))))

(define-key dired-mode-map "e" 'ora-ediff-files)

(use-package ebdb :ensure t :defer t)

(use-package yasnippet
  ;;adding defer t makes yasnippet NOT be loaded
;;  :defer t
  :ensure t
  :init
  (add-to-list 'load-path "~/.emacs.d/snippets")
  ;; (define-key company-mode-map (kbd "TAB") #'yas-expand)

  ;; (define-key company-mode-map (kbd "<tab>") #'yas-expand)
  :config (yas-global-mode 1))
  ;; (add-hook 'after-init-hook 'yas-global-mode)

(with-eval-after-load 'warnings
  (add-to-list 'warning-suppress-types '(yasnippet backquote-change)))

(use-package nov :ensure t
  :mode ("\\.epub\\'" . nov-mode))

(use-package company :ensure t
  :config
  (setq company-idle-delay .2)
  (define-key company-active-map "\C-n" #'company-select-next)
  (define-key company-active-map "\C-p" #'company-select-previous)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  (global-company-mode 1))

  ;;(add-hook 'after-init-hook 'global-company-mode)

(dolist (hook '(prog-mode-hook
                text-mode-hook
                org-mode-hook))
  (add-hook hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   '((company-dabbrev-code company-yasnippet))))))

(use-package flycheck-pos-tip :ensure t :defer t)

(use-package flycheck-status-emoji :ensure t)

(use-package flycheck-color-mode-line :ensure t)

(use-package flycheck
  :defer t
  :ensure t
  :config
  (flycheck-color-mode-line-mode)
  (flycheck-pos-tip-mode)
  (flycheck-status-emoji-mode)
  (global-flycheck-mode
  ))

  ;; (add-hook 'after-init-hook 'global-flycheck-mode)

(use-package lua-mode :ensure t
    :mode ("\\.lua\\'" . lua-mode))

;; (use-package ido-ubiquitous :ensure t)

(use-package magit :defer t :ensure t)
;;(use-package git-blame :ensure t :defer t)

(use-package fullframe :ensure t :defer t)
(after-load 'magit (fullframe magit-status magit-mode-quit-window))

(add-hook 'ediff-prepare-buffer-hook #'outline-show-all)

(add-hook 'ediff-load-hook #'(lambda () (scroll-bar-mode -1)))
(add-hook 'ediff-suspend-hook #'scroll-bar-mode)
(add-hook 'ediff-quit-hook #'scroll-bar-mode)

(after-load 'magit (diminish 'magit-auto-revert-mode))

(setq-default
 magit-save-some-buffers nil
 magit-diff-refine-hunk t)

(setq magit-process-popup-time 15)

(use-package gitignore-mode  :defer t :ensure t)
(use-package gitconfig-mode  :defer t :ensure t)

(use-package git-timemachine :ensure t :defer t)

(use-package git-messenger :defer t :ensure t)
(global-set-key (kbd "C-x v p") #'git-messenger:popup-message)

(use-package rainbow-mode :ensure t :defer t)
(dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
  (add-hook hook 'rainbow-mode))

(use-package css-eldoc :ensure t :defer t)

;;(autoload 'turn-on-css-eldoc "css-eldoc")
(add-hook 'css-mode-hook 'css-eldoc-enable)

(add-hook 'css-mode-hook 'emmet-mode) ;; enable Emmet's css abbreviation.

(use-package better-shell :ensure t :defer t)

(use-package helm :ensure t :defer t)
(use-package helm-swoop :ensure t :defer t)
(use-package helm-flx :ensure t :defer t
  :init (helm-flx-mode +1))

(defun my/config-helm-function ()
  "This just sets up helm."
  (require 'helm-config)
  (helm-mode 1)
  ;;(define-key helm-map (kbd "C-<return>") 'helm-execute-persistent-action)
  ;;(define-key helm-find-files-map (kbd "<tab>") 'helm-ff-RET)
  ;;(define-key helm-map (kbd "<backtab>") 'helm-select-action)
  (global-set-key (kbd "C-x r b") #'helm-bookmarks))

(add-hook 'after-init-hook 'my/config-helm-function)

(setq
 ;;don't let helm swoop guess what you want to search... It is normally wrong and annoying.
 helm-swoop-pre-input-function #'(lambda () (interactive))
 ;; tell helm to use recentf-list to look for files instead of file-name-history
 helm-ff-file-name-history-use-recentf t
 ;; let helm show 2000 files in helm-find-files
 ;; since I let recent f store 2000 files
 helm-ff-history-max-length 1000
 ;; I've set helm's prefix key in init-editing utils
 ;; don't let helm index weird output files from converting .tex files to pdf for example
 helm-ff-skip-boring-files t
 ;;make helm use the full frame. not needed.
 ;; helm-full-frame t
 ;; enable fuzzy mating in M-x
 ;;helm-M-x-fuzzy-match t
 ;;helm-recentf-fuzzy-match t
 ;;helm-apropos-fuzzy-match t
;;the more of these sources that I have, the slower helm will be
 helm-for-files-preferred-list '(
                                 helm-source-buffers-list
                                 helm-source-recentf
                                 helm-source-bookmarks
                                 helm-source-file-cache
                                 helm-source-files-in-current-dir
                                 ;;helm-source-locate
                                 ;;helm-source-projectile-files-in-all-projects-list
                                 ;;helm-source-findutils
                                 ;;helm-source-files-in-all-dired
                                 ))

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(use-package zpresent :ensure t :defer t)

(use-package ledger-mode :ensure t
  :mode
  ("\\.ledger?\\'" . ledger-mode))

(use-package smart-mode-line-powerline-theme :ensure t)

(use-package smart-mode-line :ensure t
  :init
  (setq sml/theme 'powerline)
  ;; emacs keeps prompting me to run the smart-mode-line-theme.  This is a word around that I found on github
  (setq sml/no-confirm-load-theme t)
  (setq powerline-arrow-shape 'curve)
  (setq powerline-default-separator-dir '(right . left))
  (setq sml/mode-width 0)
  ;; this makes sure that the mode line doesn't go off the screen
  (setq sml/name-width 40)
  (sml/setup))

(use-package emms :ensure t
  :defer t
  :config
  (require 'emms-setup)
  (emms-all)
  (emms-default-players))

(dolist (hook '(
c-mode-hook
js2-mode-hook
css-mode-hook
php-mode-hook
web-mode-hook
emacs-lisp-mode-hook
))
  (progn
    (add-hook hook 'linum-mode)
    ;;(remove-hook hook 'linum-mode)
    ))

;; (use-package nlinum :ensure t)

(use-package debbugs :ensure t :defer t)

(provide 'init-load-small-packages)
