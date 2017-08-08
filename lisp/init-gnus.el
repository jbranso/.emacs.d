(org-babel-load-file "~/.emacs.d/lisp/init-gnus-secret.org")

(setq gnus-parameters
     '(
     ("^.*owa.purdue.edu.*INBOX"
          (expiry-target . "nnimap+owa.purdue.edu:Trash")
     )

     ("^.*help guix.*$"
          (to-address . "help-guix@gnu.org")
          (sieve address "sender" "help-guix@gnu.org")
          )

        ("^guix$"
           (to-address . "guix-devel@gnu.org")
           (sieve address "sender" "guix-devel@gnu.org")
       )
    ("Inbox"
       (expiry-target . "Deleted")
    )
    ))

(setq  gnus-summary-line-format "%d %U%R%z%I%(%[%4L: %-23,23f%]%) %s \n")

(when window-system
    (setq gnus-sum-thread-tree-indent "  ")
    (setq gnus-sum-thread-tree-root "● ")
    (setq gnus-sum-thread-tree-false-root "◯ ")
    (setq gnus-sum-thread-tree-single-indent "◎ ")
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

(setq spam-blacklist "/home/joshua/.emacs.d/lisp/blacklist"
      spam-use-blacklist t)
(spam-initialize)

(use-package nnir)

;; (require 'init-gnus-secret-smtp)
   ;; I am trying to use use-package so that emacs won't start on an error if someone tries to clone
   ;; my config
;;   (use-package init-gnus-secret-smtp)

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
   bbdb-user-mail-names "bransoj@hotmail.com")

(setq
 bbdb-use-pop-up t
 bbdb-offer-save 1
 bbdb-update-records-p t)

(setq
  bbdb-user-mail-address-re
  (regexp-opt
   '("bransoj@hotmail.com" "jbranso@purdue.edu" ))
  message-dont-reply-to-names bbdb-user-mail-address-re
  gnus-ignored-from-addresses bbdb-user-mail-address-re)

(bbdb-mua-auto-update-init 'message)

(add-hook 'gnus-summary-exit-hook 'gnus-summary-bubble-group)

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq gnus-posting-styles
      ;; default posting style
      '((".*"
         (signature "Sent from Emacs and Gnus"))
         ;; My purdue inbox
        ("Inbox"
         (signature "Joshua Branson\nPurdue Honors College\nWeb Developer\nSent From Emacs and Gnus")
         (address "bransoj@hotmail.com"))
        (".*hotmail.*"
         (signature "Joshua Branson\nSent From Emacs and Gnus")
         (address "bransoj@hotmail.com"))))

(add-hook 'kill-emacs-hook #'(lambda ()
                                 (interactive)
                                 (when (eq nil (get-buffer "*Group*"))
                                   (gnus-group-exit))))

;;(use-package w3m :ensure t)
;;(setq mm-text-html-renderer 'w3m)
(setq mm-text-html-renderer 'shr)

(setq nnmail-expiry-wait 'immediate)

(setq gnus-treat-hide-boring-headers 'head)

(setq gnus-treat-strip-multiple-blank-lines t)
(setq gnus-treat-trailing-blank-lines t)
;; let's see some smiles in gnus
(setq gnus-treat-display-smileys t)
(setq gnus-treat-emphasize 'head)

(setq gnus-use-adaptive-scoring t)

(add-hook 'kill-emacs-hook #'(lambda ()
                               (interactive)
                               (when (get-buffer "*Group*")
                                 (gnus-group-exit))))

(provide 'init-gnus)
