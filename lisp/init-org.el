(use-package org
:ensure org-plus-contrib)

;; define what files org opens
(add-to-list 'auto-mode-alist '("\\.\\(org\\|txt\\)$" . org-mode))
;;(setq org-default-notes-file (concat org-directory "/notes.org"))

(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))

(setq org-crypt-key "E99C48112E969A17")

(setq auto-save-default nil)

(require 'org-mime)

(setq org-mime-library 'mml)

(after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (awk . t)
     (calc .t)
     (emacs-lisp . t)
     (latex . t)
     ;;(ledger . t)
     (python . t)
     (awk . t)
     (C . t)
     (js . t)
     (gnuplot . t)
     ;; org-babel does not currently support php
     ;;(php . t)
     (sh . t)
     (sql . t)
     ;;(sqlite . t)
     (gnuplot . t)
     )))

(require 'org-invoice)

(require 'org-notify)
(org-notify-start)

(org-notify-add 'appt
                '(:time "-1s" :period "20s" :duration 10
                        :actions (-message -ding))
                '(:time "15m" :period "2m" :duration 100
                        :actions -notify)
                '(:time "2h" :period "5m" :actions -message)
                '(:time "3d" :actions -email))

(setq
 ;; hide the leading stars in my org files
 org-hide-leading-stars t
 ;;seeing the ... that org mode does to how you that the heading continues in the text beneith it is kind of boring
 ;; http://endlessparentheses.com/changing-the-org-mode-ellipsis.html?source=rss
 ;; Other interesting characters are ↴, ⬎, ⤷, and ⋱.
 org-ellipsis " ↴"
 ;;org-ellipsis "⬎"
 ;; org-ellipsis "⤵"
 ;; don't let me accidentally delete text without realizing it in org.  ie: point is buried in a subtree, but you only
 ;; see the heading and you accidentally kill a line without knowing it.
 ;; this might not be supported for evil-mode
 org-catch-invisible-edits 'show-and-error
 ;; whenever I change state from TODO to DONE org will log that timestamp. Let's put that in a drawer
 org-log-into-drawer t
 ;; make org-mode record the date when you finish a task
 org-log-done 'time
 ;;org-log-done 'nil
 ;; when you press S-down, org changes the timestamp under point
 org-edit-timestamp-down-means-later t
 ;; make the agenda start on today not wednesday
 org-agenda-start-on-weekday nil
 ;; don't make the agenda only show saturday and Sunday if today is saturday. Make it show 7 days
 org-agenda-span 7
 ;; using the diary slows down the agenda view
 ;; but it also shows you upcoming calendar events
 org-agenda-include-diary t
 ;; this tells the agenda to take up the whole window and hide all other buffers
 org-agenda-window-setup 'current-window
 ;; this tells org-mode to only quit selecting tags for things when you tell it that you are done with it
 org-fast-tag-selection-single-key nil
 org-html-validation-link nil
 org-export-kill-product-buffer-when-displayed t
 ;; are there more backends that I can use?
 org-export-backends '(ascii beamer html texinfo latex)
 ;;most of these modules let you store links to various stuff in org
 org-modules '(org-bbdb org-gnus org-info invoice man toc habits org-mime org-bullets)
 ;; load in the org-modules
 ;;org-load-modules-maybe t
 ;; where to put the :action: or :work: tag after a heading.  80 colums over
 org-tags-column 80
 ;; don't ask me if I want to run an babel code block.  I know what I'm doing
 org-confirm-babel-evaluate nil
 ;; activate org speed commands
 org-use-speed-commands t)

;;a visual hint to let you know what line you are in in org-mode agenda
(add-hook 'org-agenda-finalize-hook (lambda () (hl-line-mode)))

(setq org-capture-templates
    '(

      ("B" "Things I want to buy" entry (file+headline
      "~/programming/org/gtd/projects/managing-my-monies.org" "things I want to buy")
       "* %?\nEntered on %U\n  %i\n  %a")

      ("c" "Computers Anything")
      ("ca" "Awesome WM" entry (file+headline "~/programming/org/gtd/gtd.org" "awesome WM someday")
       "* TODO %?\nEntered on %U\n  %i\n  %a")
      ("ce" "emacs Todo" entry (file+headline "~/programming/org/gtd/projects/become-an-awesome-hacker.org" "emacs someday")
       "* TODO %?\n  %i\n  %a")
      ("cE" "Emacs Reference" entry (file+headline "~/programming/org/gtd/projects/become-an-awesome-hacker.org" "emacs reference")
       "* %?\nEntered on %U\n  %i\n  %a")
      ("cG" "Gimp Basics Reference" entry (file+headline "~/manuals/gimp.org" "Basic Concepts")
       "* %?\nEntered on %U\n  %i\n  %a")
      ("cH" "The GNU HURD")
      ("cHt" "Hurd" entry (file+headline "~/programming/org/gtd/projects/become-an-awesome-hacker.org"
                                                                     "Hurd")
       "* TODO %?\n  %i\n  %a")
      ("ct" "General Computer TODO"
       entry (file+headline "~/programming/org/gtd/projects/become-an-awesome-hacker.org" "General TODO")
       "* todo %?\n  %i\n  %a")
      ("cw" "Waypoint")
      ("cwi" "ibca Web App")
      ("cwib" "bugs that need fixin'" entry (file+headline "~/programming/org/gtd/projects/working-for-waypoint.org"
                                                                     "bugs that need fixin'")
       "* TODO %?\n  %i\n  %a")
      ("cwic" "core features that must be done" entry (file+headline "~/programming/org/gtd/projects/working-for-waypoint.org"
                                                                     "core features that must be done")
       "* TODO %?\n  %i\n  %a")
      ("cwif" "features the app should have" entry (file+headline "~/programming/org/gtd/projects/working-for-waypoint.org"
                                                                  "features the app should have") "* TODO %?\n  %i\n  %a")
      ("cwir" "IBCA Reference" entry (file+headline "~/programming/org/gtd/projects/working-for-waypoint.org"
                                                    "IBCA Reference") "* %?\nEntered on %U\n  %i\n  %a")
      ("cwiw" "what I have done" entry (file+headline "~/programming/org/gtd/projects/working-for-waypoint.org"
                                                               "what I have done") "* DONE %?\n  %i\n  %a")
      ("ch" "high star todo"
       entry (file+headline "~/programming/org/gtd/projects/become-an-awesome-hacker.org" "make high star an android app")
       "* todo %?\n  %i\n  %a")
      ("cl" "linux TODO" entry (file+headline "~/programming/org/gtd/projects/become-an-awesome-hacker.org" "linux someday")
       "* TODO %?\n  %i\n  %a")
      ("cL" "Linux Reference" entry (file+headline "~/programming/org/gtd/projects/become-an-awesome-hacker.org" "linux reference")
       "* %?\nEntered on %U\n  %i\n  %a")
      ("co" "organ TODO" entry (file+headline "~/programming/org/gtd/projects/become-an-awesome-hacker.org" "make organ an android app")
       "* TODO %?\n  %i\n  %a")
      ("cf" "Free the world" entry (file+headline "~/programming/org/gtd/gtd.org" "free the world free content")
       "* %?\nEntered on %U\n  %i\n  %a")

       ("cW" "Web")

      ("cWA" "Accrisoft Reference" entry (file+headline "~/programming/org/gtd/web.org" "Accrisoft reference")
       "* %?\nEntered on %U\n  %i\n  %a")

       ("cWB" "Bootstrap Reference" entry (file+headline "~/programming/org/gtd/web.org" "Bootstrap reference")
       "* %?\nEntered on %U\n  %i\n  %a")

       ("cWS" "Shoppify Reference" entry (file+headline "~/programming/org/gtd/web.org" "Shoppify reference")
       "* %?\nEntered on %U\n  %i\n  %a")

       ("cWW" "Web reference" entry (file+headline "~/programming/org/gtd/web.org" "Web reference")
       "* %?\nEntered on %U\n  %i\n  %a")


      ("C" "Community")
      ("Cc" "community TODO" entry (file+headline "~/programming/org/gtd/gtd.org" "community someday")
       "* TODO %?\n  %i\n  %a")
      ("Cn" "nice things to say" entry (file+headline "~/programming/org/gtd/projects/get-close-to-God.org"
      "nice things to say")
       "* TODO %?\nEntered on %U\n  %i\n  %a")
      ("Cs" "Social Skills Notes" entry (file+headline "~/programming/org/gtd/being-social.org" "Social Skills Notes")
       "* %?\nEntered on %U\n  %i\n  %a")

      ("C" "Calendar TODO" entry (file+headline "~/programming/org/gtd/gtd.org" "calendar")
       "* TODO %?\n  %i\n  %a")

      ("e" "entertainment")
      ("eb" "Books to Read" entry (file+headline "~/programming/org/gtd/projects/whatever-I-want.org" "Books to Read")
       "*  %i\n  %a")
      ("er" "Good Movies Reference" entry (file+headline "~/programming/org/gtd/projects/whatever-I-want.org" "Good Movies")
       "*  %i\n  %a")
      ("ew" "movies to watch" entry (file+headline "~/programming/org/gtd/projects/whatever-I-want.org" "movies to watch")
       "*  %i\n  %a")
      ("g" "getting close to God")
      ("gg" "get a close friend" entry (file+headline "/home/joshua/programming/org/gtd/projects/get-close-to-God.org"
                                                      "get a close friend") "* TODO %?\n  %i\n  %a")
      ("gb" "Boundaries")
      ("gbn" "Boundary Notes" entry (file+headline "~/programming/org/gtd/gtd.org" "Boundary Notes")
       "* %?\nEntered on %U\n  %i\n  %a")
      ("gbl" "Lowering My Expectations of Myself" entry (file+headline "~/programming/org/gtd/gtd.org"
                                                                       "Lowering My Expectations of Myself")
       "* %?\nEntered on %U\n  %i\n  %a")
      ("gbs" "Boundaries To Enforce" entry (file+headline "~/programming/org/gtd/projects/get-close-to-God.org" "Setting Boundaries")
       "* TODO %?\n  %i\n  %a")

      ("p" "payless TODO" entry (file+headline "~/programming/org/gtd/gtd.org" "shopping todo")
       "* TODO %?\n  %i\n  %a")
      ("r" "Reference" entry (file+headline "~/programming/org/gtd/gtd.org" "general reference")
       "* %?\nEntered on %U\n  %i\n  %a")
      ("t" "TODO" entry (file+headline "~/programming/org/gtd/gtd.org" "general todo")
       "* TODO %?\nEntered on %U\n  %i\n  %a")
      ("q" "Quotations" entry (file+headline "~/programming/org/quotes.org" "Quotations")
       "* %?\nEntered on %U\n  %i\n  %a")
      ))

(setq org-agenda-category-icon-alist '(
                                  ("hacker"      "/home/joshua/pictures/org-icons/gnu-linux-icon.png" nil nil nil nil)
                                  ("MAKING CASH"   "/home/joshua/pictures/org-icons/money.png" nil nil nil nil)
                                  ("SEEKING GOD" "/home/joshua/pictures/org-icons/god.png" nil nil nil nil)
                                  ("BILLS"    "/home/joshua/pictures/org-icons/bills.png" nil nil nil nil)
                                  ("emacs"       "/home/joshua/pictures/org-icons/emacs.png" nil nil nil nil)
                                  ("WORK"       "/home/joshua/pictures/org-icons/work.png" nil nil nil nil)
                                  ))

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
                          my-org-agenda-extensions)
        ;;org-refile-targets (my-org-list-files
          ;;                  my-org-agenda-directories
            ;;                my-org-agenda-extensions
                          ;;  )
        ))

(my-org-set-agenda-files)

; Targets start with the file name - allows creating level 1 tasks
  (setq org-refile-use-outline-path (quote file))
  ; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
  (setq org-outline-path-complete-in-steps t)
  (setq org-todo-keywords
  '((sequence "TODO(t!)" "PROJECT(r)" "STARTED(s!)"  "DELEGATED(e!)" "CHARGED(c!)" "|" "PAID(p!)" "DONE(d!)")))

        ;; I'm not sure how to globally set tags.  I would like to know how to do that, so I won't have to specify all the tags
        ;; the top of each agenda document
  ;; I can apparently also specify org-tag-faces which will make certain tags look certain colors!
  ;; why is this big hunk of setq not working?
  ;; (setq org-tag-alist '(("waiting(w)" . ?w)
  ;; ("action(a)" . ?a) ("career" . ?r) ("community" . ?m) ("gnu" . ?g)
  ;; ("someday" . ?o) ("project" . ?p) ("reference" . ?e) ("reward" . ?d))

  ;; org-tag-faces '(("waiting(w)" . org-warning) ("action(a)" . org-warning)
  ;;  ("career" . "green") ("community" . "green") ("gnu" . "green") ("someday" . "yellow")
  ;;  ("project" . "blue") ("reference" . "green") ("reward" . "green")))


  ;;  (setq org-todo-keywords
  ;;        (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
  ;;                (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)"))))

  ;;(setq org-todo-keyword-faces
    ;;     '(("TODO" . org-warning) ("STARTED" . "yellow")
      ;;     ("CANCELED" . (:foreground "blue" :weight bold))))

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

;;you can start clocking in on an event in the agenda buffer by pressing P
(use-package org-pomodoro
  :ensure t)
(after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro))

(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook #'(lambda ()
                             ;; https://bitbucket.org/ukaszg/org-eldoc org eldoc looks cool
                             ;;(org-eldoc-hook-setup)
                             (make-variable-buffer-local 'yas/trigger-key)
                             (setq yas/trigger-key [tab])
                             (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
                             (define-key yas/keymap [tab] 'yas/next-field)
                             ;; make the lines in the buffer wrap around the edges of the screen.
                             (visual-line-mode)
                             (org-bullets-mode 1)
                             ;;make ">=" look like >=, etc.
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

                             (push '("1/4" . ?¼) prettify-symbols-alist)
                             (push '("1/2" . ?½) prettify-symbols-alist)
                             (push '("3/4" . ?¾) prettify-symbols-alist)
                             (push '("1/7" . ?⅐) prettify-symbols-alist)
                             ;; ⅕ ⅖ ⅗ ⅘ ⅙ ⅚ ⅛ ⅜ ⅝ ⅞

                             (push '("ae" . ?æ) prettify-symbols-alist)


                             (push '("^_^" . ?☻) prettify-symbols-alist)))

(setq org-stuck-projects '("PROJECT" ("TODO NEXT") ("action") "\\<IGNORE\\>" ))

(defhydra hydra-outline (:color pink :hint nil)
  "
^Hide^             ^Show^           ^Move
^^^^^^------------------------------------------------------
_q_: sublevels     _a_: all         _u_: up
_t_: body          _e_: entry       _n_: next visible
_o_: other         _i_: children    _p_: previous visible
_c_: entry         _k_: branches    _f_: forward same level
_l_: leaves        _s_: subtree     _b_: backward same level
_d_: subtree

"
  ;; Hide
  ("q" hide-sublevels)    ; Hide everything but the top-level headings
  ("t" hide-body)         ; Hide everything but headings (all body lines)
  ("o" hide-other)        ; Hide other branches
  ("c" hide-entry)        ; Hide this entry's body
  ("l" hide-leaves)       ; Hide body lines in this entry and sub-entries
  ("d" hide-subtree)      ; Hide everything in this entry and sub-entries
  ;; Show
  ("a" show-all)          ; Show (expand) everything
  ("e" show-entry)        ; Show this heading's body
  ("i" show-children)     ; Show this heading's immediate child sub-headings
  ("k" show-branches)     ; Show all sub-headings under this heading
  ("s" show-subtree)      ; Show (expand) everything in this heading & below
  ;; Move
  ("u" outline-up-heading)                ; Up
  ("n" outline-next-visible-heading)      ; Next
  ("p" outline-previous-visible-heading)  ; Previous
  ("f" outline-forward-same-level)        ; Forward - same level
  ("b" outline-backward-same-level)       ; Backward - same level
  ("z" nil "leave"))

(global-set-key (kbd "C-c #") 'hydra-outline/body) ; by example

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; function to wrap blocks of text in org templates                       ;;
  ;; e.g. latex or src etc                                                  ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (defun org-begin-template ()
  "Make a template at point."
  (interactive)
  (if (org-at-table-p)
      (call-interactively 'org-table-rotate-recalc-marks)
    (let* ((choices '(("s" . "SRC")
                      ("e" . "EXAMPLE")
                      ("q" . "QUOTE")
                      ("v" . "VERSE")
                      ("c" . "CENTER")
                      ("l" . "LaTeX")
                      ("h" . "HTML")
                      ("a" . "ASCII")))
           (key
            (key-description
             (vector
              (read-key
               (concat (propertize "Template type: " 'face 'minibuffer-prompt)
                       (mapconcat (lambda (choice)
                                    (concat (propertize (car choice) 'face 'font-lock-type-face)
                                            ": "
                                            (cdr choice)))
                                  choices
                                  ", ")))))))
      (let ((result (assoc key choices)))
        (when result
          (let ((choice (cdr result)))
            (cond
             ((region-active-p)
              (let ((start (region-beginning))
                    (end (region-end)))
                (goto-char end)
                (insert "#+END_" choice "\n")
                (goto-char start)
                (insert "#+BEGIN_" choice "\n")))
             (t
              (insert "#+BEGIN_" choice "\n")
              (save-excursion (insert "#+END_" choice))))))))))

;;bind to key
;;(define-key org-mode-map (kbd "C-<") 'org-begin-template)

(provide 'init-org)
