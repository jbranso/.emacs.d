
;; First, Emacs doesn't handle less well, so use cat instead for the shell pager:
(setenv "PAGER" "cat")

(add-hook 'eshell-mode-hook (lambda ()
                              (setq ac-sources
                                    '(
                                      ;;using ac-source-filename IS super useful
                                      ;;it is only activated if you start to type a file like
                                      ;; "./", "../", or "~/" but then it's awesome!
                                      ac-source-filename
                                      )
                                    eshell-aliases-file "~/.emacs.d/alias"
                                    )))

(provide 'init-eshell)
