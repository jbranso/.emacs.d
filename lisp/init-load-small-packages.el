
(dolist (hook '(org-mode-hook
                prog-mode-hook
                text-mode-hook))
  (add-hook hook (lambda ()
                   (abbrev-mode 1)
                   (diminish 'abbrev-mode))))

(use-package avy
  :ensure t
  :defer t
  :config
  (setq avybackground t
   avy-highlight-first t)
  ;; https://github.com/abo-abo/avy
  (setq  avy-keys (number-sequence ?e ?t )))

;;(org-babel-load-file "/home/joshua/programming/emacs/autocorrect/autocorrect.org" )

(use-package which-key :ensure t
  :config (which-key-mode))

(use-package bug-hunter :ensure t :defer t)
