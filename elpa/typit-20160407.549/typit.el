;;; typit.el --- Typing game similar to tests on 10 fast fingers -*- lexical-binding: t; -*-
;;
;; Copyright © 2016 Mark Karpov <markkarpov@openmailbox.org>
;;
;; Author: Mark Karpov <markkarpov@openmailbox.org>
;; URL: https://github.com/mrkkrp/typit
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.4") (f "0.18") (mmt "0.1.1"))
;; Keywords: games
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software: you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation, either version 3 of the License, or (at your
;; option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
;; Public License for more details.
;;
;; You should have received a copy of the GNU General Public License along
;; with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This is a typing game for Emacs.  In this game, you type words that are
;; picked randomly from N most frequent words in language you're practicing,
;; until time is up (by default it's one minute).  It's mostly quite similar
;; to the “10 fast fingers” tests, with the difference that it's playable
;; and fully configurable inside your Emacs.

;;; Code:

(require 'cl-lib)
(require 'f)
(require 'mmt)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings & variables

(defgroup typit nil
  "Cool typing game similar to tests on 10 fast fingers."
  :group  'games
  :tag    "Typit"
  :prefix "typit-"
  :link   '(url-link :tag "GitHub" "https://github.com/mrkkrp/typit"))

(defface typit-title
  '((t (:inherit font-lock-constant-face)))
  "Face used to display Typit buffer title.")

(defface typit-normal-text
  '((t (:inherit default)))
  "Face used to display words to type.")

(defface typit-current-word
  '((t (:inherit highlight)))
  "Face used to highlight current word.")

(defface typit-correct-char
  '((t (:foreground "spring green")))
  "Face used to color correctly typed characters.")

(defface typit-wrong-char
  '((t (:foreground "firebrick")))
  "Face used to color incorrectly typed characters.")

(defface typit-statistic
  '((t (:inherit font-lock-type-face)))
  "Face used to render names of statistical values after typing.")

(defface typit-value
  '((t (:inherit font-lock-constant-face)))
  "Face used to render statistical values after typing.")

(defcustom typit-dict "english.txt"
  "Name of dictionary file to use."
  :tag  "Dictionary to use"
  :type '(choice (const :tag "English" "english.txt")))

(defcustom typit-dict-dir
  (when load-file-name
    (f-slash (f-join (f-parent load-file-name) "dict")))
  "Path to directory with collection of dictionaries."
  :tag  "Directory with dictionary files"
  :type 'directory)

(defcustom typit-line-length 80
  "Length of line of words to use."
  :tag  "Length of line of words"
  :type 'integer)

(defcustom typit-test-time 60
  "Number of second a test takes."
  :tag  "Test duration in seconds"
  :type 'integer)

(defvar typit--dict nil
  "Vector of words to use (from most common to least common).

If the value is NIL, it means that no dictionary has been loaded
yet.")

(defvar typit--dict-file nil
  "File name of currently loaded dictionary.

If no dictionary is loaded, it's NIL.")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Low-level functions

(defun typit--prepare-dict ()
  "Make sure that ‘typit--dict’ and ‘typit--dict-file’ are set."
  (let ((dict-file (f-expand typit-dict typit-dict-dir)))
    (when (or (not typit--dict-file)
              (not (f-same? typit--dict-file dict-file)))
      (setq typit--dict-file dict-file
            typit--dict
            (with-temp-buffer
              (insert-file-contents dict-file)
              (vconcat
               (split-string
                (buffer-substring-no-properties
                 (point-min)
                 (point-max))
                "\n" t "[[:space:]]*")))))))

(defun typit--pick-word (num)
  "Pick a word from ‘typit--dict’.

Use first NUM words from loaded dictionary (if NUM is bigger than
length of the dictionary, use all words).  All words in
‘typit--dict’ have approximately the same probability."
  (elt typit--dict (random (min num (length typit--dict)))))

(defun typit--generate-line (num)
  "Generate a line of appropriate length picking random words.

NUM is the number of words to use from loaded dictionary (if NUM
is bigger than length of the dictionary, use all words).

This uses words from ‘typit--dict’, which should be initialized
by the time the function is called.  Result is returned as a list
of strings with assumption that only one space is inserted
between each word (then total length should be close to
‘typit-line-length’)."
  (let ((words nil)
        (acc   0))
    (while (< acc typit-line-length)
      (let ((word (typit--pick-word num)))
        (setq acc
              (+ acc
                 (length word)
                 (if words 1 0)))
        (push word words)))
    (cdr words)))

(defun typit--render-line (words)
  "Transform list of words WORDS into one string."
  (mapconcat #'identity words " "))

(defun typit--render-lines (offset first-line second-line)
  "Render the both lines in current buffer.

The lines are placed beginning from OFFSET (text from OFFSET to
end of buffer is deleted).  FIRST-LINE and SECOND-LINE are
rendered with ‘typit--render-line’."
  (let ((inhibit-read-only t))
    (delete-region offset (point-max))
    (goto-char offset)
    (insert (propertize (typit--render-line first-line)
                        'face 'typit-normal-text)
            "\n")
    (insert (propertize (typit--render-line second-line)
                        'face 'typit-normal-text)
            "\n")))

(defun typit--select-word (offset current-word &optional unselect)
  "Change font properties of a word.

OFFSET specifies position where word starts.  CURRENT-WORD is the
word to highlight.  By default the word is selected, unless
UNSELECT is not NIL — in this case it's unselected."
  (if unselect
      (dolist (v (overlays-at offset))
        (when (eq (overlay-get v 'type) 'typit-current-word)
          (delete-overlay v)))
    (let ((overlay
           (make-overlay
            offset
            (+ offset (length current-word))
            nil t nil)))
      (overlay-put overlay 'type 'typit-current-word)
      (overlay-put overlay 'face 'typit-current-word))))

(defun typit--highlight-diff-char (pos correct &optional clear)
  "Highlight diff for one char at position POS.

If the char should be highlighted as correctly typed, pass
non-NIL CORRECT.  If CLEAR is not NIL, just clear that char."
  (let ((inhibit-read-only t))
    (with-silent-modifications
      (add-text-properties
       pos (1+ pos)
       (list
        'face
        (if clear
            'typit-normal-text
          (if correct
              'typit-correct-char
            'typit-wrong-char)))))))

(defmacro typit--with-buffer (quit-function &rest body)
  "Perform actions using a new temporary Typit buffer and window.

Make new Typit buffer and make it current buffer.  QUIT-FUNCTION
receives current window object and value returned by BODY as its
arguments.  It describes what to do when contents of buffer
generated in BODY are shown to the user.  By the time the buffer
is shown it's in read-only state.  Note that BODY is evaluated,
buffer is made empty.

The window is guaranteed to be killed at the end of the day."
  (declare (indent defun))
  (mmt-with-gensyms (buffer window value)
    `(let ((,buffer (get-buffer-create "*typit*")))
       (with-current-buffer ,buffer
         (with-current-buffer-window
          ;; buffer or name
          ,buffer
          ;; action (for ‘display-buffer’)
          (cons 'display-buffer-below-selected
                '((window-height . fit-window-to-buffer)
                  (preserve-size . (nil . t))))
          ;; quit-function
          (lambda (,window ,value)
            (unwind-protect
                (funcall ,quit-function ,window ,value)
              (when (window-live-p ,window)
                (quit-restore-window ,window 'kill))))
          ;; body
          (setq cursor-type nil)
          ,@body)))))

(defun typit--report-results
    (total-time
     good-strokes
     bad-strokes
     good-words
     bad-words
     num)
  "Report results of Typit test to the user.

TOTAL-TIME, GOOD-STROKES, BAD-STROKES, GOOD-WORDS, and BAD-WORDS
are used to calculate statistics.  NUM is the number of words to
use as argument of ‘typit-test’ if user chooses to play again."
  (typit--with-buffer
    ;; quit-function
    (lambda (_window _buffer)
      (while (not (char-equal
                   (read-char "Press space bar to continue…" t)
                   32)))
      (when (y-or-n-p "Would you like to play again? ")
        (typit-test num)))
    ;; body
    (insert
     (propertize "Your results" 'face 'typit-title)
     "\n\n"
     (propertize "Words per minute (WPM)" 'face 'typit-statistic)
     "  "
     (propertize (format "%4d" (round (/ good-strokes (/ total-time 12))))
                 'face 'typit-value)
     "\n"
     (propertize "Keystrokes" 'face 'typit-statistic)
     "              "
     (propertize (format "%4d" (+ good-strokes bad-strokes))
                 'face 'typit-value)
     " ("
     (propertize (format "%4d" good-strokes) 'face 'typit-correct-char)
     " | "
     (propertize (format "%d" bad-strokes) 'face 'typit-wrong-char)
     ")\n"
     (propertize "Words" 'face 'typit-statistic)
     "                   "
     (propertize (format "%4d" (+ good-words bad-words))
                 'face 'typit-value)
     " ("
     (propertize (format "%4d" good-words) 'face 'typit-correct-char)
     " | "
     (propertize (format "%d" bad-words) 'face 'typit-wrong-char)
     ")\n")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Top-level interface

;;;###autoload
(defun typit-test (num)
  "Run typing test with using NUM most common words from dictionary.

Dictionary is an array of words in ‘typit-dict’.  By default it's
English words ordered from most common to least common.  You can
let-bind the variable and change it, it's recommended to use at
least 1000 words so ‘typit-advanced-test’ could work properly."
  (interactive "p")
  (typit--prepare-dict)
  (let ((first-line   (typit--generate-line num))
        (second-line  (typit--generate-line num))
        (test-started nil)
        (init-offset  0)
        (word-offset  0)
        (good-strokes 0)
        (bad-strokes  0)
        (good-words   0)
        (bad-words    0)
        (micro-index  0)
        (current-word nil))
    (typit--with-buffer
      (lambda (window _value)
        (message "Timer will start when you start tying…")
        (typit--report-results
         (catch 'total-time
           (cl-do
               ((ch
                 (prog1
                     (read-char nil t)
                   (setq test-started (float-time)))
                 (read-char "Typing…" t)))
               ((null ch))
             (cond
              ;; space
              ((= ch #x20)
               (when current-word
                 (typit--select-word word-offset (car first-line) t)
                 (cl-destructuring-bind (w . r) first-line
                   (if (cl-every #'identity current-word)
                       (setq good-words (1+ good-words))
                     (setq bad-words (1+ bad-words)))
                   (setq
                    first-line
                    (or r second-line)
                    second-line
                    (if r second-line (typit--generate-line num))
                    word-offset
                    (if r (+ word-offset 1 (length w)) init-offset)
                    good-strokes
                    (1+ good-strokes) ;; we should count space itself
                    good-strokes
                    (+ good-strokes (cl-count t current-word))
                    bad-strokes
                    (+ bad-strokes  (cl-count nil current-word))
                    micro-index  0
                    current-word nil)
                   (unless r
                     (typit--render-lines init-offset first-line second-line))
                   (typit--select-word word-offset (car first-line)))
                 (let ((total-time (- (float-time) test-started)))
                   (when (>= total-time typit-test-time)
                     (quit-restore-window window 'kill)
                     (throw 'total-time total-time)))))
              ;; backspace
              ((= ch #x7f)
               (setq micro-index (max 0 (1- micro-index)))
               (pop current-word)
               (typit--highlight-diff-char (+ word-offset micro-index) nil t))
              ;; correct stroke
              ((and (< micro-index (length (car first-line)))
                    (= ch (elt (car first-line) micro-index)))
               (push t current-word)
               (typit--highlight-diff-char (+ word-offset micro-index) t)
               (setq micro-index (1+ micro-index)))
              ;; everything else = incorrect stroke
              (t
               (when (< micro-index (length (car first-line)))
                 (push nil current-word)
                 (typit--highlight-diff-char (+ word-offset micro-index) nil)
                 (setq micro-index (1+ micro-index)))))))
         good-strokes
         bad-strokes
         good-words
         bad-words
         num))
      ;; ↓ body (construction of the buffer contents)
      (insert (propertize "Typit" 'face 'typit-title) "\n\n")
      (setq init-offset (point)
            word-offset init-offset)
      (typit--render-lines init-offset first-line second-line)
      (typit--select-word word-offset (car first-line)))))

;;;###autoload
(defun typit-basic-test ()
  "Basic typing test (top 200 words).

See ‘typit-test’ for more information."
  (interactive)
  (typit-test 200))

;;;###autoload
(defun typit-advanced-test ()
  "Advanced typing test (top 1000 words)."
  (interactive)
  (typit-test 1000))

(provide 'typit)

;;; typit.el ends here
