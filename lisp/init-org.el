(when (< emacs-major-version 24)
  (require-package 'org))
(require-package 'org-fstree)
(when *is-a-mac*
  (require-package 'org-mac-link)
  (autoload 'org-mac-grab-link "org-mac-link" nil t)
  (require-package 'org-mac-iCal))

(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)

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
(setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))))
; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)"))))


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

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(after-load 'org-clock
  (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
  (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu))


(require-package 'org-pomodoro)
(after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro))

;; make org mode start up with auto fill mode
(add-hook 'org-mode-hook '(lambda ()
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
  (define-key org-mode-map (kbd "C-M-<up>") 'org-up-element)
  (when *is-a-mac*
    (define-key org-mode-map (kbd "M-h") nil))
  (define-key org-mode-map (kbd "C-M-<up>") 'org-up-element)
  (when *is-a-mac*
    (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)))

(after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (ditaa . t)
     (dot . t)
     (emacs-lisp . t)
     (gnuplot . t)
     (haskell . nil)
     (latex . t)
     (ledger . t)
     (ocaml . nil)
     (octave . t)
     (python . t)
     (ruby . t)
     (screen . nil)
     (sh . t)
     (sql . nil)
     (sqlite . t))))


(provide 'init-org)
