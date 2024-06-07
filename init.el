;; Global variables
(setq org-directory "~/org")
(setq org-agenda-files '("~/org"))
(setq tab-width 4)
(setq scroll-margin 8)

;; package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
(package-refresh-contents)

;; config modules
(add-to-list 'load-path
 (directory-file-name (concat (getenv "HOME") "/.emacs.d/config")))

;; Get Evil for vim keybindings
(unless (package-installed-p 'evil)
  (package-install 'evil))
(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))
;; Enable Evil
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(setq evil-vsplit-window-right t)
(setq evil-split-window-below t)
(require 'evil)
(evil-mode 1)
(evil-collection-init)

;; set theme
(unless (package-installed-p 'ef-themes)
  (package-install 'ef-themes))
(let ((daytime-theme 'ef-arbutus)
      (nighttime-theme 'ef-night))
  (if (> (decoded-time-hour (decode-time)) 19)
      (load-theme nighttime-theme t)
    (load-theme daytime-theme t)))

;; Terminal Mode
(unless (package-installed-p 'vterm)
  (package-install 'vterm))

;; set font
(set-frame-font "Terminus 14")

;; UI
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(column-number-mode)
(global-hl-line-mode 1) 

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; No backup files DAMMIT!
(setq backup-directory-alist
     '((".*" . ,temporary-file-directory)))
(setq make-backup-files nil)
(setq backup-inhibited t)

;; minibuffer selection
(unless (package-installed-p 'vertico)
  (package-install 'vertico))
(require 'vertico)
(setq vertico-cycle 1)
(vertico-mode 1)

;; some useful info for vertico
(unless (package-installed-p 'marginalia)
  (package-install 'marginalia))
(require 'marginalia)
(marginalia-mode 1)

;; which-key
(unless (package-installed-p 'which-key)
  (package-install 'which-key))
(require 'which-key)
(which-key-mode 1)

;; projectile
(unless (package-installed-p 'projectile)
  (package-install 'projectile))
(require 'projectile)

;; magit
(unless (package-installed-p 'magit)
  (package-install 'magit))
(require 'magit)

;; lsp-mode
(unless (package-installed-p 'lsp-mode)
  (package-install 'lsp-mode))
(require 'lsp-mode)

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

;; company-mode for completions
(unless (package-installed-p 'company)
  (package-install 'company))
(unless (package-installed-p 'consult)
  (package-install 'consult))

(add-hook 'prog-mode-hook 'company-mode)
;;(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Language Support
(unless (package-installed-p 'zig-mode)
  (package-install 'zig-mode))
(add-hook 'zig-mode-hook 'lsp-mode)
(unless (package-installed-p 'rust-mode)
  (package-install 'rust-mode))

;; Nicer looking org-mode
(unless (package-installed-p 'org-bullets)
  (package-install 'org-bullets))
(add-hook 'org-mode-hook 'org-bullets-mode)

(setq org-todo-keywords '((sequence "TODO" "WAIT" "DONE")))

(setq org-capture-templates
      '(("t" "TODO" entry (file+headline "~/org/todo.org" "Inbox")
	 "* TODO %?\n")
	("j" "Journal" entry (file+datetree "~/org/journal.org")
	 "* %?\nEntered on %U\n %i\n %a")
	("n" "Note" entry (file+headline "~/org/notes.org" "Inbox")
	 "* %U %?")
	("b" "To buy" item (file+headline "~/org/todo.org" "Shopping")
	 "- [ ] %?\n")
	("h" "Habit" entry (file+headline "~/org/todo.org" "Daily")
	 "* TODO %?\n")
	("e" "EOW" entry (file+headline "~/org/todo.org" "EOW")
	 "* TODO %?\nDEADLINE: <%(end-of-week)>")))

;; keybinds
(require 'am-keybinds)
;; refcard utils
(require 'am-util)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("79a8c85692a05a0ce0502168bb0e00d25f021a75d8b0136b46978bddf25e3b72" "c2c63381042e2e4686166d5d59a09118017b39003e58732b31737deeed454f1c" "2777f300b438d2d061560c6a1afac9723e7f840413b12a471055428269ee17dd" "2ca3da7d36b0d326f984530a07be54b272b5c313b1361989acf747d8b5616162" default))
 '(org-agenda-files
   '("/home/adam/zet/week-07.org" "/home/adam/org/elisp.org" "/home/adam/org/journal.org" "/home/adam/org/notes.org" "/home/adam/org/todo.org"))
 '(package-selected-packages
   '(vterm rainbow-delimiters consult company general rust-mode zig-mode lsp-mode magit projectile which-key marginalia vertico ef-themes evil-collection evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
