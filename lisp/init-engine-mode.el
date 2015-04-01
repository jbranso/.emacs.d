(require 'engine-mode)
(engine-mode t)

(defengine duckduckgo
  "https://duckduckgo.com/?q=%s"
  "d")

(defengine wikipedia
  "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
  "w")

(defengine youtube
  "http://www.youtube.com/results?aq=f&oq=&search_query=%s"
  "y")

(setq browse-url-browser-function 'browse-url-default-browser)
;;(setq browse-url-browser-function 'browse-url-default-browser)

;; engine-mode uses browse-url to open the URL it constructs. To change the browser that browse-url uses, you'll need to redefine the browse-url-browser-function variable.

;; For example, to use Emacs' built-in eww browser:

;; (setq browse-url-browser-function 'eww-browse-url)

;; The implementation of the browse-url-browser-function variable contains a comprehensive list of possible browsing functions. You can get to that by hitting C-h v browser-url-browser-function <RETURN> and following the link to browse-url.el.
