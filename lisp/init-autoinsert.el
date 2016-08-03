(require 'autoinsert)
(add-hook 'find-file-hook 'auto-insert)
(setq auto-insert-directory "~/.emacs.d/auto-insert-directory/"
      auto-insert-mode t
      auto-insert t)

(add-to-list 'auto-insert-alist '(web-mode . ["default-html-file.txt"] ))

;;(add-to-list 'auto-insert-alist '(("^.*html.*$" . "The default template to open in webmode") . "default-html-file.txt"))

(add-to-list 'auto-insert-alist '(org-mode . ["default-org-file.txt"]))

;;(add-to-list 'auto-insert-alist '(("\.org\'" . "The default org template") . "default-org-file.txt"))

(provide 'init-autoinsert)
