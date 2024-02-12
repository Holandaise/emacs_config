;; following along with Geoffrey Lessel on YouTube
;; Need to factor out refcard directory as a variable with default

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
