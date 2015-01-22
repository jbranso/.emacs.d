(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml?\\'" . web-mode))

(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("php"  . "\\.php\\.")
        ("django"  . "\\.djhtml\\.")))

(add-hook 'web-mode-hook (lambda ()
                           (flyspell-prog-mode)
                           (yas-minor-mode)
                           (yas-reload-all)
                           (push '("function" . ?𝆑) prettify-symbols-alist)
                           (push '(">=" . ?≥) prettify-symbols-alist)
                           (push '("<=" . ?≤) prettify-symbols-alist)
                           (aggressive-indent-mode)
                           (auto-fill-mode)))

(provide 'init-html)
