(eval-after-load "w3m-search"
  '(progn
     (add-to-list 'w3m-search-engine-alist
                  '("Duck Duck Go"
                    "https://duckduckgo.com/?q=%s"
                    nil)
                  '("PHP wiki"
                    "https://secure.php.net/manual-lookup.php?pattern=%s"
                    nil)
                  )
     (add-to-list 'w3m-uri-replace-alist
                  '("\\`dd:" w3m-search-uri-replace "Duck Duck Go")
                  '("\\`phpw:" w3m-search-uri-replace "PHP wiki")
                  )
     (setq w3m-search-default-engine (quote "Duck Duck Go"))
     ))
