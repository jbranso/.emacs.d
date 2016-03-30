
;;; Code:
(use-package s :ensure t)

(require 'erc)

;; this test checks to see if my C-c . keybindings work
(ert-deftest C-c-keybindings ()
  (should (not (equal nil
                      (s-match "org-capture" (describe-key-briefly (kbd "C-c c"))))))

  (should (not (equal nil
                      (s-match "helm-M-x" (describe-key-briefly (kbd "C-c e"))))))

  (should (not (equal nil
                      (s-match "helm-swoop" (describe-key-briefly (kbd "C-c /"))))))

  (should (not (equal nil
                      (s-match "helm-swoop" (describe-key-briefly (kbd "C-c /"))))))

  (should (not (equal nil
                      (s-match "indent-whole-buffer" (describe-key-briefly (kbd "C-c TAB"))))))
  (should (not (equal nil
                      (s-match "delete-horizontal-space" (describe-key-briefly (kbd "C-c \\"))))))
  (should (not (equal nil
                      (s-match "just-one-space" (describe-key-briefly (kbd "C-c SPC"))))))
  (should (not (equal nil
                      (s-match "helm-swoop" (describe-key-briefly (kbd "C-c /"))))))
  (should (not (equal nil
                      (s-match "rg-agenda" (describe-key-briefly (kbd "C-c a"))))))
  (should (not (equal nil
                      (s-match "eval-buffer" (describe-key-briefly (kbd "C-c b"))))))
  (should (not (equal nil
                      (s-match "browse-kill-ring" (describe-key-briefly (kbd "C-c B"))))))
  (should (not (equal nil
                      (s-match "hydra-org-timer/body" (describe-key-briefly (kbd "C-c C"))))))
  (should (not (equal nil
                      (s-match "org-capture" (describe-key-briefly (kbd "C-c c"))))))
  (should (not (equal nil
                      (s-match "dired-jump" (describe-key-briefly (kbd "C-c d"))))))
  (should (not (equal nil
                      (s-match "ggtags-find-tag-dwim" (describe-key-briefly (kbd "C-c D"))))))
  (should (not (equal nil
                      (s-match "helm-M-x" (describe-key-briefly (kbd "C-c e"))))))
  (should (not (equal nil
                      (s-match "eshell" (describe-key-briefly (kbd "C-c E"))))))
  (should (not (equal nil
                      (s-match "isearch-forward-regexp" (describe-key-briefly (kbd "C-c f"))))))
  (should (not (equal nil
                      (s-match "isearch-backward-regexp" (describe-key-briefly (kbd "C-c F"))))))
  (should (not (equal nil
                      (s-match "gnus" (describe-key-briefly (kbd "C-c g"))))))
  (should (not (equal nil
                      (s-match "helm-command-prefix" (describe-key-briefly (kbd "C-c h"))))))
  (should (not (equal nil
                      (s-match "info-display-manual" (describe-key-briefly (kbd "C-c i"))))))
  (should (not (equal nil
                      (s-match "eval-last-sexp" (describe-key-briefly (kbd "C-c l"))))))
  (should (not (equal nil
                      (s-match "org-store-link" (describe-key-briefly (kbd "C-c L"))))))
  (should (not (equal nil
                      (s-match "org-insert-link" (describe-key-briefly (kbd "C-c I"))))))
  (should (not (equal nil
                      (s-match "helm-mini" (describe-key-briefly (kbd "C-c m"))))))
  (should (not (equal nil
                      (s-match "maybe-move-word-at-point" (describe-key-briefly (kbd "C-x m")))))))


(provide 'init-ert)
