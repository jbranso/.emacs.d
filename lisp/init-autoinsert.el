(defun my/yas-org-snippet ()
  (interactive)
  (yas-expand-snippet (yas-lookup-snippet "<org"))
  (evil-insert-state))

(defun my/yas-elisp-init-files-snippet ()
  (interactive)
  (yas-expand-snippet (yas-lookup-snippet "<elisp-init-files"))
  (evil-insert-state))


(defun my/cover-letter-file-snippet ()
  (interactive)
  (yas-expand-snippet (yas-lookup-snippet "<cover-letter"))
  (evil-insert-state))

(defun my/blog-entry-file-snippet ()
  (interactive)
  (yas-expand-snippet (yas-lookup-snippet "<blog-entry"))
  (evil-insert-state))

(defun my/yas-web-mode-snippet ()
  (interactive)
  (yas-expand-snippet (yas-lookup-snippet "<web-mode"))
  (evil-insert-state))

(require 'autoinsert)

(add-hook 'find-file-hook 'auto-insert)

(setq auto-insert-directory "~/.emacs.d/auto-insert-directory/")

(setq auto-insert-mode t
      auto-insert-query nil)

(setq auto-insert-alist '((web-mode . [my/yas-web-mode-snippet])
                          (org-mode . [my/yas-org-snippet])))

(add-to-list 'auto-insert-alist '((".*/lisp/.*\\.org$") . [my/yas-elisp-init-files-snippet]))

(add-to-list 'auto-insert-alist '((".*/cover-letters.*\\.org$") . [my/cover-letter-file-snippet]))

(add-to-list 'auto-insert-alist '((".*/my-wordpress-blog.*\\.org$") . [my/blog-entry-file-snippet]))

(provide 'init-autoinsert)
