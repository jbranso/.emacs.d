(define-key global-map (kbd "C-c a") 'org-agenda)

(define-key org-mode-map "\"" #'endless/round-quotes)

(defun endless/round-quotes (italicize)
  "Insert “” and leave point in the middle.
With prefix argument ITALICIZE, insert /“”/ instead
\(meant for org-mode).
Inside a code-block, just call `self-insert-command'."
  (interactive "P")
  (if (and (derived-mode-p 'org-mode)
           (org-in-block-p '("src" "latex" "html")))
      (call-interactively #'self-insert-command)
    (if (looking-at "”[/=_\\*]?")
        (goto-char (match-end 0))
      (when italicize
        (if (derived-mode-p 'markdown-mode)
            (insert "__")
          (insert "//"))
        (forward-char -1))
      (insert "“”")
      (forward-char -1))))

(define-key org-mode-map "'" #'endless/apostrophe)
;; (eval-after-load 'markdown-mode
;;   '(define-key markdown-mode-map "'"
;;      #'endless/apostrophe))

(defun endless/apostrophe (opening)
  "Insert ’ in prose or `self-insert-command' in code.
With prefix argument OPENING, insert ‘’ instead and
leave point in the middle.
Inside a code-block, just call `self-insert-command'."
  (interactive "P")
  (if (and (derived-mode-p 'org-mode)
           (org-in-block-p '("src" "latex" "html")))
      (call-interactively #'self-insert-command)
    (if (looking-at "['’][=_/\\*]?")
        (goto-char (match-end 0))
      (if (null opening)
          (insert "’")
        (insert "‘’")
        (forward-char -1)))))

;; define what files org opens
(add-to-list 'auto-mode-alist '("\\.\\(org\\|txt\\)$" . org-mode))
(setq org-capture-templates
      '(
        ("a" "Awesome WM" entry (file+datetree "~/programming/org/gtd/awesome-todos.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("e" "emacs Todo" entry (file+headline "~/programming/org/gtd/emacs-todos.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("E" "Emacs Reference" entry (file+datetree "~/programming/org/gtd/emacs-reference.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("c" "community TODO" entry (file+headline "~/programming/org/gtd/community-todo.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("h" "high star TODO" entry (file+headline "~/programming/org/gtd/high-star-todos.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("l" "linux TODO" entry (file+headline "~/programming/org/gtd/linux-todos.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("L" "Linux Reference" entry (file+datetree "~/programming/org/gtd/linux-reference.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("o" "organ TODO" entry (file+headline "~/programming/org/gtd/organ-todos.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("r" "Reference" entry (file+datetree "~/programming/org/gtd/reference.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("s" "soihub TODO" entry (file+datetree "~/programming/org/gtd/soihub-todos.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("S" "Soihub Reference" entry (file+datetree "~/programming/org/gtd/soihub-reference.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("t" "TODO" entry (file+datetree "~/programming/org/gtd/todos.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ))
(define-key global-map "\C-cc" 'org-capture)
;; 9.1.3 Capture templates

;; You can use templates for different types of capture items, and for different target locations. The easiest way to create such
;; templates is through the customize interface.

;; C-c c C
;;     Customize the variable org-capture-templates.

;; Before we give the formal description of template definitions, let's look at an example. Say you would like to use one template
;; to create general TODO entries, and you want to put these entries under the heading ‘Tasks’ in your file ~/org/gtd.org. Also, a
;; date tree in the file journal.org should capture journal entries. A possible configuration would look like:

;;      (setq org-capture-templates
;;       '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
;;              "* TODO %?\n  %i\n  %a")
;;         ("j" "Journal" entry (file+datetree "~/org/journal.org")
;;              "* %?\nEntered on %U\n  %i\n  %a")))


;; Various preferences
(setq org-log-done t
      org-completion-use-ido t
      org-edit-timestamp-down-means-later t
      org-agenda-start-on-weekday nil
      org-agenda-span 14
      org-agenda-include-diary t
      org-agenda-window-setup 'current-window
      org-fast-tag-selection-single-key 'expert
      org-html-validation-link nil
      org-export-kill-product-buffer-when-displayed t
      org-tags-column 80)


                                        ; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
;;(setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))))
(setq org-agenda-files (quote ("~/programming/org/gtd/gtd.org"
                               "/home/joshua/programming/org/gtd/awesome-todos.org"
                               "/home/joshua/programming/org/gtd/todos.org "
                               "/home/joshua/programming/org/gtd/emacs-todos.org"
                               "/home/joshua/programming/org/gtd/linux-todos.org"
                               "/home/joshua/programming/org/gtd/community-todo.org"
                               "/home/joshua/programming/org/gtd/soihub-todos.org"
                               "/home/joshua/programming/org/gtd/high-star-todos.org"
                               ;; I can add more files here!
                               )))
                                        ; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
                                        ; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)


;;(setq org-todo-keywords
; ;     (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
;;              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persistence-insinuate t)
(setq org-clock-persist t)
(setq org-clock-in-resume t)

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Show clock sums as hours and minutes, not "n days" etc.
(setq org-time-clocksum-format
      '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

;; Show the clocked-in task - if any - in the header line
(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " "))))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook #'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook #'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook #'sanityinc/hide-org-clock-from-header-line)

(after-load 'org-clock
  (define-key org-clock-mode-line-map [header-line mouse-2] #'org-clock-goto)
  (define-key org-clock-mode-line-map [header-line mouse-1] #'org-clock-menu))


(require-package 'org-pomodoro)
(after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro))

;; make org mode start up with auto fill mode
(add-hook 'org-mode-hook #'(lambda ()
                            (interactive)
                            (auto-fill-mode)
                            (visual-line-mode)
                            ;;refill mode is pretty amazing. If you are getting tired of pressing M-q all
                            ;;the time to fill paragraphs then turn on refill-mode.
                            ;; Be warned though, auto-fill-mode, refill-mode, and probably visual line mode,
                            ;; assume that the user follows the U.S. convention of using two spaces between
                            ;; sentences. If you do not follow this convention, or you add this to your init
                            ;; file...
                            ;; (sentence-end-double-space nil)
                            ;; bad things will happen. You have been warned.
                            ;;https://www.gnu.org/software/emacs/manual/html_node/emacs/Auto-Fill.html
                            ;;https://www.gnu.org /software/emacs/manual/html_node/emacs/Sentences.html
                            ;; I would love it if refill-mode would actually work with org-mode, but sadly it does not...
                            ;;(refill-mode)
                            ;; (push '(">=" . ?≥) prettify-symbols-alist)
                            ;; (push '("<=" . ?≤) prettify-symbols-alist)
                            ;; (push '("\\geq" . ?≥) prettify-symbols-alist)
                            ;; (push '("\\leq" . ?≤) prettify-symbols-alist)
                            ;; (push '("\\neg" . ?¬) prettify-symbols-alist)
                            ;; (push '("\\rightarrow" . ?→) prettify-symbols-alist)
                            ;; (push '("\\leftarrow" . ?←) prettify-symbols-alist)
                            ;; (push '("\\infty" . ?∞) prettify-symbols-alist)
                            ;; (push '("-->" . ?→) prettify-symbols-alist)
                            ;; (push '("<--" . ?←) prettify-symbols-alist)
                            ;; (push '("\\exists" . ?∃) prettify-symbols-alist)
                            ;; (push '("\\nexists" . ?∄) prettify-symbols-alist)
                            ;; (push '("\\forall" . ?∀) prettify-symbols-alist)
                            ;; (push '("\\or" . ?∨) prettify-symbols-alist)
                            ;; (push '("\\and" . ?∧) prettify-symbols-alist)
                            ;; (push '(":)" . ?☺) prettify-symbols-alist)
                            ;; (push '("):" . ?☹) prettify-symbols-alist)
                            ;; (push '(":D" . ?☺) prettify-symbols-alist)
                            ;; (push '("^_^" . ?☻) prettify-symbols-alist)

                            (let ((original-command (lookup-key org-mode-map [tab])))
                              `(lambda ()
                                 (setq yas-fallback-behavior
                                       '(apply ,original-command))
                                 (local-set-key [tab] 'yas-expand)))))

(after-load 'org
  (define-key org-mode-map (kbd "C-M-<up>") #'org-up-element)
  (define-key org-mode-map (kbd "C-M-<up>") #'org-up-element))

(after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (emacs-lisp . t)
     (latex . t)
     (ledger . t)
     (python . t)
     (sh . t)
     (sqlite . t))))


(provide 'init-org)
