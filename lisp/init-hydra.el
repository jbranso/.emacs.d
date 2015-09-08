(require 'hydra)
;; create a hydra for inserting cool stuff for emacs
(defhydra hydra-org-template (:color blue :hint nil)
  "
_c_enter  _q_uote    _L_aTeX:
_l_atex   _e_xample  _i_ndex:
_a_scii   _v_erse    _I_NCLUDE:
_s_rc     ^ ^        _H_TML:
_h_tml    ^ ^        _A_SCII:
"
  ("s" (hot-expand "<s"))
  ("e" (hot-expand "<e"))
  ("q" (hot-expand "<q"))
  ("v" (hot-expand "<v"))
  ("c" (hot-expand "<c"))
  ("l" (hot-expand "<l"))
  ("h" (hot-expand "<h"))
  ("a" (hot-expand "<a"))
  ("L" (hot-expand "<L"))
  ("i" (hot-expand "<i"))
  ("I" (hot-expand "<I"))
  ("H" (hot-expand "<H"))
  ("A" (hot-expand "<A"))
  ("<" self-insert-command "ins")
  ("o" nil "quit"))

(defun hot-expand (str)
  "Expand org template."
  (insert str)
  (org-try-structure-completion))

;;I bind it for myself like this:

(define-key org-mode-map "C-c <"
  (lambda () (interactive)
     (if (looking-back "^")
         (hydra-org-template/body)
       (self-insert-command 1))))

;;a nice clock in clock out thing from hydra
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

(defhydra hydra-org-timer (:color blue :hint nil)
  "timer"
  ("i" (org-clock-in '(4))    "clock in")
  ("o" org-clock-out   "clock out"))

;; this is not working at the moment, but hopefully it will at some point
(defun hydra-emms (:color blue
                            :hint nil)
  "
Playlist^^        ^seeking^         ^Capture^
--------------------------------------------------
 _s_top        _>_ seek 10 seconds forward   _d_escribe song
 _n_ext        _<_ seek 10 seconds barkward  _D_elete
 _p_revious    _r_ random song
 _P_uase
"
  ("s" emms-stop)
  ("n" emms-next)
  ("p" emms-previous)
  ("P" emms-pause)
  ;; Print timer value to buffer
  (">" emms-seek-forward)
  ("<" emms-seek-backward)
  ("r" emms-random)
  ;; Visit the clocked task from any buffer
  ("d" emms-show)
  ("D" emms-playlist-mode-kill-track))


(provide 'init-hydra)
