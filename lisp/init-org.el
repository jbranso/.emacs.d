(define-key global-map (kbd "C-c a") 'org-agenda)

;; define what files org opens
(add-to-list 'auto-mode-alist '("\\.\\(org\\|txt\\)$" . org-mode))
;;(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-capture-directory (quote ~/programming/org/gtd/gtd))
(setq org-capture-templates
      '(
        ("c" "Computers Anything")
        ("cA" "Accrisoft Reference" entry (file+headline "~/programming/org/gtd/web.org" "Accrisoft reference")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("ca" "Awesome WM" entry (file+headline "~/programming/org/gtd/gtd.org" "awesome WM someday")
         "* TODO %?\nEntered on %U\n  %i\n  %a")
        ("ce" "emacs Todo" entry (file+headline "~/programming/org/gtd/gtd.org" "emacs someday")
         "* TODO %?\n  %i\n  %a")
        ("cE" "Emacs Reference" entry (file+headline "~/programming/org/gtd/gtd.org" "emacs reference")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("cG" "Gimp Basics Reference" entry (file+headline "~/manuals/gimp.org" "Basic Concepts")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("cw" "Waypoint")
        ("cwi" "ibca Web App")
        ("cwil" "IBCA what I did last week" entry (file+headline "~/programming/org/gtd/projects/working-for-waypoint.org"
                                                                 "what I did last week")
         "* TODO %?\n  %i\n  %a")
        ("cwif" "features the app should have" entry (file+headline "~/programming/org/gtd/projects/working-for-waypoint.org"
                                                                    "features the app should have")
         "* TODO %?\n  %i\n  %a")
        ("cwic" "core features that must be done" entry (file+headline "~/programming/org/gtd/projects/working-for-waypoint.org"
                                                                       "core features that must be done")
         "* TODO %?\n  %i\n  %a")
        ("ch" "high star TODO" entry (file+headline "~/programming/org/gtd/projects/become-an-awesome-hacker.org" "make high star an android app")
         "* TODO %?\n  %i\n  %a")
        ("cl" "linux TODO" entry (file+headline "~/programming/org/gtd/projects/become-an-awesome-developer.org" "linux someday")
         "* TODO %?\n  %i\n  %a")
        ("cL" "Linux Reference" entry (file+headline "~/programming/org/gtd/projects/become-an-awesome-developer.org" "linux reference")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("co" "organ TODO" entry (file+headline "~/programming/org/gtd/projects/become-an-awesome-hacker.org" "make organ an android app")
         "* TODO %?\n  %i\n  %a")
        ("cf" "Free the world" entry (file+headline "~/programming/org/gtd/gtd.org" "free the world free content")
         "* %?\nEntered on %U\n  %i\n  %a")

        ("cW" "Web reference" entry (file+headline "~/programming/org/gtd/web.org" "Web reference")
         "* %?\nEntered on %U\n  %i\n  %a")

        ("C" "Community")
        ("Cc" "community TODO" entry (file+headline "~/programming/org/gtd/gtd.org" "community someday")
         "* TODO %?\n  %i\n  %a")
        ("Cn" "nice things to say" entry (file+headline "~/programming/org/gtd/gtd.org" "nice things to say to people")
         "* TODO %?\nEntered on %U\n  %i\n  %a")

        ("C" "Calendar TODO" entry (file+headline "~/programming/org/gtd/gtd.org" "calendar")
         "* TODO %?\n  %i\n  %a")

        ("e" "entertainment")
        ("ew" "movies to watch" entry (file+headline "~/programming/org/gtd/projects/whatever-I-want.org" "movies to watch")
         "*  %i\n  %a")
        ("er" "Good Movies Reference" entry (file+headline "~/programming/org/gtd/projects/whatever-I-want.org" "Good Movies")
         "*  %i\n  %a")
        ("g" "getting close to God")
        ("gg" "get a girlfriend" entry (file+headline "/home/joshua/programming/org/gtd/projects/get-close-to-God.org" "get a girl")
         "* TODO %?\n  %i\n  %a")

        ("p" "payless TODO" entry (file+headline "~/programming/org/gtd/gtd.org" "shopping todo")
         "* TODO %?\n  %i\n  %a")
        ("r" "Reference" entry (file+headline "~/programming/org/gtd/gtd.org" "general reference")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("t" "TODO" entry (file+headline "~/programming/org/gtd/gtd.org" "general todo")
         "* TODO %?\nEntered on %U\n  %i\n  %a")
        ))
(define-key global-map "\C-cc" 'org-capture)


;; Various preferences
(setq org-log-done t
      org-edit-timestamp-down-means-later t
      org-agenda-start-on-weekday nil
      org-agenda-span 7
      ;; using the diary really slows down the agenda view
      ;;org-agenda-include-diary nil
      org-agenda-window-setup 'current-window
      org-fast-tag-selection-single-key 'expert
      org-html-validation-link nil
      org-export-kill-product-buffer-when-displayed t
      org-tags-column 80)


;; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
;;(setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))))
(setq org-refile-targets '(
                           ;;(org-agenda-files :maxlevel . 5)
                               ("~/programming/org/gtd/gtd.org")
                               ("~/programming/org/gtd/projects/get-close-to-God.org")
                          ))
;;(setq org-refile-targets 'org-agenda-files)

(setq org-agenda-files (my-org-set-agenda-files))
(setq org-refile-targets (my-org-set-agenda-files))
(setq org-refile-targets '((("~/programming/org/gtd/projects/working-for-waypoint.org") :maxlevel . 5)))


(defun my-org-list-files (dirs ext)
  "Function to create list of org files in multiple subdirectories.
This can be called to generate a list of files for
org-agenda-files or org-refile-targets.

DIRS is a list of directories.

EXT is a list of the extensions of files to be included."
  (let ((dirs (if (listp dirs)
                  dirs
                (list dirs)))
        (ext (if (listp ext)
                 ext
               (list ext)))
        files)
    (mapc
     (lambda (x)
       (mapc
        (lambda (y)
          (setq files
                (append files
                        (file-expand-wildcards
                         (concat (file-name-as-directory x) "*" y)))))
        ext))
     dirs)
    (mapc
     (lambda (x)
       (when (or (string-match "/.#" x)
                 (string-match "#$" x))
         (setq files (delete x files))))
     files)
    files))

(defvar my-org-agenda-directories '("~/programming/org/")
  "List of directories containing org files.")
(defvar my-org-agenda-extensions '(".org")
  "List of extensions of agenda files")

(setq my-org-agenda-directories '("~/programming/org/" "~/programming/org/gtd/"
                                  "~/programming/org/gtd/projects"))
(setq my-org-agenda-extensions '(".org"))

(defun my-org-set-agenda-files ()
  (interactive)
  (setq org-agenda-files (my-org-list-files
                          my-org-agenda-directories
                          my-org-agenda-extensions)))

(my-org-set-agenda-files)


                                        ; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
                                        ; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)


;; (setq org-todo-keywords
;;       (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
;;               (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persistence-insinuate t)
(setq org-clock-persist t)
(setq org-clock-in-resume t)

;; Change task state to STARTED when clocking in
;;(setq org-clock-in-switch-to-state "STARTED")
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
                            ;; (interactive)
                            ;;(auto-fill-mode)
                            ;; make the lines in the buffer wrap around the edges of the screen.
                            ;;(visual-line-mode)
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
                            (push '(">=" . ?≥) prettify-symbols-alist)
                            (push '("<=" . ?≤) prettify-symbols-alist)
                            (push '("\\geq" . ?≥) prettify-symbols-alist)
                            (push '("\\leq" . ?≤) prettify-symbols-alist)
                            (push '("\\neg" . ?¬) prettify-symbols-alist)
                            (push '("\\rightarrow" . ?→) prettify-symbols-alist)
                            (push '("\\leftarrow" . ?←) prettify-symbols-alist)
                            (push '("\\infty" . ?∞) prettify-symbols-alist)
                            (push '("-->" . ?→) prettify-symbols-alist)
                            (push '("<--" . ?←) prettify-symbols-alist)
                            (push '("\\exists" . ?∃) prettify-symbols-alist)
                            (push '("\\nexists" . ?∄) prettify-symbols-alist)
                            (push '("\\forall" . ?∀) prettify-symbols-alist)
                            (push '("\\or" . ?∨) prettify-symbols-alist)
                            (push '("\\and" . ?∧) prettify-symbols-alist)
                            (push '(":)" . ?☺) prettify-symbols-alist)
                            (push '("):" . ?☹) prettify-symbols-alist)
                            (push '(":D" . ?☺) prettify-symbols-alist)
                            (push '("^_^" . ?☻) prettify-symbols-alist)

                            ;; (let ((original-command (lookup-key org-mode-map [tab])))
                              ;; `(lambda ()
                                 ;; (setq yas-fallback-behavior
                                       ;; '(apply ,original-command))
                             ;; (local-set-key [tab] 'yas-expand))))
                             ))

;; (after-load 'org
  ;; (define-key org-mode-map (kbd "C-M-<up>") #'org-up-element)
  ;; (define-key org-mode-map (kbd "C-M-<up>") #'org-up-element))

;; I don't use any of these yet, so don't use 'em
(after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     ;;(emacs-lisp . t)
     ;;(latex . t)
     ;;(ledger . t)
     ;;(python . t)
     ;;(sh . t)
     ;;(sql . t)
     ;;(sqlite . t)
     )))


(provide 'init-org)
