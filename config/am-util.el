;; following along with Geoffrey Lessel on YouTube
;; Need to factor out refcard directory as a variable with default

(provide 'am-util)

(defun refcard-display-card (filename)
  "Display user created reference cards"
  (interactive
   (let ((filename (read-file-name "File: " "~/.emacs.d/refcards/" nil t)))
     (list filename)))
  (let ((buffer-name "*refcard*"))
    (with-current-buffer (get-buffer-create buffer-name)
      (buffer-disable-undo)
      (insert-file-contents filename nil nil nil t)
      (set-buffer-modified-p nil)
      (org-mode)
      (let ((view-read-only nil)) (read-only-mode t))
      (keymap-set evil-normal-state-local-map (kbd "q") #'kill-buffer-and-window)
      (goto-char (point-min)))
    (pop-to-buffer buffer-name '((display-buffer-at-bottom)
				 (inhibit-same-window . t)
				 (window-height . fit-window-to-buffer)))))

(defun refcard-new-card ()
  "Create a new refcard file"
  (message (word-at-point)))

;; For org-capture template
(defun end-of-week ()
  "Return the date of the end of the current week (Sunday)"
  (format-time-string "%F %a"
		      (time-add (current-time)
				(seconds-to-time (* (- 7 (nth 6 (decode-time))) 86400)))))

(defcustom zettel-directory "~/zet" "The directory where your zettelkasten are to be stored")

(add-to-list 'org-agenda-files zettel-directory)

(defun zettel ()
  "open this week's zet; create if not exists"
  (interactive)
  (unless (file-exists-p zettel-directory)
    (make-directory zettel-directory))
  (org-open-file (zet--build-filepath)))

(defun zet--build-filepath ()
  "return the filename with the current week number"
  (file-name-concat
   (file-name-as-directory zettel-directory)
   (format-time-string "week-%V.org")))
