(add-hook 'find-file-hook 'auto-insert)
(setq auto-insert-directory "~/.emacs.d/auto-insert-directory/")
(add-hook 'after-init-hook 'auto-insert-mode)

(add-to-list auto-insert-alist '(
(('web-mode . "The default template to open in webmode") . "default-html-file.txt")
((".*html.*" . "The default template to open in webmode") . "default-html-file.txt")))

(provide 'init-autoinsert)
