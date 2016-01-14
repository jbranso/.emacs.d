;; enable flyspell for all program modes.
;;This will highlight words that are misspelled in comments
;; Also flyspell binds C-c $ to flyspell fix word before point.  BUT I would prefer that to be bound to
;; endless/ispell-word-then-abbrev
(add-hook 'prog-mode-hook (lambda ()
                            (flyspell-prog-mode)
                            (unbind-key (kbd "C-c $") flyspell-mode-map)
                            (global-set-key (kbd "C-c $") #'endless/ispell-word-then-abbrev)))

;; enable flyspell mode for all of my text modes.  This will enable flyspell to underline misspelled words.
(add-hook 'text-mode-hook (lambda ()
                            (flyspell-mode)
                            (unbind-key (kbd "C-c $") flyspell-mode-map)
                            (global-set-key (kbd "C-c $") #'endless/ispell-word-then-abbrev)))

(provide 'init-flyspell)
