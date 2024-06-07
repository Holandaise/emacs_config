;;; This is currently a collection of functions to help create todo files and keep them organized.
;;; The main goal is to have one todo file per week with the current week # as the filename.

(defcustom zettel-directory "~/zet" "The directory where your zettelkasten notes are to be stored")

(add-to-list 'org-agenda-files zettel-directory)

(defun zettel () (interactive)
  (unless (file-exists-p zettel-directory)
    (make-directory zettel-directory))
  (org-open-file (zet--build-filepath)))

(defun zet--build-filepath ()
    (file-name-concat
     (file-name-as-directory zettel-directory)
     (format-time-string "week-%V.org")))
