(provide 'am-keybinds)
;; Keybindings for init.el to load
(unless (package-installed-p 'general)
  (package-install 'general))
(require 'general)
(general-evil-setup)
(general-create-definer leader-key-def
			:prefix "SPC")

(leader-key-def
  :keymaps 'normal
  "b" '(:ignore t :wk "Buffer")
  "bb" '(consult-buffer :wk "Select Buffer")
  "bk" '(kill-this-buffer :wk "Buffer Kill")
  "bn" '(next-buffer :wk "Buffer Next")
  "bp" '(previous-buffer :wk "Buffer Prev")
  "bi" '(ibuffer :wk "Open ibuffer"))

(leader-key-def
 :keymaps 'normal
 "w" '(:ignore t :wk "Window")
 "wk" '(evil-window-delete :wk "Window Kill")
 "wh" '(evil-window-left :wk "Window Left")
 "wl" '(evil-window-right :wk "Window Right")
 "ww" '(evil-window-prev :wk "Previous Window"))

(leader-key-def
 :keymaps 'normal
 "oa" '(org-agenda :wk "Org-Agenda")
 "oc" '(org-capture :wk "Org Capture")
 "ot" '((lambda () (interactive) (find-file "~/org/todo.org")) :wk "Open TODOs")
 "od" '(dired :wk "Open Dired")
 "or" '(refcard-display-card :wk "Open refcard"))

(leader-key-def
  :keymaps 'normal
  "." '(find-file :wk "Find File")
  "fc" '((lambda () (interactive) (find-file "~/.emacs.d/init.el")) :wk "Edit Emacs Config"))

(leader-key-def
  :keymaps 'normal
  "te" '(eshell :wk "eshell terminal")
  "tv" '(vterm-other-window :wk "vterm"))

(leader-key-def
  :keymaps 'normal
  "hf" '(describe-function :wk "Help Function")
  "hv" '(describe-variable :wk "Help Variable"))

(leader-key-def
  :keymaps 'normal
  "gg" '(magit-status :wk "Magit Status")
  "gs" '(magit-stage-file :wk "Stage Current File"))
