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

;; (semantic-mode 1)

;; integration with imenu
;; (defun my-semantic-hook ()
;;   (imenu-add-to-menubar "TAGS"))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)

;; if I'm to use semantic, then I need to enable global ede mode.
;;(global-ede-mode t)
;; (ede-enable-generic-projects)

;;setting up ac

(require-package 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
;;(setq-default ac-expand-on-auto-complete nil)
(setq-default ac-expand-on-auto-complete t)
;;how long a word needs to be before auto-complete suggestions come up.
(setq-default ac-auto-start 3)
(setq-default ac-dwim t) ; To get pop-ups with docs even if a word is uniquely completed

;;----------------------------------------------------------------------------
;; Use Emacs' built-in TAB completion hooks to trigger AC (Emacs >= 23.2)
;;----------------------------------------------------------------------------
(setq tab-always-indent 'complete)  ;; use 't when auto-complete is disabled
(add-to-list 'completion-styles 'initials t)
;; Stop completion-at-point from popping up completion buffers so eagerly
(setq completion-cycle-threshold 5)

;; I don't know what these next few lines do.
;; this is how it was when I found it.
;; (setq c-tab-always-indent nil c-insert-tab-function 'indent-for-tab-command)
;; (setq c-tab-always-indent t
;;       c-insert-tab-function #'indent-for-tab-command)

;; hook AC into completion-at-point
;; (defun sanityinc/auto-complete-at-point ()
  ;; (when (and (not (minibufferp))
  ;;            (fboundp 'auto-complete-mode)
  ;;            auto-complete-mode)
    ;; (auto-complete)))

;; (defun sanityinc/never-indent ()
;;   (set (make-local-variable 'indent-line-function) (lambda () 'noindent)))

;; (defun set-auto-complete-as-completion-at-point-function ()
;;   (setq completion-at-point-functions
;;         (cons 'sanityinc/auto-complete-at-point
;;               (remove 'sanityinc/auto-complete-at-point completion-at-point-functions))))

;; what does this do?
;;(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

;; make expand be tab
(define-key ac-complete-mode-map "\t" #'ac-expand)
;; make complet by return
(define-key ac-complete-mode-map "\C-r" #'ac-complete)
;; I was going to make every up and down be t and h but too annoying
;;(define-key ac-complete-mode-map "\C-h" #'ac-next)
;;(define-key ac-complete-mode-map "\C-t" #'ac-previous)

(set-default 'ac-sources
             '(;;ac-source-imenu
               ;;ac-source-yasnippet
               ac-source-dictionary
               ;;ac-source-words-in-buffer
               ;; ac-source-semantic
               ;;ac-source-words-in-same-mode-buffers
               ac-source-words-in-all-buffer))

(dolist (mode '(magit-log-edit-mode
                log-edit-mode org-mode text-mode
                git-commit-mode
                ;; sass-mode espresso-mode
                html-mode smarty-mode
                ;; clojure-mode
                lisp-mode
                ;; textile-mode markdown-mode
                js3-mode css-mode
                ;; less-css-mode
                sql-mode
                sql-interactive-mode
                inferior-emacs-lisp-mode))
  (add-to-list 'ac-modes mode))


;; Exclude very large buffers from dabbrev
(defun sanityinc/dabbrev-friend-buffer (other-buffer)
  (< (buffer-size other-buffer) (* 1 1024 1024)))

;; I don't know what this does.
;; (setq dabbrev-friend-buffer-function 'sanityinc/dabbrev-friend-buffer) ;

(provide 'init-cedet)
