(defun purdue-view-this-file-in-dev-server ()
  "View the current file in your browser.  Since anything under community is now wordpress, then if the user wants to
view the community page, show him the qa server."
  (interactive)
  (require 's)
  (let (url dev-string qa-string)
    (setq dev-string "https://dev.honors.purdue.edu/")
    (setq qa-string  "https://qa.honors.purdue.edu/")
    (if (s-match "community" buffer-file-name)
        (setq url (concat qa-string (s-chop-prefix "/srv/http/honorscollege/" buffer-file-name)))
      (setq url (concat dev-string  (s-chop-prefix "/srv/http/honorscollege/" buffer-file-name))))
    (browse-url url)))

(defun purdue-view-this-file-locally ()
  "View the current file in your browser.  Since anything under community is now wordpress, then if the user wants to
view o community page, show him the qa server."
  (interactive)
  (require 's)
  (let (url local-string wd prefix) ;; wd == working directory
    (setq wd (pwd))
    (setq local-string "localhost/honorscollege/")
    (if (s-contains? "/srv" buffer-file-name)
        (setq prefix "/srv/http/honorscollege/")
      (setq prefix "/home/joshua/honorscollege/"))
    (setq url (concat local-string
                      (s-chop-prefix prefix buffer-file-name)))
    (browse-url url)))

(defun my-rsync-honors-purdue-edu-function ()
  "Minifying my css files."
  (interactive)
  (async-shell-command (concat (format "yuicompressor --type css  %s -o "
                                       (buffer-file-name))
                               (s-replace ".css" ".min.css" buffer-file-name)) "*css minifying*"))

;; (start-process "my-process" "foo" "ls" "-l" "/home/joshua/")

;; (get-process "foo")
;; (get-process "my-process")
;; (list-processes)

;; (process-status "my-process")
;; (process-status (get-buffer "my-honors-purdue-edu-rysnc-buffer"))

;; rsync -vrn /home/joshua/honorscollege/ jbranso@dev.www.purdue.edu:/home/users/jbranso/HTML/honorscollege/

;; (start-process "my-honors-purdue-edu-rsync" "my-honors-purdue-edu-rsync-buffer"
;;                "rsync" "-vr" "--exclude=*gitignore" "--exclude=*git" "--exclude=*assets" "/home/joshua/honorscollege/" "jbranso@dev.www.purdue.edu:/home/users/jbranso/HTML/honorscollege/" )



;; (auth-source-search :host "dev.www.purdue.edu"
;;                     ;;:type 'netrc :max 1
;;                     ;;:P "pppp" :Q "qqqq"
;;                     :require '(:secret)
;;                     )


(setq auth-source-debug t)
;;(setq auth-sources '("~/.authinfo"))

(defun get-secret-password ()
  (interactive)
  (let ((found
         (if (fboundp 'auth-source-search)

             (auth-source-search
              ;;:max 1
              :host "dev.www.purdue.edu"
              ;;:require '(:secret)
              )
           )))
    (if found
        (let ((secret (plist-get found :secret)))
          (if (functionp secret)
              (funcall secret)
            secret))
      ;; (let ((prompt (format "Jabber password for %s: " bare-jid)))
      ;;   (if (require 'password-cache nil t)
      ;;       ;; Need to copy the password, as sasl.el wants to erase it.
      ;;       (copy-sequence
      ;;        (password-read prompt (jabber-password-key bare-jid)))
      ;;     (read-passwd prompt)))
      )
    ))



;;(add-hook 'css-mode-hook '(lambda ()
;;(add-hook 'after-save-hook 'my-rsync-honors-purdue-edu-function nil t)))

(provide 'init-honorscollege)
