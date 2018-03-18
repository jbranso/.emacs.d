(fset 'yes-or-no-p 'y-or-n-p)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(use-package zenburn-theme :ensure t)

(add-hook 'after-init-hook 'org-agenda-list)

(provide 'init-misc)
