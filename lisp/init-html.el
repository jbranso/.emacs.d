(use-package web-mode :ensure t :config
  ;;I'm not sure what this does
  (setq web-mode-extra-constants '(("php" . ("CONS1" "CONS2"))))
  ;; <?php expands to <?php ?>
  (setq web-mode-enable-auto-pairing t)
  ;; Example - you may want to add hooks for your own modes.
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml?\\'" . web-mode))
  ;; I don't use php-mode and it is causing an error to load it in.
  ;;(use-package php-mode :ensure t)
  (add-to-list 'auto-mode-alist '("\\.php?\\'"  . web-mode))
  ;; when I open a css file use css-mode that way I can set up flychech with it!
  ;;(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.css?\\'" . css-mode))
  (setq web-mode-extra-auto-pairs
        '(("erb"  . (("beg" "end")))
          ("php"  . (("beg" "end")
                     ("beg" "end")))
          ))
  (setq web-mode-engines-alist
        '(("php"  . "\\.php\\.")
          ("django"  . "\\.djhtml\\.")))
  )

(add-hook 'web-mode-hook '(lambda ()
                            ;;(use-package emmet-mode :ensure t)
                            ;; I've installed http://phpmd.org/ to check my php code using flycheck
                            ;; BUT flycheck mode does NOT support web-mode
                            ;; I can't get ggtags mode to workwell.
                            ;; (ggtags-mode 1)
                            ;; (diminish 'ggtags-mode)
                            ;; I have abbrev turned on for all prog-modes and all text modes.
                            ;; (abbrev-mode 1)
                            ;;emmet mode for html % css related things
                            (emmet-mode)
                            (diminish 'emmet-mode)
                            ;; turn urls into clickable links.
                            (goto-address-mode)
                            (local-unset-key (kbd "C-<return>"))
                            (define-key web-mode-map (kbd "C-<return>") '(lambda ()
                                                                           (interactive)
                                                                           (newline)
                                                                           (evil-open-above 0)))
                            ;;(push '("function" . ?𝆑) prettify-symbols-alist)
                            (push '(">=" . ?≥) prettify-symbols-alist)
                            (push '("<=" . ?≤) prettify-symbols-alist)
                            (push '("\\geq" . ?≥) prettify-symbols-alist)
                            (push '("\\leq" . ?≤) prettify-symbols-alist)
                            (push '("\\neg" . ?¬) prettify-symbols-alist)
                            (push '("\\rightarrow" . ?→) prettify-symbols-alist)
                            (push '("\\leftarrow" . ?←) prettify-symbols-alist)
                            (push '("\\infty" . ?∞) prettify-symbols-alist)
                            ;; this would make a comment look really weird <--  right-arrow
                            ;;(push '("-->" . ?→) prettify-symbols-alist)
                            (push '("<--" . ?←) prettify-symbols-alist)
                            (push '("\\exists" . ?∃) prettify-symbols-alist)
                            (push '("\\nexists" . ?∄) prettify-symbols-alist)
                            (push '("\\forall" . ?∀) prettify-symbols-alist)
                            (push '("\\or" . ?∨) prettify-symbols-alist)
                            (push '("\\and" . ?∧) prettify-symbols-alist)
                            (push '(":)" . ?☺) prettify-symbols-alist)
                            ;;(push '("):" . ?☹) prettify-symbols-alist)
                            (push '(":D" . ?☺) prettify-symbols-alist)
                            (push '("^_^" . ?☻) prettify-symbols-alist)
                            ;; I should not enable aggressive indent mode for soihub files.
                            ;; There's no need to have lots of git diffs with files.
                            ;; unset web mode's C-c C-h command, because I want to use that for 'help
                            (local-unset-key (kbd "C-c C-h"))
                            (global-set-key (kbd "C-c C-h") 'help)))

(use-package emmet-mode :ensure t)

(add-hook 'web-mode-hook 'my/add-web-mode-richtext)

(defun my/add-web-mode-richtext ()
  "Add bold and italic text with <b> and <em> tags."
  (interactive)
  (highlight-regexp "<em>\\([-_a-zA-Z0-9@!?$&* ]+\\)</em>" 'web-mode-italic-face)
  (highlight-regexp "<b>\\([-_a-zA-Z0-9@!?$&* ]+\\)</b>" 'web-mode-bold-face))

(defun my-js-minify-function ()
  "Minifying my js files."
  (interactive)
  (async-shell-command (concat (format "closure --js  %s --js_output_file "
                                       (buffer-file-name))
                               (s-replace ".js" ".min.js" buffer-file-name)) "*js minifying*"))

(add-hook 'js2-mode-hook '(lambda ()
                            ;; I have abbrev turned on for all prog and text modes
                            ;; (abbrev-mode 1)
                            ;; (skewer-mode)
                            (ggtags-mode 1)
                            ;;(push '("function" . ?𝆑) prettify-symbols-alist)
                            (push '(">=" . ?≥) prettify-symbols-alist)
                            (push '("<=" . ?≤) prettify-symbols-alist)
                            (diminish 'ggtags-mode)
                            (add-hook 'after-save-hook 'my-js-minify-function nil t)))

(add-to-list 'display-buffer-alist (cons "\\\*js minifying\\\*" (cons #'display-buffer-no-window nil)))

(defun my-css-minify-function ()
  "Minifying my css files."
  (interactive)
  (async-shell-command (concat (format "yuicompressor --type css  %s -o "
                                       (buffer-file-name))
                               (s-replace ".css" ".min.css" buffer-file-name)) "*css minifying*"))

(add-to-list 'display-buffer-alist (cons "\\\*css minifying\\\*" (cons #'display-buffer-no-window nil)))

(add-hook 'css-mode-hook '(lambda ()
                            (add-hook 'after-save-hook 'my-css-minify-function nil t)))

(provide 'init-html)
