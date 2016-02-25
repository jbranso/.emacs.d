
;; this is not working right now.
;;(use-package org
;;:ensure org-plus-contrib)

;; define what files org opens
(add-to-list 'auto-mode-alist '("\\.\\(org\\|txt\\)$" . org-mode))
;;(setq org-default-notes-file (concat org-directory "/notes.org"))

(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))

(setq org-crypt-key "E99C48112E969A17")

(setq auto-save-default nil)

;; (require 'org-mime)

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
     ;; (gnuplot . t)
     ;; org-babel does not currently support php
     ;;(php . t)
     (sh . t)
     (sql . t)
     ;;(sqlite . t)
     (gnuplot . t)
     )))


;; DO NOT set up ditaa.  It breaks (helm-find-files) C-x C-f
;;(ditaa . t)
;;(setq org-ditaa-jar-path "/usr/share/java/ditaa/ditaa-0_9.jar")
;; display inline images in org-mode
;;(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

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

(require 'org-inlinetask)

(require 'org-habit)

(provide 'init-org)
