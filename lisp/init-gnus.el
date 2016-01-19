(require 'init-gnus-secret)

(setq
 message-signature
 "Joshua Branson\nWayPoint\nWeb Developer\njbranso.me\nSent From Emacs\nhttps://www.gnu.org/software/emacs/")

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

(setq mm-verify-option "known"
 mm-decrypt-option "known")

(setq gnus-message-replysign t
 gnus-message-replyencrypt t)

(setq spam-blacklist "/home/joshua/.emacs.d/lisp/blacklist"
      spam-use-blacklist t)
(spam-initialize)

(use-package nnir)

(require 'init-gnus-secret-smtp)

(add-hook 'message-send-hook  'ispell-message)

(use-package gnus-desktop-notify
  :ensure t)

(gnus-desktop-notify-mode)
(gnus-demon-add-scanmail)
(gnus-demon-add-handler 'gnus-group-get-new-news 20 t)

(use-package bbdb
  :ensure t)

(bbdb-initialize 'gnus 'message )

(require 'bbdb)
(bbdb-initialize 'gnus 'message)

(bbdb-insinuate-message)

(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)

(setq bbdb/gnus-summary-prefer-real-names t
   bbdb-file "~/.emacs.d/bbdb"
   bbdb-default-area-code 765
   bbdb-user-mail-names "jbranson@setyourwaypoint.com")

(setq
 bbdb-use-pop-up t
 bbdb-offer-save 1
 bbdb-update-records-p t)

(setq
bbdb-user-mail-address-re
(regexp-opt
 '("jbranso@purdue.edu" "bransoj@hotmail.com" "jbranson@setyourwaypoint.com"))
message-dont-reply-to-names bbdb-user-mail-address-re
gnus-ignored-from-addresses bbdb-user-mail-address-re)

(bbdb-mua-auto-update-init 'message)

(add-hook 'gnus-summary-exit-hook 'gnus-summary-bubble-group)

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq nnmail-split-methods
      '(("Accrisoft Support" "^From:.*support@accrisoft.com")
        ("Basecamp" "^From:.*notifications@basecamp.com")
        ("Arch" "^To:.*arch-general@archlinux.org")
        ("bug-hurd" "^To:.*bug-hurd@gnu.org")
        ("bug-hurd" "^Cc:.*bug-hurd@gnu.org")))

(setq mm-text-html-renderer 'gnus-w3m)

(setq nnmail-expiry-wait 'immediate)

(setq gnus-treat-hide-boring-headers 'head)

(setq gnus-treat-strip-multiple-blank-lines t)
(setq gnus-treat-trailing-blank-lines t)
;; let's see some smiles in gnus
(setq gnus-treat-display-smileys t)
(setq gnus-treat-emphasize 'head)

(setq gnus-use-adaptive-scoring t)

(provide 'init-gnus)
