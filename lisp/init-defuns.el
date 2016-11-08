

;; I should really use these elisp libraries

;; https://github.com/magnars/s.el
(use-package s :ensure t :defer t)
;; trim the string

;; https://github.com/Fuco1/dash.el
(use-package dash :ensure t :defer t)
;;(-flatten '((1))) ;; => '(1)
;;(-flatten '((1 (2 3) (((4 (5))))))) ;; => '(1 2 3 4 5)
;;(-flatten '(1 2 (3 . 4))) ;; => '(1 2 (3 . 4))

;; https://github.com/rejeep/f.el
(use-package f :ensure t :defer t)
(require 'f)

;;(f-short "/home/joshua")
;;(f-long "~/")

;;this function creates a hot-key M-x gtd that will open my gtd file
(defun gtd ()
  "This command opens ~/things_to_do.org"
  (interactive)
  (find-file "~/programming/org/gtd/gtd.org"))

;; this function will open my init file for me
(defun init.el ()
  "init-file opens ~/.emacs"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun init-evil ()
  "loads my viper initialization file"
  (interactive)
  (load "~/.emacs.d/lisp/init-evil.el")
  (find-file "~/.emacs.d/lisp/init-evil.el"))

;; This file will open rc.lua
(defun rc.lua ()
  "This command opens ~/.config/awesome/rc.lua"
  (interactive)
  (find-file "~/.config/awesome/rc.lua"))

;; This file will open emacs.texi
(defun emacs.texi ()
  "This command opens ~/manuals/cheatsheats/emacs.texi"
  (interactive)
  (find-file "~/manuals/cheatsheats/emacs.texi"))

;; This file will open gawk.texi
(defun gawk.texi ()
  "This command opens ~/manuals/cheatsheats/gawk.texi"
  (interactive)
  (find-file "~/manuals/cheatsheats/gawk.texi"))

;; This file will open definitions.el
(defun init-defuns ()
  "This command opens ~/.emacs.d/definitions.el"
  (interactive)
  (find-file "~/.emacs.d/lisp/init-defuns.el"))

(defun systemd.texi ()
  "This command opens ~/manuals/systemd.texi"
  (interactive)
  (find-file "~/manuals/systemd.texi"))

;;test awesome
(defun test-awesome ()
  "this run /home/joshua/programming/bash/test-awesome.bash"
  (interactive)
  (start-process "testing-awesome" "test-of-awesome" "test-awesome.bash"))
;; you can use start-process like this:
;; (start-process NAME BUFFER PROGRAM &rest PROGRAM-ARGS))

;;sh into soihub and pull stuff from master
(defun soihub-update-dev-server ()
  "This runs /home/joshua/programming/bash/soihub"
  (interactive)
  (call-process-shell-command "soihub" nil nil)
  (message "soihub process finished."))

;; stop httpd
(defun stop-httpd ()
  "This runs /home/joshua/programming/bash/stop-httpd"
  (call-process-shell-command "stop-httpd" nil nil)
  (message "httpd.service stopped."))

;; start httpd
(defun start-httpd ()
  "This runs /home/joshua/programming/bash/start-httpd"
  (call-process-shell-command "start-httpd" nil nil)
  (message "httpd.service started."))

(defun filezilla ()
  "This starts filezilla"
  (interactive)
  (async-shell-command "filezilla"))


(defun save-this-buffer-to-portfolio-site ()
  "Write this buffer to to my portfolio site"
  (interactive)
  ;; Take the current file and save it on the live server
  (setq current-directory
        (s-chop-prefix "Directory " (pwd)))
  (write-file "/ssh:jbranso_portfolio91@ssh.phx.nearlyfreespeech.net:/home/public/")
  ;;Take the current file and save it locally, that way, after I'm done saying the local file
  ;; to the server, pwd is still ~/programming/soihub
  (write-file current-directory))


;; this writes the current file to the live soihub server

(defun soihub-save-this-buffer-to-live-server ()
  "Write this buffer to soihub"
  (interactive)
  ;; this when statement probably doesn't need to be here.
  (when (string-match "_[-a-z_A-Z0-9]*\\.php\\|[-a-z_A-Z0-9]*\\.php" buffer-file-name)
    (setq php-file-name (match-string 0 buffer-file-name) ))
  ;; Take the current file and save it on the live server
  (write-file "/ssh:jbranso@locutus.cs.purdue.edu:/home/isi-wiki/soi/")
  ;;Take the current file and save it locally, that way, after I'm done saying the local file
  ;;to the server, pwd is still ~/programming/soihub
  (write-file "/home/joshua/programming/soihub/"))

(defun waypoint-save-this-buffer-to-dev-server ()
  "Write this buffer to soihub"
  (interactive)
  ;; this when statement probably doesn't need to be here.
  (print buffer-file-name)
  (setq remote-dir "/ssh:setyourwaypoint@setyourwaypoint.com:/public_html/ihsb/")
  (cond
   ;; when the buffer's name has an "includes" in the name, then set the remote dir to /includes/
   ((string-match "includes" buffer-file-name)
    (print "includes")
    (setq remote-dir (concat remote-dir "/includes/")))
   ;; when the buffer's name has an "php" in middle of the file name, then set the remote dir to /php/
   ((string-match "/php/+$" buffer-file-name)
    (print "php")
    (setq remote-dir (concat remote-dir "/php/")))
   ;; if this is a javascript file, then save it in the javascript dir
   ((string-match "js$" buffer-file-name)
    (print "js")
    (setq remote-dir (concat remote-dir "/js/"))))
  ;; set the remote file name
  (setq remote-file
        (concat remote-dir
                ;; the file name without the path in front of it
                (file-name-nondirectory buffer-file-name)))
  ;; Take the current file and save it on the live server
  (write-file remote-file)
  ;;Take the current file and save it locally, that way, after I'm done saying the local file
  ;;to the server, pwd is still ~/programming/soihub
  (write-file "/home/joshua/programming/waypoint/ihca/"))

(defun purdue-delete-this-buffer-from-dev-server ()
  "Write this buffer to the purdue dev server."
  (interactive)
  (require 's)
  (let (remote-file-path remote-dir local-file)
    (setq local-file buffer-file-name)
    (setq remote-dir "/ssh:jbranso@dev.www.purdue.edu:/var/www/html/root/honorscollege/")
    (setq remote-file-path (concat
                            remote-dir
                            (s-chop-prefix "/home/joshua/honorscollege/" buffer-file-name)))
    (delete-file remote-file-path)))

(defun purdue-save-this-buffer-to-dev-server ()
  "Write this buffer to the purdue dev server."
  (interactive)
  (require 's)
  (let (remote-file-path remote-dir local-file)
    (setq local-file buffer-file-name)
    (setq remote-dir "/ssh:jbranso@dev.www.purdue.edu:/var/www/html/root/honorscollege/")
    (setq remote-file-path (concat
                            remote-dir
                            (s-chop-prefix "/srv/http/honorscollege/" buffer-file-name)))
    ;; for some reason updating images doesn't really work.
    ;; I should delete them first.  Then upload them.
    (when (and (string-match "\.pdf$\\\|\.jpg$\\\|\.png$" remote-file-path)
               ;; does the file exist?
               (file-exists-p remote-file-path))
      (delete-file remote-file-path))
    (write-file remote-file-path)
    (write-file local-file)))

(defun purdue-view-this-buffer-in-browser ()
  "View the current file in your browser.  Since anything under community is now wordpress, then if the user wants to
view o community page, show him the qa server."
  (interactive)
  (require 's)
  (let (url dev-string qa-string)
    (setq dev-string "https://dev.honors.purdue.edu/")
    (setq qa-string  "https://qa.honors.purdue.edu/")
    (if (s-match "community" buffer-file-name)
        (setq url (concat qa-string (s-chop-prefix "/srv/http/honorscollege/" buffer-file-name)))
      (setq url (concat dev-string  (s-chop-prefix "/srv/http/honorscollege/" buffer-file-name))))
    (browse-url url)))


(defun purdue-view-this-buffer-locally ()
  "View the current file in your browser.  Since anything under community is now wordpress, then if the user wants to
view o community page, show him the qa server."
  (interactive)
  (require 's)
  (let (url local-string)
    (setq local-string "localhost/honorscollege/")
    (setq url (concat local-string  (s-chop-prefix "/srv/http/honorscollege/" buffer-file-name)))
    (browse-url url)))

(defun purdue-deploy-to-dev-server ()
  "Rsynce my project to purdue's dev server."
  (interactive)
  (start-process "rsync-purdue" "*Purdue Deploy*" "rsync"
                 ;; be verbose
                 "-v "
                 ;; recursive into directories
                 "-r "
                 "/srv/http/honorscollege/"
                 "jbranso@dev.www.purdue.edu:/var/www/html/root/honorscollege/")
  (let ((password (read-string "Enter your password: ")))
    (process-send-string "rsync-purdue" password))
  (split-window-below)
  (windmove-down)
  (switch-to-buffer "rsync-purdue"))

;; This function can be called from any org-babel sql block that has php and sql code mixed together
(defun org-babel-strip-php-from-sql-block ()
  "Cleans up a sql statement from
   $sql  = 'SELECT * ';
   $sql .= 'FROM USERS ';
   $sql .= 'WHERE 1';
   into
   SELECT *
   FROM USERS
   WHERE 1 "
  (interactive)
  ;; let's first move to the top of the buffer
  (beginning-of-buffer)
  ;; now move point forward to the first char in the buffer
  (while (re-search-forward "\";" nil t)
    (replace-match ""))
  (while (re-search-forward "\$sql.*=.*?" nil t)
    (replace-match ""))
  (while (re-search-forward "\$sql.*\.=.*?" nil t)
    (replace-match ""))
  (while (re-search-forward "\$sql.*=.*\"" nil t)
    (replace-match "")))


(defun maybe-move-word-at-point (arg)
  (interactive "P")
  "maybe move word at point"
  (print arg)
  (while
      (>= arg 0)
    (if
        ;;if ispell returns nil (word is correct)
        (eq nil (ispell-word nil t nil))
        ;; if ispell returns word was correct
        ;; print word was correct and move to the next line
        (progn
          (print "word was correct")
          (evil-next-line))

      ;; if word was wrong, then move it
      (move-word-at-point))))

(defun move-word-at-point ()
  (interactive)
  "Move this word at point"
  ;; move to the next word
  (evil-forward-word-begin 2)
  ;; kill it
  (kill-word 1)
  ;; and the next "
  (delete-char 1)
  (evil-first-non-blank)
  (forward-char)
  ;;insert a space
  (insert-char #x020 )
  (backward-char)
  (yank)
  (insert-char #x022)
  (evil-first-non-blank)
  (forward-char)
  (forward-char)
  (evil-next-line))

;; this lets you open a file as sudo
(defun my-find-file-as-sudo ()
  (interactive)
  (let ((file-name (buffer-file-name)))
    (when file-name
      (find-alternate-file (concat "/sudo::" file-name)))))


;; this is the defun I've been working on "\$sql.*\\(\\.\\|=\\).*?\""
;; BUT this one seems to work
;; "\$sql.*?=.+?\""

;; toggles between vertically splitting or horizontally splitting windows
;; https://www.reddit.com/r/emacs/comments/4dgxd6/weekly_emacs_questions_thread/
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(defun update-my-profile-site-lets-encrypt ()
  (interactive)
  ;; What to do in the child process
  (find-file "/home/joshua/programming/org/projects/become-an-awesome-hacker.org")
  (search-forward ":CUSTOM_ID: updateLetsEncrypt")
  (search-forward "#+BEGIN_SRC sh")
  (org-ctrl-c-ctrl-c))


(defun goToNextHeading ()
  "This moves point to the next heading."
  (interactive)
  (search-forward-regexp "^\\\*+ " (bufferEndCharPosition) t 1))

(defun goToPreviousHeading ()
  "This moves point to the next heading."
  (interactive)
  (org-previous-visible-heading 1))

(defun returnHeadingText ()
  "Returns the heading text."
  (interactive)
  (org-element-property :raw-value (org-element-at-point)))

(defun storeHeadingText ()
  "store the heading Text in currentHeadingText.
Make sure it has no duplicate items."
  (interactive)
  (let (currentHeadingText)
    ;;if headingText is not created, then create it.
    (when (not (boundp 'headingText))
      (setq headingText '()))
    ;; set the current heading Text
    (setq currentHeadingText
          (org-element-property :raw-value (org-element-at-point)))
    ;;if we have not seen this heading before, then
    ;; add it to the headingText list.
    (when (not (member currentHeadingText headingText))
      (push currentHeadingText headingText))))

(defun storePointPosition ()
  "This is the position point should go to, when is time to
check the next heading for redundancy."
  (interactive)
  (setq nextHeadingPosition
        (point)))

(defun bufferEndCharPosition ()
  "returns the end of the buffer char position."
  (interactive)
  (let (endOfBufferChar currentChar)
    (setq currentChar (point))
    (setq endOfBufferChar (progn
                            (end-of-buffer)
                            (point)))
    (goto-char currentChar)
    endOfBufferChar))

(defun bufferBeginningCharPosition ()
  "returns the end of the buffer char position."
  (interactive)
  (let (beginningOfBufferChar currentChar)
    (setq currentChar (point))
    (setq beginningOfBufferChar (progn
                                  (beginning-of-buffer)
                                  (point)))
    (goto-char currentChar)
    beginningOfBufferChar))

(defun deleteAllNextRedundantHeadings ()
  "Delete the next redundant headings."
  (interactive)
  ;; if there is not next heading, quit
  (if (member (returnHeadingText) headingText)
      (progn
        (beginning-of-line)
        (kill-line "<deleteline>")
        (deleteAllNextRedundantHeadings))
    (storeHeadingText)
    ;; when there is a next heading, go to the next heading
    ;; and repeat the process
    (when (not (equal (goToNextHeading) nil))
      (deleteAllNextRedundantHeadings))))

(defun deleteRedudantHeadings ()
  "Delete all redundant headings in an org file."
  (interactive)
  ;;(beginning-of-buffer)
  (setq headingText '())
  (goToNextHeading)
  ;; store the first heading text
  (deleteAllNextRedundantHeadings))

(defun loop-delete-redudant-headings ()
  "Delete redundant text."
  (interactive)
  (setq headingText '())
  (while (goToNextHeading)
    (if (member (returnHeadingText) headingText)
        (progn
          (beginning-of-line)
          (kill-line "<deleteline>")
          (deleteAllNextRedundantHeadings))
      (storeHeadingText))))

(provide 'init-defuns)
