(use-package sunrise)

;; disable mouse
(setq sr-cursor-follows-mouse nil)
;; I want to be able to open a file on mouse click right?
;;(define-key sr-mode-map [mouse-1] nil)
(define-key sr-mode-map [mouse-movement] nil)

;;tweak faces for paths
(set-face-attribute 'sr-active-path-face nil
                    :background "black")
(set-face-attribute 'sr-passive-path-face nil
                    :background "black")

;;advise sunrise to save frame arrangement
;;requires frame-cmds package
(defun bjm-sc-save-frame ()
  "Save frame configuration and then maximise frame for sunrise commander."
  (save-frame-config)
  (maximize-frame)
  )
(advice-add 'sunrise :before #'bjm-sc-save-frame)

(defun bjm-sc-restore-frame ()
  "Restore frame configuration saved prior to launching sunrise commander."
  (interactive)
  (jump-to-frame-config-register)
  )
(advice-add 'sr-quit :after #'bjm-sc-restore-frame)

(provide 'init-sunrise)
