;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------
;; make all questions ask you y for yes and n for no
(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(load-theme 'zenburn t)

(find-file "/home/joshua/programming/org/gtd/gtd.org")

(provide 'init-misc)
