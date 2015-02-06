;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------
;; make all questions ask you y for yes and n for no
(fset 'yes-or-no-p 'y-or-n-p)

(dolist (hook (if (fboundp 'prog-mode)
                  '(prog-mode-hook ruby-mode-hook)
                '(find-file-hooks)))
  (add-hook hook 'goto-address-prog-mode))
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(setq goto-address-mail-face 'link)

(setq-default regex-tool-backend 'perl)

(add-auto-mode 'conf-mode "Procfile")


(provide 'init-misc)
