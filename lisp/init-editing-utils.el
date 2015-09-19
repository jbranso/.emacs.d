;;----------------------------------------------------------------------------
;;  Some basic preferences
;;----------------------------------------------------------------------------
(setq-default
 ;;blink-cursor-interval 0.4
 ;; I want to open links from org-mode in chromium
 browse-url-browser-function (quote browse-url-chromium)
 bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
 buffers-menu-max-size 30
 case-fold-search t
 default-tab-width 4
 ;; debug-on-error t
 ;;this lets you delete selected text as you start typing BUT evil mode does this for me. So this is not needed.
 ;;delete-selection-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 fill-column 130
 ;;when you are on the last line of the buffer, C-n will act like <return>
 next-line-add-newlines t
 indent-tabs-mode nil
 inhibit-splash-screen t
 inhibit-startup-echo-area-message t
 inhibit-startup-message t
 make-backup-files nil
 ;; don't let the cursor go into minibuffer prompt
 ;; http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
 minibuffer-prompt-properties (quote (read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt))
 ;; this should turn off auto-saving the proper way.
 auto-save-default nil  ;; this will stop making #auto-save# files
 ;;make-backup-files nil  ;; this will stop making backup~ files
 ;; make emacs save all backup~ files in this directory
 backup-directory-alist '(("" . "~/.emacs.d/backups"))
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil
 )

;; some programming modes DO NOT want visual line mode enabled
;;(global-visual-line-mode 1)
;;show the number of lines you are on
(global-linum-mode 1)
;; this highlights search and replace as you type
(require-package 'anzu)
(global-anzu-mode +1)

(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)


;;; Whitespace

(defun sanityinc/no-trailing-whitespace ()
  "Turn off display of trailing whitespace in this buffer."
  (setq show-trailing-whitespace nil))

;; But don't show trailing whitespace in SQLi, inf-ruby etc.
(dolist (hook '(special-mode-hook
                eww-mode-hook
                term-mode-hook
                comint-mode-hook
                compilation-mode-hook
                twittering-mode-hook
                minibuffer-setup-hook))
  (add-hook hook #'sanityinc/no-trailing-whitespace))


;;; Newline behaviour
(global-set-key (kbd "RET") #'newline-and-indent)



(when (fboundp 'global-prettify-symbols-mode)
  (global-prettify-symbols-mode))


;; When you define a macro, you can type C-x Q to prompt the user for input.
;; Very helpful and cool!
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

;; put semantic is supposed to have that feature too.
;;This mode highlights the current word under point! very cool!
;; (require-package 'highlight-symbol)
;; (dolist (hook '(prog-mode-hook html-mode-hook css-mode-hook))
;;   (add-hook hook 'highlight-symbol-mode)
;;   (add-hook hook 'highlight-symbol-nav-mode))
;; (eval-after-load 'highlight-symbol


;; save all buffers after saving the current buffer.
(add-hook 'after-save-hook #'(lambda ()
                               (interactive)
                               (save-some-buffers 1)))

;;----------------------------------------------------------------------------
;; Don't disable narrowing commands
;;----------------------------------------------------------------------------
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;;----------------------------------------------------------------------------
;; Show matching parens
;;----------------------------------------------------------------------------
(show-paren-mode 1)
(electric-pair-mode t)
;;----------------------------------------------------------------------------
;; Expand region
;;----------------------------------------------------------------------------
;; The binding for this is listed below
;; this does not play well with evil
;;(require-package 'expand-region)

;;----------------------------------------------------------------------------
;; Don't disable case-change functions
;;----------------------------------------------------------------------------
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;----------------------------------------------------------------------------
;; Handy key bindings
;;----------------------------------------------------------------------------

(defun my/uppercase-word ()
  "capitalize the current word."
  (interactive)
  (forward-word)
  (backward-word)
  (capitalize-word 1))

(defun my/downcase-word ()
  "downcase the current word."
  (interactive)
  (forward-word)
  (backward-word)
  (downcase-word 1))


(defun indent-whole-buffer ()
  "This indents the whole buffer"
  (interactive)
  (indent-region (point-min) (point-max)))

;; the default behavior on i-search stinks.  This is a lot better
;; http://endlessparentheses.com/better-backspace-during-isearch.html?source=rss
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

(global-set-key "\t" #'indent-for-tab-command)
;;NOTES
;; C-x C-l lowercase region
;; C-x C-u uppercase region
;; my modkey <letter> commands
(global-set-key (kbd "s-a") #'mark-whole-buffer)
(global-set-key (kbd "s-d") #'my/downcase-word)
(global-set-key (kbd "s-g") #'magit-status)
(global-set-key (kbd "s-h") #'mark-paragraph)
;; This causes ERC to connect to the Freenode network upon hitting mod-i
(global-set-key (kbd "s-i") (lambda () (interactive)
                              (erc :server "irc.freenode.net" :port "6667"
                                   :nick "jbranso")))
(global-set-key (kbd "s-s") '(lambda ()
                               (interactive)
                               (save-some-buffers 1)))
(global-set-key (kbd "s-u") #'my/uppercase-word)
;; this conflicts with my command for dired.
(global-unset-key (kbd "C-a"))
(local-unset-key (kbd "C-a"))
;;all of my "C-c [letter]" commands
;; "C-c <letter>" are the ONLY commands that are supposed to NOT be bound. These are user specific commands
(global-set-key (kbd "C-c TAB") #'indent-whole-buffer)
(global-set-key (kbd "C-c \\") #'delete-horizontal-space)
(global-set-key (kbd "C-c SPC") #'just-one-space)
(global-set-key (kbd "C-c ;") #'comment-dwim)
;;(define-key global-map (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") #'eval-buffer)
(global-set-key (kbd "C-c B") #'browse-kill-ring)
;;(define-key global-map "\C-cc" 'org-capture)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c C") #'hydra-org-timer/body)
;;open up a new dired window for the current directory
(global-set-key (kbd "C-c d") #'dired-jump)
;; find the current tag smart.  Just know what I mean.
;; For example, with point on the following javascript function upcaseWord
;; var upcase =  upcaseWord (string);
;; And you type C-c D,  ggtags, when open the buffer where that function is defined
(global-set-key (kbd "C-c D") 'ggtags-find-tag-dwim)
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
;; emacs has a multimedia system. It lets you play multimedia via emacs.  Technically emacs uses other programs to play
;; the music, BUT one uses emacs to play, pause, and change the volume. (though no one would use emacs to change the volume, because
;; it's too easy to just press the "turn up the volume button on your keyboard")
;; at some point, I might make all of these keys be bound to an evil mode key ie:
;; M p  would me emms-previous.
(global-set-key (kbd "C-c M i") #'(lambda ()
                                    (interactive)
                                    (emms-librefm-stream "librefm://globaltags/Classical")))
(global-set-key (kbd "C-c M p") 'emms-previous)
(global-set-key (kbd "C-c M n") 'emms-next)
(global-set-key (kbd "C-c M P") 'emms-pause)
(global-set-key (kbd "C-c M s") 'emms-show)
;; I think emms-kill when I press this
(global-set-key (kbd "C-c M k") 'emms-stop)
(global-set-key (kbd "C-c M +") 'emms-volume-mode-plus)
(global-set-key (kbd "C-c M -") 'emms-volume-mode-minus)
;;print the working directory in the minibuffer
;; I should make these commands copy the output of pwd into the clipboard
(global-set-key (kbd "C-c P") #'pwd)
;; C-c p is for projectile.  C-c p F is still broken but C-c p h works
;;(global-set-key (kbd "C-c p") #'pwd)
;;This does recursive find and replace.  But I think it only works when you are in a dired buffer
(global-set-key (kbd "C-c R") #'find-name-dired)
;; Filling is what one does to insert actual or invisible newlines at a really long sentence to make a paragraph.
;; For example:
;; This is a really long sentence, but when you call fill paragraph on it, with point inside it, it might look something like this:
;; This is a really long sentence,
;; but when you call fill paragraph
;; on it, with point inside it, it
;; might look something like this:
;; You probably know that programs like MS-word has this turned on by default, BUT most people, who use emacs, are programmers,
;; NOT writers.  Most programmers DO not want emacs to insert default newline characters.  SO if you would like emacs to
;; insert invisible newline characters just add the following to your .emacs
;; (visual-line-mode)
(global-set-key (kbd "C-c q") #'fill-paragraph)
;; search through your current vc project. It's SUPER fast, but you'll need the "silver searcher" installed on your system
(global-set-key (kbd "C-c s") #'ag-project)
;; this opens up the sx.el program, which lets your read, comment, or write stack overflow questions, which is a popular hacking
;; help website.
(global-set-key (kbd "C-c S") #'sx-search)
(global-set-key (kbd "C-c t") #'transpose-chars)
(global-set-key (kbd "C-c T") #'transpose-words)
;; this command is awesome! It'll let you transform stuff like
;;
;; var 5 = 10;
;; var this = 20;
;; var howIMetYourMother = 29;
;;
;; var 5                 = 10;
;; var this              = 20;
;; var howIMetYourMother = 29;
;;
;; By just pressing C-c x RET = RET
(global-set-key (kbd "C-c x") #'align-regexp)
;; this is not working for some reason.
;;(global-set-key (kbd "C-c x") #'er/expand-region)

(global-set-key (kbd "C-x C-.") #'pop-global-mark)
;; web-mode has a command C-c C-h that overrides this.
;; I've modified the web-mode-hook to account for this.
(global-set-key (kbd "C-c C-h") #'help)
(global-set-key (kbd "C-c h k") #'helm-show-kill-ring)
(global-set-key (kbd "C-x f")   #'helm-find-files)
(global-set-key (kbd "C-c h o") #'helm-occur)
(global-set-key (kbd "C-c h c") #'helm-calcul-expression)
(require-package 'multiple-cursors)
;; multiple-cursors, which does not work well with evil mode. switch to emacs state to use this command
(global-set-key (kbd "C-c <")   #'mc/mark-previous-like-this)
(global-set-key (kbd "C-c >")   #'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-<") #'mc/mark-all-like-this)
;; From active region to multiple cursors:
;;(global-set-key (kbd "C-c c r") #'set-rectangular-region-anchor)
;;(global-set-key (kbd "C-c c c") #'mc/edit-lines)
;;(global-set-key (kbd "C-c c e") #'mc/edit-ends-of-lines)
;;(global-set-key (kbd "C-c c a") #'mc/edit-beginnings-of-lines)

;; To make myself use C-w h/t/n/s
(global-set-key (kbd "C-x o") 'other-window)
;; make myself use "s-s"
(global-unset-key (kbd "C-x C-s"))

;;----------------------------------------------------------------------------
;; Page break lines
;;----------------------------------------------------------------------------
;; this turn ^L into nice long lines.
(require-package 'page-break-lines)
(global-page-break-lines-mode)

;;----------------------------------------------------------------------------
;; Shift lines up and down with M-up and M-down. When paredit is enabled,
;; it will use those keybindings. For this reason, you might prefer to
;; use M-S-up and M-S-down, which will work even in lisp modes.
;;----------------------------------------------------------------------------
(require-package 'move-dup)
;; it would be nice if this worked, but life.
(global-set-key (kbd "s-t") #'md/move-lines-up)
(global-set-key (kbd "s-h") #'md/move-lines-down)

(global-set-key (kbd "s-p") 'md/duplicate-down)
(global-set-key (kbd "s-P") 'md/duplicate-up)

;;----------------------------------------------------------------------------
;; Fix backward-up-list to understand quotes, see http://bit.ly/h7mdIL
;;----------------------------------------------------------------------------
(defun backward-up-sexp (arg)
  "Jump up to the start of the ARG'th enclosing sexp."
  (interactive "p")
  (let ((ppss (syntax-ppss)))
    (cond ((elt ppss 3)
           (goto-char (elt ppss 8))
           (backward-up-sexp (1- arg)))
          ((backward-up-list arg)))))

(global-set-key [remap backward-up-list] 'backward-up-sexp) ; C-M-u, C-M-up



;; This package pops up a buffer, when a key prefix is hit, that shows what keys the user can now hit to use a command.
(require-package 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-x n" "C-c p"
                                     "C-c h" ))
(guide-key-mode 1)

;; delete any trailing whitespace any your buffer on save
(add-hook 'before-save-hook
          '(lambda ()
             (delete-trailing-whitespace)))

(provide 'init-editing-utils)
