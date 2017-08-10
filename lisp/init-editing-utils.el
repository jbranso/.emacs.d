(when (find-font (font-spec :family "Hack"))
 (set-frame-font "Hack" nil t))

;;(add-to-list 'default-frame-alist '(font. "Hack Regular"))

(setq-default
 ;; It's much easier to move around lines based on how they are displayed, rather than the actual line. This helps a ton with long
 ;; log file lines that may be wrapped:
 line-move-visual t
 visible-bell t
 ring-bell-function 'ignore
 ;;blink-cursor-interval 0.4
 ;; I want to open links from org-mode in chromium
 ;;browse-url-browser-function (quote browse-url-chromium)
 browse-url-browser-function (quote browse-url-firefox)
 bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
 ;;original value was 30.  A large number slows down emacs a bit apparently
 buffers-menu-max-size 20
 case-fold-search t
 default-tab-width 4
 ;; I believe this sets up ediff to split the two windows horizontally AND to NOT show you all the commands
 ;; you can use on the two buffers that you are comapring
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 fill-column 130
 ;;when you are on the last line of the buffer, C-n will act like <return>
 next-line-add-newlines t
 indent-tabs-mode nil
 inhibit-splash-screen t
 inhibit-startup-echo-area-message t
 inhibit-startup-message t
 ;;make-backup-files nil
 initial-scratch-message nil
 ;; don't let the cursor go into minibuffer prompt
 ;; http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
 minibuffer-prompt-properties (quote (read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt))
 ;; this should turn off auto-saving the proper way.
 auto-save-default nil  ;; this will stop making #auto-save# files
 make-backup-files nil  ;; this will stop making backup~ files
 ;; make emacs save all backup~ files in this directory
 ;;backup-directory-alist '(("" . "~/.emacs.d/backups"))
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil)

(line-number-mode 0)
(column-number-mode 0)

(global-set-key (kbd "C-x C-k") #'delete-this-file)
(global-set-key (kbd "C-x C-r") #'rename-this-file-and-buffer)

(global-set-key (kbd "C-c .") #'xref-find-definitions)
(global-set-key (kbd "C-c C-h") #'help)
;;(global-set-key (kbd "C-c h k") #'helm-show-kill-ring)
(global-set-key (kbd "C-x f")   #'helm-find-files)
;;(global-set-key (kbd "C-c h o") #'helm-occur)
;;(global-set-key (kbd "C-c h c") #'helm-calcul-expression)
;;(global-set-key (kbd "C-c h g") #'helm-grep-do-git-grep)

(global-set-key (kbd "C-c t") #'transpose-chars)
(global-set-key (kbd "C-c T") #'transpose-words)

(global-set-key (kbd "C-x b") #'helm-buffers-list)

(global-set-key (kbd "s-;") #'web-mode-comment-or-uncomment)
(global-set-key (kbd "s-a") #'mark-whole-buffer)
(global-set-key (kbd "s-d") #'my/downcase-word)
(global-set-key (kbd "s-g") #'magit-status)
(global-set-key (kbd "s-h") #'mark-paragraph)
;; This causes ERC to connect to the Freenode network upon hitting mod-i
(global-set-key (kbd "s-i") (lambda () (interactive)
                              (erc :server "irc.freenode.net" :port "6667"
                                   :nick "jbranso")))
(defun my/save-all-buffers ()
  (interactive)
  (save-some-buffers 1))

(global-set-key (kbd "s-s") 'my/save-all-buffers)
(global-set-key (kbd "s-u") #'my/uppercase-word)

(buffer-file-name)

(global-set-key (kbd "C-c TAB") #'indent-whole-buffer)
;; when point is between two words, delete the space between them
(global-set-key (kbd "C-c \\") #'delete-horizontal-space)
(global-set-key (kbd "C-c SPC") #'just-one-space)
;; some modes my default / in normal mode is NOT bound to helm-swoop, BUT I REALLY LIKE helm-swoop
(global-set-key (kbd "C-c /") #'helm-swoop)
(global-set-key (kbd "C-c C-o") #'org-open-at-point-global)
;; this is bound in init-smart-comment.el
;;(global-set-key (kbd "C-c ;") #'comment-dwim)
;;(define-key global-map (kbd "C-c a") 'org-agenda)

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") #'(lambda ()
                                  "Switch to the previous buffer"
                                  (interactive)
                                  (switch-to-buffer nil)))
(global-set-key (kbd "C-c B") #'browse-kill-ring)
(global-set-key (kbd "C-c C") #'hydra-org-timer/body)
;;org-capture is SOOO helpful!!
(global-set-key (kbd "C-c c") 'org-capture)
;;open up a new dired window for the current directory
(global-set-key (kbd "C-c d") #'dired-jump)
;; find the current tag smart.  Just know what I mean.
;; For example, with point on the following javascript function upcaseWord
;; var upcase =  upcaseWord (string);
;; And you type C-c D,  ggtags, when open the buffer where that function is defined
;;(global-set-key (kbd "C-c D") 'ggtags-find-tag-dwim)

;;use-package on dumb just doesn't work ...? why?
(use-package dumb-jump :ensure t)
(global-set-key (kbd "C-c D") #'dumb-jump-go)
(global-set-key (kbd "C-c e") #'helm-M-x)
(global-set-key (kbd "C-c E") #'eshell)
(global-set-key (kbd "C-c f") #'isearch-forward-regexp)
(global-set-key (kbd "C-c F") #'isearch-backward-regexp)
;; open up email mail program
(global-set-key (kbd "C-c g") #'gnus)
(global-set-key (kbd "C-c h") #'helm-command-prefix)
(global-set-key (kbd "C-c i") #'info-display-manual)
;; type this with point at the end of an elisp expression like
;; (print 5)<point>
;; the result will be 5 printed in the minibuffer
(global-set-key (kbd "C-c l") #'eval-last-sexp)
;;this lets you store an org link from pretty much any file
;;then type C-c C-l in an org buffer and it'll put that link it
(global-set-key (kbd "C-c L") #'org-store-link)
(global-set-key (kbd "C-c I") #'org-insert-link)
(global-set-key (kbd "C-c m") #'helm-mini)

;;print the working directory in the minibuffer
;; I should make these commands copy the output of pwd into the clipboard
(global-set-key (kbd "C-c P") #'pwd)
;;(global-set-key (kbd "C-c p") #'pwd)
;;This does recursive find and replace.  But I think it only works when you are in a dired buffer
(global-set-key (kbd "C-c R") #'find-name-dired)

(defun sanityinc/no-trailing-whitespace ()
  "Turn off display of trailing whitespace in this buffer."
  (setq show-trailing-whitespace nil))

(dolist (hook '(special-mode-hook
                eww-mode-hook
                term-mode-hook
                comint-mode-hook
                compilation-mode-hook
                twittering-mode-hook
                minibuffer-setup-hook))
  (add-hook hook #'sanityinc/no-trailing-whitespace))

(global-set-key (kbd "RET") #'newline-and-indent)

(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

(mapc (lambda (x)
        (add-to-list 'completion-ignored-extensions x))
      '(".aux" ".bbl" ".blg" ".exe"
        ".log" ".meta" ".out" ".pdf"
        ".synctex.gz" ".tdo" ".toc"
        "-pkg.el" "-autoloads.el"
        "Notes.bib" "auto/"))

(global-auto-revert-mode 1)

(setq auto-revert-verbose nil)

(setq global-auto-revert-non-file-buffers t)

(show-paren-mode 1)

(electric-pair-mode t)

(use-package page-break-lines
  :ensure t
  :diminish page-break-lines-mode
  :config (global-page-break-lines-mode))

(use-package anzu
  :ensure t
  :diminish anzu-mode)

(global-anzu-mode +1)

(global-visual-line-mode)
(global-set-key (kbd "C-c q") #'fill-paragraph)

(defun my-macro-query (arg)
  "Prompt for input using minibuffer during kbd macro execution.
With prefix argument, allows you to select what prompt string to use.
If the input is non-empty, it is inserted at point."
  (interactive "P")
  (let* ((query (lambda () (kbd-macro-query t)))
         (prompt (if arg (read-from-minibuffer "PROMPT: ") "Input: "))
         (input (unwind-protect
                    (progn
                      (add-hook 'minibuffer-setup-hook query)
                      (read-from-minibuffer prompt))
                  (remove-hook 'minibuffer-setup-hook query))))
    (unless (string= "" input) (insert input))))

(global-set-key "\C-xQ" #'my-macro-query)

(add-hook 'after-save-hook 'my/save-all-buffers)

(defun narrow-or-widen-dwim (p)
  "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or defun,
whichever applies first. Narrowing to org-src-block actually
calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer is
already narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing
         ;; command. Remove this first conditional if you
         ;; don't want it.
         (cond ((ignore-errors (org-edit-src-code))
                (delete-other-windows))
               ((ignore-errors (org-narrow-to-block) t))
               (t (org-narrow-to-subtree))))
        ((derived-mode-p 'latex-mode)
         (LaTeX-narrow-to-environment))
        (t (narrow-to-defun))))

;; This line actually replaces Emacs' entire narrowing
;; keymap, that's how much I like this command. Only copy it
;; if that's what you want.
(define-key ctl-x-map "n" #'narrow-or-widen-dwim)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(defun indent-whole-buffer ()
  "This indents the whole buffer"
  (interactive)
  (indent-region (point-min) (point-max)))

(defun mydelete ()
  "Delete the failed portion of the search string, or the last char if successful."
  (interactive)
  (with-isearch-suspended
   (setq isearch-new-string
         (substring
          isearch-string 0 (or (isearch-fail-pos) (1- (length isearch-string))))
         isearch-new-message
         (mapconcat 'isearch-text-char-description isearch-new-string ""))))

(define-key isearch-mode-map (kbd "DEL") 'mydelete)

(define-key ctl-x-map "\C-i" #'endless/ispell-word-then-abbrev)

(global-set-key (kbd "C-c $") #'endless/ispell-word-then-abbrev)

(defun endless/ispell-word-then-abbrev (p)
  "Call `ispell-word', then create an abbrev for it.
With prefix P, create local abbrev. Otherwise it will
be global."
  (interactive "P")
  (let (bef aft)
    (save-excursion
      (while (progn
               (backward-word)
               (and (setq bef (thing-at-point 'word))
                    (not (ispell-word nil 'quiet)))))
      (setq aft (thing-at-point 'word)))
    (when (and aft bef (not (equal aft bef)))
      (setq aft (downcase aft))
      (setq bef (downcase bef))
      (define-abbrev
        (if p local-abbrev-table global-abbrev-table)
        bef aft)
      (message "\"%s\" now expands to \"%s\" %sally"
               bef aft (if p "loc" "glob")))))

(setq save-abbrevs 'silently)
(setq-default abbrev-mode t)

(global-set-key (kbd "C-c x") #'align-regexp)

(defun my/delete-trailing-whitespace ()
  "This is just a defined function that deletes trailing whitespace"
  (interactive)
  (when
      ;; don't delete white space in my programming dirs
      ;; where I may commit these changes to other projects.
      (and
       (not (s-match ".*programming/gnu.*" (buffer-file-name)))
       (not (s-match ".*programming/web.*" (buffer-file-name))))
  (delete-trailing-whitespace)))

 (defun my/leave-trailing-whitespace-hook  ()
   "This defun leaves trailing whitespace"
   (interactive)
   (remove-hook 'before-save-hook 'my/delete-trailing-whitespace))

 (defun my/delete-trailing-whitespace-hook  ()
   "This defun leaves trailing whitespace"
   (interactive)
   (add-hook 'before-save-hook 'my/delete-trailing-whitespace))

   (my/delete-trailing-whitespace-hook)

(require 'server)
(when (not (server-running-p))
  (server-start))

(use-package move-dup :ensure t)
(global-set-key (kbd "s-t") #'md/move-lines-up)
;; this won't work because this is a command that feeds into awesome
(global-set-key (kbd "s-h") #'md/move-lines-down)

(global-set-key (kbd "s-p") 'md/duplicate-down)
(global-set-key (kbd "s-P") 'md/duplicate-up)

(provide 'init-editing-utils)
