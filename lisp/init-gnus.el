(require 'gnus)
;; (setq path  "~/.emacs.d/lisp/init-gnus-secret.org")

(let ((path "~/.emacs.d/lisp/init-gnus-secret.org"))
  (when
      (f-exists? path)
    (org-babel-load-file path)))

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
      gnus-show-threads t
      gnus-use-cross-reference nil)

(defun gnus-demon-scan-news ()
  (interactive)
  (when gnus-plugged
    (let ((win (current-window-configuration))
          (gnus-read-active-file nil)
          (gnus-check-new-newsgroups nil)
          (gnus-verbose 2)
          (gnus-verbose-backends 5))
      (unwind-protect
          (save-window-excursion
            (when (gnus-alive-p)
              (with-current-buffer gnus-group-buffer
                (gnus-group-get-new-news gnus-activate-level))))
        (set-window-configuration win)))))

;;
;;
;; (with-eval-after-load 'gnus
;;   (gnus-demon-add-handler 'gnus-demon-scan-news-2 5 2))

(setq
 mm-verify-option 'known
 mm-decrypt-option 'known)

(setq
 mm-verify-option 'never
 mm-decrypt-option 'never)

(setq
 gnus-message-replysign nil
 gnus-message-replyencrypt nil)

(use-package nnir)

(setq message-kill-buffer-on-exit t)

(gnus-demon-add-handler 'gnus-demon-add-scanmail nil 2)

(gnus-desktop-notify-mode)
(gnus-demon-add-scanmail)

(use-package bbdb :ensure t)

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

;;(use-package w3m :ensure t)
;;(setq mm-text-html-renderer 'w3m)
(setq mm-text-html-renderer 'shr)

(setq nnmail-expiry-wait 30)

(setq gnus-treat-hide-boring-headers 'head)

(setq gnus-treat-strip-multiple-blank-lines t)
(setq gnus-treat-trailing-blank-lines t)
;; let's see some smiles in gnus
(setq gnus-treat-display-smileys t)
(setq gnus-treat-emphasize 'head)

(defun make-gnus-frame ()
   "Make a gnus frame, and make the title Gnus and show the gnus bitmap image."
   (interactive)
   (when window-system
     (with-selected-frame
         (make-frame '((name . "Gnus") (title . "Gnus") (icon-type . "/home/joshua/pictures/emacs/gnus.bmp")))
       (gnus))))

;; (add-hook 'after-init-hook 'make-gnus-frame)

 ;;(select-frame-by-name "Gnus")

(setq gnus-use-adaptive-scoring t)

(provide 'init-gnus)
