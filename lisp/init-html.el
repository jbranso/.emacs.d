;; here is a nice web-mode element hydra

(defhydra hydra-webmode (:color pink :hint nil)
  "
^Hide/Kill^              ^Move
^^^^^^--------------------------------------------
_f_: _f_old element       _b_: element _b_eginning
_k_: kill _e_lement       _e_: element _e_nd
_v_: element vanish       _n_: _n_ext element
                          _p_: _p_revious element
                          _t_: _t_ranspose element
                          _w_: element _w_rap
                          _p_: _P_arent element

"
  ;; Hide
  ("f" web-mode-fold-or-unfold)    ; Hide everything but the top-level headings
  ("k" web-mode-element-kill)         ; Hide everything but headings (all body lines)
  ("v" web-mode-element-vanish)        ; Hide other branches
  ;; Move
  ("b" web-mode-element-beginning)                ; Up
  ("e" web-mode-element-end)      ; Next
  ("n" web-mode-element-next)  ; Previous
  ("p" web-mode-element-previous)        ; Forward - same level
  ("t" web-mode-element-transpose)       ; Backward - same level
  ("w" web-mode-element-wrap)       ; Backward - same level
  ("P" web-mode-element-parent)       ; Backward - same level

  ("z" nil "leave"))

;; I'll have to enable this at some point too.
;; (define-key org-mode-map (kbd "C-c #") 'hydra-outline/body) ; by example
;; (global-set-key (kbd "C-c #") 'hydra-outline/body)


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


(use-package php-eldoc :ensure t)
(use-package web-mode :ensure t)
(use-package emmet-mode :ensure t)
(use-package ggtags  :ensure t)

;;I'm not sure what this does
(setq web-mode-extra-constants '(("php" . ("CONS1" "CONS2"))))
(setq web-mode-enable-current-column-highlight t)
;; <?php expands to <?php ?>
(setq web-mode-enable-auto-pairing t)
;; Example - you may want to add hooks for your own modes.
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml?\\'" . web-mode))
;; I want to enable the next line at some point.
;; BUT I need to enable the yasnippets for php mode AND fix phpcs, which I have a capture for somewhere
(use-package php-mode :ensure t)
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


(setq web-mode-ac-sources-alist
      '(("css" . (ac-source-css-property ac-source-html-bootstrap+))
        ("html" . (ac-source-words-in-buffer
                   ac-source-abbrev
                   ;;no need for yasnippet in html emmet mode is sooo much better
                   ;; also auto complete and yasnippet do NOT play well together
                   ;;ac-source-yasnippet
                   ac-source-emmet-html-aliases
                   ac-source-emmet-html-snippets
                   ac-source-html-tag
                   ac-source-html-attribute
                   ac-source-html-attribute-2
                   ac-source-files-in-current-dir
                   ))
        ("php" . (
                  ac-source-words-in-buffer
                  ;; DO NOT SET ac-source yasnippet. autocomplete does NOT play nicely with ac-source yasnippet
                  ;; ac-source-yasnippet
                  ;; Here are some pages that talk about getting yas and autocomplete to play nicely together
                  ;; http://sethlakowske.com/why-i-use-emacs/fix-yasnippet-and-autocomplete-tab-key-collision/
                  ;; https://stackoverflow.com/questions/19900949/how-to-make-auto-complete-work-with-yasnippet-and-abbrev
                  ;; https://github.com/capitaomorte/yasnippet/issues/336
                  ;; https://emacs.stackexchange.com/questions/9670/yasnippet-not-working-with-auto-complete-mode
                  ac-source-filename
                  ;;I'm being more and more annoyed with ac-php
                  ;; https://github.com/xcwen/ac-php/
                  ;;ac-source-php
                  ))))


(add-hook 'web-mode-hook (lambda ()
                           ;;(use-package emmet-mode :ensure t)
                           ;; I've installed http://phpmd.org/ to check my php code using flycheck
                           ;; BUT flycheck mode does NOT support web-mode
                           (php-eldoc-enable)
                           (ggtags-mode 1)
                           ;; I have abbrev turned on for all prog-modes and all text modes.
                           ;; (abbrev-mode 1)
                           (diminish 'ggtags-mode)
                           ;;emmet mode for html % css related things
                           (emmet-mode)
                           (diminish 'emmet-mode)
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

(add-hook 'css-mode-hook (lambda () (abbrev-mode 1)))

;; use flycheck in php buffers as well. it's a real shame that flycheck doesn't support web-mode
(add-hook 'php-mode-hook (lambda ()
                           ;; I have abbrev mode turned on for all prog-modes and all text-modes
                           ;; (abbrev-mode 1)
                           (define-key php-mode-map (kbd "C-<return>") '(lambda ()
                                                                          (interactive)
                                                                          (newline)
                                                                          (evil-open-above 0)))
                           ;;(push '("function" . ?𝆑) prettify-symbols-alist)
                           (push '(">=" . ?≥) prettify-symbols-alist)
                           (push '("<=" . ?≤) prettify-symbols-alist)
                           (push '("->" . ?⟶) prettify-symbols-alist)
                           (push '("=>" . ?⟹) prettify-symbols-alist)
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
                           (setq ac-sources '(
                                              ac-source-filename
                                              ;;  ac-source-dictionary
                                              ac-source-words-in-buffer
                                              ))
                           ))




(add-hook 'js2-mode-hook (lambda ()
                           ;; I have abbrev turned on for all prog and text modes
                           ;; (abbrev-mode 1)
                           ;; (skewer-mode)
                           (ggtags-mode 1)
                           ;;(push '("function" . ?𝆑) prettify-symbols-alist)
                           (push '(">=" . ?≥) prettify-symbols-alist)
                           (push '("<=" . ?≤) prettify-symbols-alist)
                           (diminish 'ggtags-mode)
                           ;; this conflicts with the snippets, and it's seriously annoying
                           ;;(ac-js2-mode)
                           ;;set ac sources to nil for javascript that way it doesn't interfer with yasnippet
                           (setq ac-sources
                                 '(
                                   ac-source-filename
                                   ac-source-dictionary
                                   ))
                           ))


(provide 'init-html)
