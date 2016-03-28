
;;; Code:
(use-package s :ensure t)

(require 'erc)

;; this test checks to see if c-c c is bound to org-capture
(ert-deftest bind-test-C-c-c ()
  (should (not (equal nil
                      (s-match "org-capture" (describe-key-briefly (kbd "C-c c")))))))

(ert-deftest bind-test-C-c-e ()
  (should (not (equal nil
                      (s-match "helm-M-x" (describe-key-briefly (kbd "C-c e")))))))

(ert-deftest bind-test-C-c-/ ()
  (should (not (equal nil
                      (s-match "helm-swoop" (describe-key-briefly (kbd "C-c /")))))))

(ert-deftest C-c-keybindings ()

  (should (not (equal nil
                      (s-match "org-capture" (describe-key-briefly (kbd "C-c c"))))))

  (should (not (equal nil
                      (s-match "helm-M-x" (describe-key-briefly (kbd "C-c e"))))))

  (should (not (equal nil
                      (s-match "helm-swoop" (describe-key-briefly (kbd "C-c /")))))))


(provide 'init-ert)
