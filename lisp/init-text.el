(add-hook 'text-mode-hook
          #'(lambda ()
              ;;(refill-mode)
              ;;(flyspell-mode)
              (set-fill-column 134)
              (push '(":)" . ?☺) prettify-symbols-alist)
              (push '("):" . ?☹) prettify-symbols-alist)
              (push '(":D" . ?☺) prettify-symbols-alist)
              (push '("^_^" . ?☻) prettify-symbols-alist)
              (push '(">=" . ?≥) prettify-symbols-alist)
              (push '("<=" . ?≤) prettify-symbols-alist)
              (ruler-mode)))

(provide 'init-text)
