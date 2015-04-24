(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
		("SConscript\\'" . python-mode))
              auto-mode-alist))

(require-package 'pip-requirements)

(defun my-python-compile ()
  "Use compile to run python programs"
  (interactive)
  (compile (concat "python " (buffer-name))))

(setq compilation-scroll-output t)

(add-hook 'python-mode 'run-python)

(define-key evil-normal-state-map (kbd "C-c o") #'my-python-compile)

(provide 'init-python-mode)
