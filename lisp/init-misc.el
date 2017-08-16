(fset 'yes-or-no-p 'y-or-n-p)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(use-package zenburn-theme :ensure t)

;; (find-file-noselect "/home/joshua/honorscollege/site-ideas/honors-college-gtd.org")
(org-agenda nil "a")

(provide 'init-misc)
