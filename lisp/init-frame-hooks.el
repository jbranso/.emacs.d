(defvar after-make-console-frame-hooks '()
  "Hooks to run after creating a new TTY frame")
(defvar after-make-window-system-frame-hooks '()
  "Hooks to run after creating a new window-system frame")

(defun run-after-make-frame-hooks (frame)
  "Run configured hooks in response to the newly-created FRAME.
Selectively runs either `after-make-console-frame-hooks' or
`after-make-window-system-frame-hooks'"
  (with-selected-frame frame
    (run-hooks (if window-system
                   'after-make-window-system-frame-hooks
                 'after-make-console-frame-hooks))))

(add-hook 'after-make-frame-functions 'run-after-make-frame-hooks)

(defconst sanityinc/initial-frame (selected-frame)
  "The frame (if any) active during Emacs initialization.")

(add-hook 'after-init-hook
          (lambda () (when sanityinc/initial-frame
                  (run-after-make-frame-hooks sanityinc/initial-frame))))

(add-hook 'before-save-hook
          #'(lambda ()
              ;; (if THEN ELSE)
              (if (not (eq (buffer-name) "Makefile"))
                  ;; (prog1 FORM Body)
                  (prog1
                      (delete-trailing-whitespace)
                    (indent-region (point-min (point-max))))
                (indent-region (point-min) (point-max)))))


(provide 'init-frame-hooks)
