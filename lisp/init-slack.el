

(use-package slack
  :ensure t
  :commands (slack-start)
  :init
  (setq slack-enable-emoji t) ;; if you want to enable emoji, default nil
  (setq slack-room-subscription '(test-group slackbot))
  (setq slack-client-id "hoge")
  (setq slack-client-secret "fuga")
  (setq slack-token "hogehogehoge"))
  (setq slack-user-name "jbranso")


(use-package alert
  :commands (alert)
  :ensure t
  :init
  (setq alert-default-style 'notifier))

(provide 'init-slack)
