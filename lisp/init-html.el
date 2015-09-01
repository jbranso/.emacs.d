(require 'web-mode)

;; This will probably come in handy.
(defun my-setup-indent (n)
  ;; web development
  (setq coffee-tab-width n) ; coffeescript
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n) ; css-mode
  )

(defun my-coding-style ()
  (interactive)
  (message "My coding style!")
  (setq indent-tabs-mode t) ; use tab instead of space
  (my-setup-indent 4) ; indent 4 spaces width
  )


;; I do this thing when switching project. It takes me no more than one minute. Since my project last at least three months, one minute is not a big deal.

;; Example - you may want to add hooks for your own modes.
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-mode))

(add-hook 'js2-mode-hook (lambda ()
                           (yas-minor-mode)
                           (yas-reload-all)
                           (skewer-mode)
                           (ggtags-mode 1)
                           ;;this conflicts with the snippets, and it's seriously annoying
                           ;;(ac-js2-mode)
                           ;;set ac sources to nil for javascript that way it doesn't interfer with yasnippet
                           (setq ac-sources
                                 '(
                                   ac-source-filename
                                   ac-source-dictionary
                                   ))
                           ))


(setq web-mode-engines-alist
      '(("php"  . "\\.php\\.")
        ("django"  . "\\.djhtml\\.")))

;; default html indentation
;; default css indentation
;; since I'm not using web-mode for css, I don't need this next line
;; default script indentation (php and js)
;; since I'm not using web-mode for js2-mode, I don't need the next line
;;(setq web-mode-code-indent-offset 4)

;;(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)
(add-hook 'web-mode-hook (lambda ()
                           ;;yas mode for php stuff
                           (yas-minor-mode)
                           (yas-reload-all)
                           (ggtags-mode 1)
                           ;;emmet mode for html % css related things
                           (emmet-mode)
                           (local-unset-key (kbd "C-<return>"))
                           (define-key web-mode-map (kbd "C-<return>") '(lambda ()
                                                                          (interactive)
                                                                          (newline)
                                                                          (evil-open-above 0)))
                           (push '("function" . ?𝆑) prettify-symbols-alist)
                           (push '(">=" . ?≥) prettify-symbols-alist)
                           (push '("<=" . ?≤) prettify-symbols-alist)
                           ;; I should not enable aggressive indent mode for soihub files.
                           ;; There's no need to have lots of git diffs with files.
                           ;; unset web mode's C-c C-h command, because I want to use that for 'help
                           (local-unset-key (kbd "C-c C-h"))
                           (global-set-key (kbd "C-c C-h") 'help)))

(setq web-mode-ac-sources-alist
      '(("css" . (ac-source-css-property ac-source-html-bootstrap+))
        ("html" . (ac-source-words-in-buffer ac-source-abbrev ac-source-html-bootstrap+ ac-source-yasnippet
                                             ac-source-html-tag
                                             ac-source-html-attribute
                                             ac-source-html-attribute-2
                                             ))
        ("php" . (ac-source-words-in-buffer
                  ac-source-yasnippet
                  ac-source-abbrev
                  ac-source-html-bootstrap+
                  ac-source-html-bootstrap))))


(provide 'init-html)
