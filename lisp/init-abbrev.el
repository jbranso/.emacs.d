;; add abbrev-mode to text modes and program modes to turn on autocorrect like functionality
(dolist (hook '(prog-mode-hook
                text-mode-hook))
  (add-hook hook (lambda () (abbrev-mode 1))))

(provide 'init-abbrev)
