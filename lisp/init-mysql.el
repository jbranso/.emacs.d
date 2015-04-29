;;set up a way to connect to a remote MySQL database
(setq sql-connection-alist
      '((pool-a
         (sql-product 'mysql)
         (sql-server "72.12.197.59")
         (sql-user "testuser")
         (sql-password "testuser")
         (sql-database "take_home_test")
         (sql-port 5507))
        ))

(defun sql-connect-preset (name)
  "Connect to a predefined SQL connection listed in `sql-connection-alist'"
  (eval `(let ,(cdr (assoc name sql-connection-alist))
    (flet ((sql-get-login (&rest what)))
      (sql-product-interactive sql-product)))))

(defun sql-local ()
  "Connect to the local MySQL server"
  (interactive)
  (sql-connect-preset 'pool-a)
  (delete-other-windows))

(define-key global-map [f10] 'sql-local)
