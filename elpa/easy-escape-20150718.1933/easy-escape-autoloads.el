;;; easy-escape-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "easy-escape" "easy-escape.el" (22222 12376
;;;;;;  176830 528000))
;;; Generated autoloads from easy-escape.el

(autoload 'easy-escape-minor-mode "easy-escape" "\
Compose escape signs together to make regexps more readable.
When this mode is active, \\\\ in strings is displayed as a
single \\, fontified using `easy-escape-face' and composed into
`easy-escape-character'.

If you find the distinction between the fontified double-slash
and the single slash too subtle, try the following:

* Adjust the foreground of `easy-escape-face'
* Set `easy-escape-character' to a different character.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; easy-escape-autoloads.el ends here
