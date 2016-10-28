
(use-package init-gnus-secret :defer t)

(setq
 message-signature
 "<hr>\nJoshua Branson\nWayPoint\nWeb Developer\njbranso.me\nSent From Emacs\nhttps://www.gnu.org/software/emacs/")

(setq  gnus-summary-line-format "%d %U%R%z%I%(%[%4L: %-23,23f%]%) %s \n")

(when window-system
  (setq gnus-sum-thread-tree-indent "  ")
  (setq gnus-sum-thread-tree-root "") ;; "● ")
  (setq gnus-sum-thread-tree-false-root "") ;; "◯ ")
  (setq gnus-sum-thread-tree-single-indent "") ;; "◎ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))
(setq gnus-summary-line-format
      (concat
       "%0{%U%R%z%}"
       "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
       "  "
       "%4{%-20,20f%}"               ;; name
       "  "
       "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))
(setq gnus-summary-display-arrow t)

(setq gnus-check-new-newsgroups nil
      gnus-check-bogus-newsgroups nil)

(setq gnus-auto-center-summary nil)

(setq gnus-nov-is-evil nil
      gnus-show-threads nil
      gnus-use-cross-reference nil)
