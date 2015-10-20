(use-package hydra
  :ensure t)
;; create a hydra for inserting cool stuff for emacs
;; (defhydra hydra-org-template (:color blue :hint nil)
;;   "
;; _c_enter  _q_uote    _L_aTeX:
;; _l_atex   _e_xample  _i_ndex:
;; _a_scii   _v_erse    _I_NCLUDE:
;; _s_rc     ^ ^        _H_TML:
;; _h_tml    ^ ^        _A_SCII:
;; "
;;   ("s" (hot-expand "<s"))
;;   ("e" (hot-expand "<e"))
;;   ("q" (hot-expand "<q"))
;;   ("v" (hot-expand "<v"))
;;   ("c" (hot-expand "<c"))
;;   ("l" (hot-expand "<l"))
;;   ("h" (hot-expand "<h"))
;;   ("a" (hot-expand "<a"))
;;   ("L" (hot-expand "<L"))
;;   ("i" (hot-expand "<i"))
;;   ("I" (hot-expand "<I"))
;;   ("H" (hot-expand "<H"))
;;   ("A" (hot-expand "<A"))
;;   ("<" self-insert-command "ins")
;;   ("o" nil "quit"))

;; (defun hot-expand (str)
;;   "Expand org template."
;;   (insert str)
;;   (org-try-structure-completion))

;; ;;I bind it for myself like this:

;; (define-key org-mode-map "C-c <"
;;   (lambda () (interactive)
;;      (if (looking-back "^")
;;          (hydra-org-template/body)
;;        (self-insert-command 1))))

;;a nice clock in clock out thing from hydra
;; https://github.com/abo-abo/hydra/wiki/orgmode
(defun hydra-global-org (:color blue
                                :hint nil)
  "
Timer^^        ^Clock^         ^Capture^
--------------------------------------------------
s_t_art        _i_ clock in    _c_apture
 _s_top        _w_ clock out   _l_ast capture
_r_eset        _j_ clock goto
_p_rint
"
  ("t" org-timer-start)
  ("s" org-timer-stop)
  ;; Need to be at timer
  ("r" org-timer-set-timer)
  ;; Print timer value to buffer
  ("p" org-timer)
  ("i" (org-clock-in '(4)))
  ("w" org-clock-out)
  ;; Visit the clocked task from any buffer
  ("j" org-clock-goto)
  ("c" org-capture)
  ("l" org-capture-goto-last-stored))


;; This is the hydra that I use with C-c C to clock in and clock out all the time!
(defhydra hydra-org-timer (:color blue :hint nil)
  "timer"
  ("i" (org-clock-in '(4))    "clock in")
  ("o" org-clock-out   "clock out"))

(defhydra hydra-apropos (:color blue)
  "Apropos"
  ("a" apropos "apropos")
  ("c" apropos-command "cmd")
  ("d" apropos-documentation "doc")
  ("e" apropos-value "val")
  ("l" apropos-library "lib")
  ("o" apropos-user-option "option")
  ("u" apropos-user-option "option")
  ("v" apropos-variable "var")
  ("i" info-apropos "info")
  ("t" tags-apropos "tags")
  ("z" hydra-customize-apropos/body "customize"))

(defhydra hydra-customize-apropos (:color blue)
  "Apropos (customize)"
  ("a" customize-apropos "apropos")
  ("f" customize-apropos-faces "faces")
  ("g" customize-apropos-groups "groups")
  ("o" customize-apropos-options "options"))


(defhydra hydra-transpose (:color red)
  "Transpose"
  ("c" transpose-chars "characters")
  ("w" transpose-words "words")
  ("o" org-transpose-words "Org mode words")
  ("l" transpose-lines "lines")
  ("s" transpose-sentences "sentences")
  ("e" org-transpose-elements "Org mode elements")
  ("p" transpose-paragraphs "paragraphs")
  ("t" org-table-transpose-table-at-point "Org mode table")
  ("q" nil "cancel" :color blue))

(provide 'init-hydra)
