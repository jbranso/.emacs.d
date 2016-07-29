(load-file "/home/joshua/programming/emacs/autocorrect/autocorrect.el")

(global-set-key (kbd "C-c $") #'autocorrect-ispell-word-the-abbrev)

(provide 'init-autocorrect)
