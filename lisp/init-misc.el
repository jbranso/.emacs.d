;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------
;; make all questions ask you y for yes and n for no
(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; oooo zenburn makes emacs look beautiful!
(use-package zenburn-theme :ensure t)

(find-file "/home/joshua/programming/org/gtd/gtd.org")
;;(org-agenda-list)
;; I found this next line from
;; http://emacslife.com/baby-steps-org.html#sec-9
;;(org-agenda nil "a")

(my/org-grading-myself-agenda)

(provide 'init-misc)
