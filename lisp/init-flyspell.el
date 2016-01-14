;; enable flyspell for all program modes.  This will highlight words that are misspelled in comments
(add-hook 'prog-mode-hook (lambda ()
                           (flyspell-prog-mode)))
;; enable flyspell mode for all of my text modes.  This will enable flyspell to underline misspelled words.
(add-hook 'text-mode-hook (lambda ()
                           (flyspell-mode)))


(provide 'init-flyspell)
