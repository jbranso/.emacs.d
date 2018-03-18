(defun my-just-one-space ()
  (interactive)
  (if (org-at-table-p)
      (org-table-blank-field)
    (just-one-space)))

(use-package org :bind (:map org-mode-map ("C-c SPC" . my-just-one-space))
  :ensure org-plus-contrib)

(use-package org-mime :ensure t :defer t)

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

;; TODO FIXME this defun needs to be deleted
;; the org-mode has removed org-babel-get-header
;; ob-sh needs to update to use the new version.
(defun org-babel-get-header (params key &optional others)
  (delq nil
        (mapcar
         (lambda (p) (when (funcall (if others #'not #'identity) (eq (car p) key)) p))
         params)))

(after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (awk . t)
     (calc . t)
     (C . t)
     (emacs-lisp . t)
     (haskell . t)
     ;;(http . t)
     (gnuplot . t)
     ;;(latex . t)
     (ledger . t)
     (js . t)
     (perl . t)
     (python . t)
     (gnuplot . t)
     ;;org-babel does not currently support php.  That is really sad.
     ;;(php . t)
     ;;(R . t)
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

(require 'org-id)
  (add-hook 'org-mode-hook '(lambda ()
                              (setq org-id-link-to-org-use-id t)))

(use-package gnuplot :ensure t)

(defun yas/org-very-safe-expand ()
    (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(defun my/auto-call-fill-paragraph-for-org-mode ()
    "Call two modes to automatically call fill-paragraph for you."
    (visual-line-mode)
    (org-indent-mode))

(add-hook 'org-mode-hook 'my/auto-call-fill-paragraph-for-org-mode)

(defun my/turn-strings-into-utf8-chars ()
  "Turn strings like '<=' into '≤'."
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
  (push '("\\lambda" . ?λ) prettify-symbols-alist)
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
  (push '("^_^" . ?☻) prettify-symbols-alist))

(add-hook 'org-mode-hook 'my/turn-strings-into-utf8-chars)

(setq org-hide-leading-stars t)

(setq org-ellipsis " ↴")

(setq org-return-follows-link t)

(setq org-startup-with-inline-images t)

(setq org-catch-invisible-edits 'show-and-error)

(setq  org-log-into-drawer t)

(setq org-log-done 'time)

(setq org-edit-timestamp-down-means-later t)

(setq org-export-backends '(ascii beamer html texinfo latex))

(setq  org-bullets-bullet-list '("◉" "◎" "♠" "○" "►" "◇"))

(setq  org-tags-column 80)

;; (setq org-use-speed-commands t)

(setq org-confirm-babel-evaluate nil)

(setq
 ;; only show times on items in the agenda, if we have an item at a specified time
 ;; if we set it to true, then we see all the times every 2 hours.  Takes up too much space.
 ;; org-agenda-use-time-grid nil
 ;;org-log-done 'nil
 ;; this tells org-mode to only quit selecting tags for things when you tell it that you are done with it
 org-fast-tag-selection-single-key nil
 org-html-validation-link nil
 org-export-kill-product-buffer-when-displayed t
 org-modules '(org-bbdb org-gnus org-info org-invoice man org-toc org-habit org-mime org-crypt org-bullets org-id)
 ;; load in the org-modules
 ;;org-load-modules-maybe t
)

;;a visual hint to let you know what line you are in in org-mode agenda
(add-hook 'org-agenda-finalize-hook '(lambda () (hl-line-mode)))

(setq org-agenda-start-on-weekday nil)

(setq org-agenda-span 'week)

;;  (setq org-agenda-include-diary t)

(setq  org-agenda-window-setup 'current-window)

;; define what files org opens
(add-to-list 'auto-mode-alist '("\\.\\(org\\|txt\\)$" . org-mode))
;;(setq org-default-notes-file (concat org-directory "/notes.org"))

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
         ("ceR" "Emacs Reference")
        ("ceRR" "Emacs Reference" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "emacs reference")
         "* %?\nEntered on %U\n  %i\n  %a")
         ("ceRe" "emacs evil reference" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "evil reference")
         "* TODO %?\n  %i\n  %a")
         ("ceRg" "emacs gnus reference" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "gnus reference")
         "* TODO %?\n  %i\n  %a")
        ("ceRo" "emacs org reference" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "org reference")
         "* TODO %?\n  %i\n  %a")
        ("ceRm" "emacs magit reference" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "tags reference")
         "* TODO %?\n  %i\n  %a")
        ("ceRt" "emacs tags reference" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "tags reference")
         "* TODO %?\n  %i\n  %a")

         ("cet" "emacs Todo")
        ("cett" "emacs Todo" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "emacs someday")
         "* TODO %?\n  %i\n  %a")
        ("cete" "emacs evil someday" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "evil someday")
         "* TODO %?\n  %i\n  %a")
        ("cetf" "emacs flycheck someday" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "flycheck someday")
         "* TODO %?\n  %i\n  %a")
        ("cetg" "emacs gnus someday" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "gnus someday")
         "* TODO %?\n  %i\n  %a")
        ("ceth" "emacs helm someday" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "helm someday")
         "* TODO %?\n  %i\n  %a")
        ("ceto" "emacs org someday" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "org someday")
         "* TODO %?\n  %i\n  %a")
        ("cetT" "emacs tags someday" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "tags someday")
         "* TODO %?\n  %i\n  %a")
        ("cetw" "web-mode someday" entry (file+headline "~/programming/org/projects/become-an-awesome-hacker.org" "web-mode someday")
         "* TODO %?\n  %i\n  %a")
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

(provide 'init-org)
