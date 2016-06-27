;; Setting up semantic mode.
;; This is where I'm getting all of this info from http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html
;; A good config comes from here:
;; https://gist.github.com/alexott/3968635
;;(require 'semantic-decorate-include)
;;(require 'semantic-gcc)
;;(require 'semantic-ia)
;;(require 'eassist)
;;(require 'semantic-lex-spp)

;;(setq senator-minor-mode-name "SN")
;;(setq semantic-imenu-auto-rebuild-directory-indexes nil)
;;(global-srecode-minor-mode 1)
;;(global-semantic-mru-bookmark-mode 1)
;;(global-semantic-tag-folding-mode 1)

;;(setq cedet-root-path (file-name-as-directory "/home/joshua/.emacs.d/"))

;;This file was causing a very bizzare error... with helm-mini. But it should not be doing it anymore.
;; The first element in the quote below use to say
;; "home/joshua/.emacs.d/", which was missing the initial "/", but it should be working fine now.
;; (setq semanticdb-project-roots (quote ( /home/joshua/.emacs.d/ /home/joshua/.emacs.d/lisp /home/joshua/programming/bash/
;;                                                                /home/joshua/programming/c/ /home/joshua/programming/gnu/wget/
;;                                                                /home/joshua/programming/emacs/evil-dvorak
;;                                                                /home/joshua/programming/gcc/)))

;; specify all the semantic submodules you want to use.
;; activates highlighting of the current tag function and class under point
;; (add-to-list 'semantic-default-submodes global-semantic-highlight-func-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
;; (add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
;; this should echo some information about the symbol or function at point in the echo area.
;; it is like eldoc, but I have not gotten it to work.
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
;;this will put up triangles on the fringes where I can fold code
;; I can also do this with senator-fold-tag
;; (add-to-list 'semantic-default-submodes 'global-semantic-tag-folding-mode)
;; this is not being found
;; global-cedet-m3-minor-mode
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)

;; I'm going to try out semantic mode again.  It will only be enabled in
;; C, C++, Scheme, Javascript-mode, Java, HTML-mode, SRecode, Make, texinfo, python-mode files

;;(semantic-mode 1)

;; integration with imenu
;; (defun my-semantic-hook ()
;;   (imenu-add-to-menubar "TAGS"))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)

;; if I'm to use semantic, then I need to enable global ede mode.
;;(global-ede-mode t)
;; (ede-enable-generic-projects)

;;setting up ac
(use-package auto-complete
  :ensure t
  :diminish auto-complete-mode
  :init  (progn
           (require 'auto-complete-config)

           ;; I'm adding the next 3 lines from following this website
           ;; https://truongtx.me/2013/01/06/config-yasnippet-and-autocomplete-on-emacs/
           (ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
           (ac-set-trigger-key "TAB")
           (ac-set-trigger-key "<tab>")
           (global-auto-complete-mode t)
           (setq-default ac-delay .3)
           ;;(setq-default ac-expand-on-auto-complete nil)
           ;; expand a common part of whole candidates
           ;; it doesn't work well.
           (setq-default ac-expand-on-auto-complete nil)
           ;;a word must be 3 chars long before completition begins
           (setq-default ac-auto-start 2)
           (setq-default ac-dwim t) ; To get pop-ups with docs even if a word is uniquely completed

           ;;----------------------------------------------------------------------------
           ;; Use Emacs' built-in TAB completion hooks to trigger AC (Emacs >= 23.2)
           ;;----------------------------------------------------------------------------
           (setq tab-always-indent 'complete)  ;; use 't when auto-complete is disabled
           ;;(add-to-list 'completion-styles 'initials t)
           ;; Stop completion-at-point from popping up completion buffers so eagerly
           ;;(setq completion-cycle-threshold 5)

           ;; make expand be tab
           (define-key ac-complete-mode-map "\t" #'ac-expand)
           ;; make complete by return
           (define-key ac-complete-mode-map "\C-m" #'ac-complete)
           ;; Make C-n and C-p mean go up and down on the completion list
           (define-key ac-complete-mode-map "\C-n" #'ac-next)
           (define-key ac-complete-mode-map "\C-p" #'ac-previous)
           (setq ac-quick-help-delay .3)
           (setq ac-candidate-limit 100)

           (set-default 'ac-sources
                        '(
                          ;;ac-source-imenu
                          ac-source-filename
                          ;;ac-source-dictionary
                          ac-source-words-in-buffer
                          ;;useful for eshell
                          ac-source-files-in-current-dir))

           (setq-default ac-use-fuzzy nil)))

(dolist (mode '(
                magit-log-edit-mode
                log-edit-mode
                org-mode
                text-mode
                git-commit-mode
                ;; sass-mode espresso-mode
                ;; smarty-mode
                html-mode
                ;; clojure-mode
                lisp-mode
                ;; textile-mode markdown-mode
                ;;js3-mode
                css-mode
                ;; less-css-mode
                ;; sql-mode
                eshell-mode
                ;; sql-interactive-mode
                ;; don't specify web-mode here, web-mode has its own way of specifying what ac sources to use
                js2-mode
                inferior-emacs-lisp-mode))
  (add-to-list 'ac-modes mode))


;; Exclude very large buffers from dabbrev
(defun sanityinc/dabbrev-friend-buffer (other-buffer)
  (< (buffer-size other-buffer) (* 1 1024 1024)))

(provide 'init-cedet)
