(defun my-just-one-space ()
  (interactive)
  (if (org-at-table-p)
      (org-table-blank-field)
    (just-one-space)))

(use-package org
  :bind (:map org-mode-map
              ("C-c SPC" . my-just-one-space))
  :ensure org-plus-contrib)

;; define what files org opens
(add-to-list 'auto-mode-alist '("\\.\\(org\\|txt\\)$" . org-mode))
;;(setq org-default-notes-file (concat org-directory "/notes.org"))

(use-package org-crypt
  :config
  (org-crypt-use-before-save-magic)
  (setq org-tags-exclude-from-inheritance (quote ("crypt"))))

(setq org-crypt-key "C8FA3D82C7B1326F")

(setq auto-save-default nil)

(use-package org-mime)

;; I'm having problems with this
;;(add-hook 'org-mime-html-hook
;;(lambda ()
;;(org-mime-change-element-style
;;"pre" (format "color: %s; background-color: %s; padding: 0.5em;"
;;"#E6E1DC" "#232323"))))

;; I'm having problems with this
;;(add-hook 'org-mime-html-hook
;;(lambda ()
;;(org-mime-change-element-style
;;"blockquote" "border-left: 2px solid gray; padding-left: 4px;")))

;; ob-http is needed to run http calls inside org-mode
(use-package ob-http :ensure t)
(setq geiser-default-implementation 'guile)

(after-load 'org
    (org-babel-do-load-languages
     'org-babel-load-languages
     '(
       (awk . t)
       (calc .t)
       (C . t)
       (emacs-lisp . t)
       (haskell . t)
       (gnuplot . t)
       (latex . t)
       ;;(ledger . t)
       (js . t)
       (haskell . t)
       (http . t)
       (perl . t)
       (python . t)
       ;; (gnuplot . t)
       ;; org-babel does not currently support php.  That is really sad.
       ;;(php . t)
       (R . t)
       (scheme . t)
       (sh . t)
       (sql . t)
       ;;(sqlite . t)
       )))

       (setq org-latex-create-formula-image-program 'imagemagick)
  ;; DO NOT set up ditaa.  It breaks (helm-find-files) C-x C-f
  ;;(ditaa . t)
  ;;(setq org-ditaa-jar-path "/usr/share/java/ditaa/ditaa-0_9.jar")
  ;; display inline images in org-mode
  ;;(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

(use-package org-invoice)

(use-package org-notify)
(org-notify-start)

(org-notify-add 'appt
                '(:time "-1s" :period "20s" :duration 10
                        :actions (-message -ding))
                '(:time "15m" :period "2m" :duration 100
                        :actions -notify)
                '(:time "2h" :period "5m" :actions -message)
                '(:time "3d" :actions -email))

(use-package org-inlinetask)

(use-package org-habit)

(require 'org-protocol)

(require 'org-id)
(setq org-id-link-to-org-use-id t)

(defun yas/org-very-safe-expand ()
    (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

;; I want to get write-good-mode set up again, because it's awesome.
(use-package writegood-mode :ensure t :defer t)

(add-hook 'org-mode-hook '(lambda ()

                                ;; https://bitbucket.org/ukaszg/org-eldoc org eldoc looks cool
                                ;; but I can't get it to work
                                ;; (require 'org-eldoc)
                                ;;(org-eldoc-load)
                                ;; (make-variable-buffer-local 'yas/trigger-key)
                                ;;(setq yas/trigger-key [tab])
                                ;;(add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
                                ;; (define-key yas/keymap [tab] 'yas/next-field)
                                ;; make the lines in the buffer wrap around the edges of the screen.
                                ;; YES!!!!! These next two modes auto-indents org-buffers as you type!  NO NEED FOR
                                ;; to press C-c q  or fill-paragraph ever again!
                                (visual-line-mode)
                                (org-indent-mode)
                                (require 'writegood-mode)
                                ;; apparently this does the same thing as the above combined modes
                                ;; this seems to work better than visual line mode.  Why have I not heard of this before?
                                ;;(toggle-word-wrap)
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
                                (push '("\\checkmark" . ?✓) prettify-symbols-alist)
                                (push '("\\check" . ?✓) prettify-symbols-alist)
                                (push '("1/4" . ?¼) prettify-symbols-alist)
                                (push '("1/2" . ?½) prettify-symbols-alist)
                                (push '("3/4" . ?¾) prettify-symbols-alist)
                                (push '("1/7" . ?⅐) prettify-symbols-alist)
                                ;; ⅕ ⅖ ⅗ ⅘ ⅙ ⅚ ⅛ ⅜ ⅝ ⅞
                                (push '("ae" . ?æ) prettify-symbols-alist)
                                (push '("^_^" . ?☻) prettify-symbols-alist)))

(setq
 ;; hide the leading stars in my org files
 org-hide-leading-stars t
 ;;seeing the ... that org mode does to how you that the heading continues in the text beneith it is kind of boring
 ;; http://endlessparentheses.com/changing-the-org-mode-ellipsis.html?source=rss
 ;; Other interesting characters are ↴, ⬎, ⤷, and ⋱.
 org-ellipsis " ↴"
 ;; make RET follow a link
 org-return-follows-link t
 ;; only show times on items in the agenda, if we have an item at a specified time
 ;; if we set it to true, then we see all the times every 2 hours.  Takes up too much space.
 org-agenda-use-time-grid nil
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
 org-bullets-bullet-list
 '("◉" "◎" "♠" "○" "►" "◇")
 org-modules '(org-bbdb org-gnus org-info org-invoice man org-toc org-habit org-mime org-crypt org-bullets org-id)
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
                                           "~/programming/org/projects/managing-my-monies.org" "things I want to buy")
         "* %?\nEntered on %U\n  %i\n  %a")

        ("c" "Computers Anything")
        ("ca" "Awesome WM" entry (file+headline "~/programming/org/gtd.org" "awesome WM someday")
         "* TODO %?\nEntered on %U\n  %i\n  %a")


         ;; Emacs things
        ("ce" "Emacs")

        ("ceb" "bugs" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "Emacs bugs")
         "* TODO %?\n  %i\n  %a")

        ("ceb" "evil-mode" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "evil-mode")
         "* TODO %?\n  %i\n  %a")

        ("cef" "flycheck" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "flycheck-mode")
         "* TODO %?\n  %i\n  %a")

        ("ceM" "Emacs Meetup" entry (file+headline "~/programming/org/projects/emacs-meetup-vincent-laf-emacslaf.org" "things to talk about")
         "* %?\nEntered on %U\n  %i\n  %a")

        ("ceo" "Org-mode" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "org-mode")
         "* TODO %?\n  %i\n  %a")

        ("cee" "emacs Todo" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "emacs someday")
         "* TODO %?\n  %i\n  %a")

        ("ceE" "Emacs Reference" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "emacs reference")
         "* %?\nEntered on %U\n  %i\n  %a")
         ;;End Emacs things


        ("cG" "Gimp Basics Reference" entry (file+headline "~/manuals/gimp.org" "Basic Concepts")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("cH" "The GNU HURD")
        ("cHt" "Hurd" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org"
                                           "Hurd")
         "* TODO %?\n  %i\n  %a")
        ("ct" "General Computer TODO"
         entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "General TODO")
         "* TODO %?\n  %i\n  %a")
        ("cw" "Waypoint")
        ("cwi" "ibca Web App")
        ("cwib" "bugs that need fixin'" entry (file+headline "~/programming/org/projects/working-for-waypoint.org"
                                                             "bugs that need fixin'")
         "* TODO %?\n  %i\n  %a")
        ("cwic" "core features that must be done" entry (file+headline "~/programming/org/projects/working-for-waypoint.org"
                                                                       "core features that must be done")
         "* TODO %?\n  %i\n  %a")
        ("cwif" "features the app should have" entry (file+headline "~/programming/org/projects/working-for-waypoint.org"
                                                                    "features the app should have") "* TODO %?\n  %i\n  %a")
        ("cwir" "IBCA Reference" entry (file+headline "~/programming/org/projects/working-for-waypoint.org"
                                                      "IBCA Reference") "* %?\nEntered on %U\n  %i\n  %a")
        ("cwiw" "what I have done" entry (file+headline "~/programming/org/projects/working-for-waypoint.org"
                                                        "what I have done") "* DONE %?\n  %i\n  %a")
        ("ch" "high star todo"
         entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "make high star an android app")
         "* todo %?\n  %i\n  %a")
        ("cl" "linux TODO" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "linux someday")
         "* TODO %?\n  %i\n  %a")
        ("cL" "Linux Reference" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "linux reference")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("co" "organ TODO" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "make organ an android app")
         "* TODO %?\n  %i\n  %a")
        ("cf" "Free the world" entry (file+headline "~/programming/org/gtd.org" "free the world free content")
         "* %?\nEntered on %U\n  %i\n  %a")

        ("cW" "Web")

        ("cWA" "Accrisoft Reference" entry (file+headline "~/programming/org/web.org" "Accrisoft reference")
         "* %?\nEntered on %U\n  %i\n  %a")

        ("cWB" "Bootstrap Reference" entry (file+headline "~/programming/org/web.org" "Bootstrap reference")
         "* %?\nEntered on %U\n  %i\n  %a")

        ("cWS" "Shoppify Reference" entry (file+headline "~/programming/org/web.org" "Shoppify reference")
         "* %?\nEntered on %U\n  %i\n  %a")

        ("cWW" "Web reference" entry (file+headline "~/programming/org/web.org" "Web reference")
         "* %?\nEntered on %U\n  %i\n  %a")


        ("C" "Community")
        ("Cc" "community TODO" entry (file+headline "~/programming/org/gtd.org" "community someday")
         "* TODO %?\n  %i\n  %a")

        ("Cn" "nice things to say" entry (file+headline "~/programming/org/projects/get-close-to-God.org" "nice things to say")
         "* TODO %?\nEntered on %U\n  %i\n  %a")
        ("Cs" "Social Skills Notes" entry (file+headline "~/programming/org/being-social.org" "Social Skills Notes")
         "* %?\nEntered on %U\n  %i\n  %a")

        ("C" "Calendar TODO" entry (file+headline "~/programming/org/gtd.org" "calendar")
         "* TODO %?\n  %i\n  %a")

        ("e" "entertainment")
        ("eb" "Books to Read" entry (file+headline "~/programming/org/projects/whatever-I-want.org"
                                                   "Books to Read") "*  %i\n  %a")
        ("eM" "Good Movies Reference" entry (file+headline "~/programming/org/projects/whatever-I-want.org" "Good Movies") "*  %i\n  %a")
        ("em" "movies to watch" entry (file+headline "~/programming/org/projects/whatever-I-want.org" "movies to watch") "*  %i\n  %a")
        ("eU" "good music reference" entry (file+headline "~/programming/org/projects/whatever-I-want.org"
                                                          "good music reference") "*  %i\n  %a")
        ("eg" "games to play" entry (file+headline "~/programming/org/projects/whatever-I-want.org"
                                                   "games to play") "*  %i\n  %a")

        ("g" "getting close to God")
        ("gg" "get a close friend" entry (file+headline "/home/joshua/programming/org/projects/get-close-to-God.org"
                                                        "get a close friend") "* TODO %?\n  %i\n  %a")
        ("gb" "Boundaries")
        ("gbn" "Boundary Notes" entry (file+headline "~/programming/org/gtd.org" "Boundary Notes")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("gbl" "Lowering My Expectations of Myself" entry (file+headline "~/programming/org/gtd.org"
                                                                         "Lowering My Expectations of Myself")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("gbs" "Boundaries To Enforce" entry (file+headline "~/programming/org/projects/get-close-to-God.org" "Setting Boundaries")
         "* TODO %?\n  %i\n  %a")



        ("M" "Math")
        ("Mf" "fun math problems" entry (file+headline "/home/joshua/programming/org/projects/math.org" "fun math problems") "* TODO %?\n  %i\n  %a")
        ("p" "payless TODO" entry (file+headline "~/programming/org/gtd.org" "shopping todo")
         "* TODO %?\n  %i\n  %a")
        ("r" "Reference" entry (file+headline "~/programming/org/gtd.org" "general reference")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("t" "TODO" entry (file+headline "~/programming/org/gtd.org" "general todo")
         "* TODO %?\nEntered on %U\n  %i\n  %a")
        ("w" "Weblink" entry (file (expand-file-name "~/programming/org/gtd.org" "org capture"))
         "* %c\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  - Quote:\n    %i" :unnarrowed)

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

(setq my-org-agenda-directories '("~/programming/org/" "~/programming/org/"
                                  "~/programming/org/projects"))
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

(setq org-refile-targets '((nil :maxlevel . 2)
                           (org-agenda-files :tag . "capture")
                           (org-agenda-files :maxlevel . 2)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling

(setq org-agenda-custom-commands
      '(
        ;; a global search for agenda entries planned this week/day
        ("x" agenda)

        ;; a global search for agenda entries planned this week/day, but
        ;;only those with hour specifications
        ("y" agenda*)

        ;; a global searcher with "WAITING" as the TODO keywoard
        ;; but I don't use waiting as a keyword
        ;; ("w" todo "WAITING")
        ;; ("w" todo "WAITING")

        ("D" todo "DELEGATED" )

        ;; the same search bit with searching for projects
        ("P" todo "PROJECT")


        ("S" todo "STARTED" )

        ("c" todo "CHARGED")

        ;; the same search but only in the current buffer and displaying the
        ;; results as a sparse tree
        ("W" todo-tree "WAITING")

        ;; a global search for headlines marked :boss: bot not :urgent:
        ("u" tags "+boss-urgent")

        ;; The same search but limiting the search to items that are TODO items
        ("v" tags-todo "+boss-urgent")

        ;; the same search as C-c a u but only in the current buffer displaying
        ;; the results in a sparse tree
        ("U" tags-tree "+boss-urgent")

        ;; Create a sparse tree in the current buffer with all entries containing
        ;;the word FIXME
        ("f" occur-tree "\\<FIXME\\>")

        ;;
        ;; ("h" . "HOME+Name tags searches") ; description for "h" prefix
        ;; ("hl" tags "+home+Lisa")
        ;; ("hp" tags "+home+Peter")
        ;; ("hk" tags "+home+Kim")


      ;; ("H" "Office and Home Lists"
      ;; ((agenda)
      ;; (tags-todo "OFFICE")
      ;; (tags-todo "HOME")
      ;; (tags-todo "COMPUTER")
      ;; (tags-todo "DVD")
      ;; (tags-todo "READING")))
        )
      )

(defun my/org-grading-myself-agenda ()
"This function loads up my grading myself toolset."
(interactive)
(let (org-agenda-files)
  (setq org-agenda-files '("/home/joshua/programming/org/projects/grading-myself.org"))
  (org-agenda-list)))

(org-defkey org-agenda-mode-map "g" 'org-agenda-filter-by-category)
;;(org-defkey global-map (kbd "C-c a g") 'org-agenda-filter-by-category)

(defun my/org-grading-myself-agenda-and-regular-agenda ()
  "This function loads up my grading myself toolset."
  (interactive)
  (add-to-list 'org-agenda-files '"/home/joshua/programming/org/projects/grading-myself.org")
  (org-agenda-list)
  ;;how do you remove an element from a list?  I have no idea.
  )

; Targets start with the file name - allows creating level 1 tasks
  (setq org-refile-use-outline-path (quote file))

(setq org-todo-keywords
      '((sequence "TODO(t!)" "PROJECT(r)" "STARTED(s!)"
                  "WAITING(w!)" "CHARGED(c!)" "|" "PAID(p!)" "DONE(d!)")))


(setq org-todo-keyword-faces
      '(("PROJECT" . "#4da6ff")
        ("STARTED" . "#ffff99")
        ("WAITING" . "#ffcc00")
        ("CHARGED" .  "#e085e0")))



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
;;(use-package org-pomodoro
;;  :ensure t)
;;(after-load 'org-agenda
;;  (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro))

(setq org-stuck-projects '("PROJECT" ("TODO NEXT") ("action") "\\<IGNORE\\>" ))

(defhydra hydra-outline (:color pink :hint nil)
  "
^Hide^             ^Show^           ^Move
^^^^^^------------------------------------------------------
_hs_: sublevels     _sa_: all         _u_: up
_hb_: body          _se_: entry       _n_: next visible
_ho_: other         _sc_: children    _p_: previous visible
_he_: entry         _sb_: branches    _f_: forward same level
_hl_: leaves        _st_: subtree     _b_: backward same level
_ht_: subtree

"
  ;; Hide
  ("hs" hide-sublevels)    ; Hide everything but the top-level headings
  ("hb" hide-body)         ; Hide everything but headings (all body lines)
  ("ho" hide-other)        ; Hide other branches
  ("he" hide-entry)        ; Hide this entry's body
  ("hl" hide-leaves)       ; Hide body lines in this entry and sub-entries
  ("ht" hide-subtree)      ; Hide everything in this entry and sub-entries
  ;; Show
  ("sa" show-all)          ; Show (expand) everything
  ("se" show-entry)        ; Show this heading's body
  ("sc" show-children)     ; Show this heading's immediate child sub-headings
  ("sb" show-branches)     ; Show all sub-headings under this heading
  ("st" show-subtree)      ; Show (expand) everything in this heading & below
  ;; Move
  ("u" outline-up-heading)                ; Up
  ("n" outline-next-visible-heading)      ; Next
  ("p" outline-previous-visible-heading)  ; Previous
  ("f" outline-forward-same-level)        ; Forward - same level
  ("b" outline-backward-same-level)       ; Backward - same level

  ("z" nil "leave"))

(define-key org-mode-map (kbd "C-c #") 'hydra-outline/body) ; by example
(global-set-key (kbd "C-c #") 'hydra-outline/body)

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
