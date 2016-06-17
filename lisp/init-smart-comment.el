
;; with point in the or beginning middle of the line comment out the whole line
;; with point at the end of the line, add a comment to the left of the line
;; with a region marked, marked the region for delition with "C-u C-c"
;; delete the marked regions and lines with "C-u C-u C-c"
(use-package smart-comment
  :ensure t
  :defer t
  :config
  (with-eval-after-load 'org
    (local-unset-key "C-c ;"))
  (global-set-key (kbd "C-c ;") 'smart-comment))
(provide 'init-smart-comment)
