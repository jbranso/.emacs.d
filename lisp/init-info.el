;;; Code:
;;this lets you use the windmove commands inside an info buffer!!!! sooo cool!
(require 'info)
(define-key Info-mode-map (kbd "C-w h") 'windmove-down)
(define-key Info-mode-map (kbd "C-w t") 'windmove-up)
(define-key Info-mode-map (kbd "C-w n") 'windmove-left)
(define-key Info-mode-map (kbd "C-w s") 'windmove-right)
;; it would be awesome to make org-bullets be enabled on info files
;; (require 'org-bullets)
;; (add-hook  'Info-mode-hook '(lambda ()
;;                               (org-bullets-mode 1))

(provide 'init-info)
