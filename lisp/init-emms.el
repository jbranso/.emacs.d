;; EMMS is the emacs multimedia system.  It lets you listen to music and possible play videos!
;; emacs itself doesn't play the music or videos, it uses external tools, but you control the playing from emacs!
;; I really like it because I can stream music from libre.fm and hack at the same time, without leaving emacs.

;; simple setup taken from here
;; [[info:emms#Quickstart%20Guide][info:emms#Quickstart Guide]]
(require 'emms-setup)
(emms-all)
(emms-default-players)
;;https://www.gnu.org/software/emms/manual/GNU-FM-Streaming.html#GNU-FM-Streaming
;; set up streaming via librefm
(require 'emms-librefm-stream)
;; I've set up my account information in ~/.autoinfo. It looks like this:
;; machine libre.fm login <username> password <password>
;; let librefm store my listening habbits and recommend better music!
(require 'emms-librefm-scrobbler)
;; this lets you use emms browser, which can let you browse by artist, track, etc
;;(require 'emms-browser)
;; 's A'
;;      Search the collection by album.

;; 's a'
;;      Search the collection by artist.

;; 's s'
;;      Search the collection by names.

;; 's t'
;;      Search the collection by title.

;; 'b 1'
;;      Browse the collection by artist.

;; 'b 2'
;;      Browse the collection by album.

;; 'b 3'
;;      Browse the collection by genre.

;; 'b 4'
;;      Browse the collection by year.

;; 'W a p'
;;      Lookup the album using Pitchfork.

;; 'W a w'
;;      Lookup the album using Wikipedia.

;; display information about the current playing track in the mode line
(require 'emms-mode-line)
(emms-mode-line 1)
;; It is also possible to display the amount of time a track has been
;; playing.  This feature is defined in the 'emms-playing-time' package
;; which is provided by the file 'emms-playing-time.el'.
(require 'emms-playing-time)
(emms-playing-time 1)

;; emms is using the music player daemon to play songs
;; Emms provides an interface to the Music Player Daemon
;; (http://www.musicpd.org/)(MusicPD) software.  The package is called
;; 'emms-player-mpd' and is provided by the file 'emms-player-mpd.el'.
;; I'll have to check that package out to mess with the weird volume error I'm having

;; I should also check out EMMS_VOLUME_CHANGE_FUNCTION. Maybe that will help me fix the issue I'm having
;; Whenever you use one of these keys or call these functions with
;; 'M-x', Emms will be put into 'emms-volume-minor-mode' for a short period
;; defined by 'emms-volume-mode-timeout'.

;;  -- User Option: emms-volume-mode-timeout
;;      The timeout in amount of seconds used by 'emms-volume-minor-mode'.

;;    In this interval you can raise/lower the volume simply by pressing
;; '+' or '-', which will also reset the timer to its initial value.  So
;; instead of pressing 'C-c +' six times to increase volume by six steps of
;; 'emms-volume-change-amount', you would simply type 'C-c + + + + + +'.

;;    EMMS can change volume with amixer, mpd, PulseAudio out of the box,
;; see EMMS-VOLUME-CHANGE-FUNCTION.

;; I can save songs in a bookmark with emms when I'm streaming music!




;;    The following is a list of the key-bindings for the emms-streams
;; interface:

;; 'RET'
;;      Perform the default action when you press RET in the Emms Stream
;;      interface.  Can be either "add" or "play".  The default is "add",
;;      which adds the station under point to the Emms playlist.  When
;;      EMMS-STREAM-DEFAULT-ACTION is "play" then Emms will play the
;;      streaming audio channel under point.
;; 'q'
;;      Quit the emms-streams interface.
;; 'a'
;;      Add a bookmark to a streaming audio URL to the list.
;; 'd'
;;      Remove a bookmark to a streaming audio URL from the list.
;; 'e'
;;      Edit the details of the bookmark under point.
;; 'h'
;;      Describe the emms-streams mode.
;; 'n'
;;      Move to the next line in the emms-streams buffer (same as C-n).
;; 'p'
;;      Move to the previous line in the emms-streams buffer (same as C-p).
;; 's'
;;      Save the bookmarks in the emms-streams interface to disk.  The
;;      bookmarks will be to the location designated in the variable
;;      EMMS-STREAM-BOOKMARKS-FILE.
;; 'i'
;;      Return information about the streaming audio at the URL of the
;;      bookmark under point.  Note that this will only work if the
;;      'emms-stream-info' has already been loaded.


(global-set-key
 (kbd "C-x m")
 (defhydra hydra-emms
   (:body-pre (next-line))
   "
   move         bookmarks
   _n_ext       _a_dd
   _p_revious   _d_elete
   _P_ause      _e_dit

   "
   ("n" (emms-next))
   ("p" (emms-previous))
   ("P" (emms-pause))

   ("a" (emms-bookmarks-add))
   ("d" (emms-bookmarks-clear))
   ("e" (emms-stream-edit-bookmark))))


(require 'init-emms-secret)
;; init-emms-secret looks like
;;(setq
 ;; emms-librefm-scrobbler-username "<your libre.fm username>"
 ;; emms-librefm-scrobbler-password "<your libre.fm password>")

;; eval this next line of code to run emms.  I need to put this into its own command.
;;(emms-librefm-stream "librefm://globaltags/Classical")
(provide 'init-emms)
