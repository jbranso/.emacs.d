(use-package async
  :ensure t
  :defer t
  :config
  ;; enable async dired commands
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (dired-async-mode 1)
  ;; enable async compilation of melpa packages
  (async-bytecomp-package-mode 1))


;; here is an example of what you can do with async
;; (async-start
;;    ;; What to do in the child process
;;    (lambda ()
;;      (message "This is a test")
;;      (sleep-for 3)
;;      222)

;;    ;; What to do when it finishes
;;    (lambda (result)
;;      (message "Async process done, result should be 222: %s" result)))

(provide 'init-async)
;;; init-async ends here
