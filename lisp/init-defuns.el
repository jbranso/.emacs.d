

;; I should really use these elisp libraries

;; https://github.com/magnars/s.el
(use-package s :ensure t :defer t)
;; trim the string
(s-trim " hello ")

;; https://github.com/Fuco1/dash.el
(use-package dash :ensure t :defer t)
(-flatten '((1))) ;; => '(1)
(-flatten '((1 (2 3) (((4 (5))))))) ;; => '(1 2 3 4 5)
(-flatten '(1 2 (3 . 4))) ;; => '(1 2 (3 . 4))

;; https://github.com/rejeep/f.el
(use-package f :ensure t :defer t)
(require 'f)

(f-short "/home/joshua")
(f-long "~/")

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
  "Write this buffer to soihub"
  (interactive)
  ;; Take the current file and save it on the live server
  (setq current-directory
        (s-chop-prefix "Directory " (pwd)))
  (write-file "/ssh:jbranso_portfolio91@ssh.phx.nearlyfreespeech.net:/home/public/")
  ;;Take the current file and save it locally, that way, after I'm done saying the local file
  ;;to the server, pwd is still ~/programming/soihub
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
  (evil-next-line)
  )

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

;;I found this big code snippet here:  https://github.com/seanirby/dotfiles/blob/master/.emacs.d/init.el#L310-L397
;;buffer stuff quickly choose between the last 8 opened buffers
(defvar bswitch-map (list 1 "a"
                          2 "o"
                          3 "e"
                          4 "u"
                          5 "i"
                          6 "d"
                          7 "h"
                          8 "t"))

(defvar bswitch-offset 15)
(defvar bswitch-key-buffer-spacing 5)

(defun bswitch-repeat (number &optional str)
  (if (< number 1)
      str
    (bswitch-repeat (1- number) (concat " " str))))

(defun bswitch-get-beginning ()
  (bswitch-repeat (- (/ (window-body-width) 2) bswitch-offset)))

(defun bswitch-get-end (beg mid)
  (bswitch-repeat (- (window-body-width)
                     (+ (length mid)
                        (length beg)))))

(defun bswitch-get-header-display-line ()
  (let* ((beg (bswitch-get-beginning))
         (mid (concat "Key"
                      (bswitch-repeat
                       (+ -2 bswitch-key-buffer-spacing))
                      "Buffer"))
         (end (bswitch-get-end beg mid)))
    (concat beg mid end)))


(defun bswitch-get-buffer-display-line (index)
  (let* ((blist (buffer-list)))
    (if (< index (length blist))
        (let* ((beg (bswitch-get-beginning))
               (mid (concat (plist-get bswitch-map index)
                            (bswitch-repeat bswitch-key-buffer-spacing)
                            (buffer-name (nth index (buffer-list)))))
               (end (bswitch-get-end beg mid)))

          (concat beg mid end))
      (let* ((beg (bswitch-get-beginning))
             (mid (format "No buffer at index %s yet" index))
             (end (bswitch-get-end beg mid)))
        (concat beg mid end)))))

(defun bswitch-switch (index)
  (if (< index (length (buffer-list)))
      (switch-to-buffer (nth index (buffer-list)))
    (message "Cannot switch since there is no buffer at index %s yet" index)))

(defhydra hydra-bswitch (:hint nil :exit t)
  "
%(bswitch-get-header-display-line)
%(bswitch-get-buffer-display-line 1)
%(bswitch-get-buffer-display-line 2)
%(bswitch-get-buffer-display-line 3)
%(bswitch-get-buffer-display-line 4)
%(bswitch-get-buffer-display-line 5)
%(bswitch-get-buffer-display-line 6)
%(bswitch-get-buffer-display-line 7)
%(bswitch-get-buffer-display-line 8)
"
  ("a" (bswitch-switch 1))
  ("o" (bswitch-switch 2))
  ("e" (bswitch-switch 3))
  ("u" (bswitch-switch 4))
  ("i" (bswitch-switch 5))
  ("d" (bswitch-switch 6))
  ("t" (bswitch-switch 7))
  ("n" (bswitch-switch 8)))

;; end found this cool command online

(provide 'init-defuns)

;; make a helm-function that looks for STARTED areas in my org files that I can click to clock into
(defun org-find-logbook-headlines ()
  (interactive)
  (helm :sources '((1 2 3 4 5)) :buffer "*helm clock*" :candidate-number-limit 30)
  )
