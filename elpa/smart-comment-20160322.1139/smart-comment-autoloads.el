;;; smart-comment-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "smart-comment" "smart-comment.el" (22258 38339
;;;;;;  348112 544000))
;;; Generated autoloads from smart-comment.el

(autoload 'smart-comment-cleanup "smart-comment" "\
Remove lines marked for deletion.

\(fn)" t nil)

(autoload 'smart-comment-mark-line "smart-comment" "\
Mark a line for deletion. ARG is ignored.

\(fn ARG)" t nil)

(autoload 'smart-comment-mark-region "smart-comment" "\
Mark a region from BEG to END for deletion. ARG is ignored.

\(fn BEG END ARG)" t nil)

(autoload 'smart-comment-region "smart-comment" "\
Comment or uncomment a region from BEG to END. ARG is ignored.

\(fn BEG END ARG)" t nil)

(autoload 'smart-comment-line "smart-comment" "\
Comment or uncomment a line. ARG is ignored.

\(fn ARG)" t nil)

(autoload 'smart-comment "smart-comment" "\
Smart commenting based on the location of point on line.
A single ARG is passed along to the function being invoked. Two
universal arguments invoke `smart-comment-cleanup' which deletes
all lines marked for deletion.

\(fn ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; smart-comment-autoloads.el ends here
