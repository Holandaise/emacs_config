;; Global variables
(setq gfont-height 160)
(setq org-directory "~/org")
(setq org-agenda-files '("~/org"))
(setq tab-width 4)
(setq scroll-margin 8)

;; config modules
(add-to-list 'load-path
 (directory-file-name (concat (getenv "HOME") "/.emacs.d/config")))

;; package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
(package-refresh-contents)

;; Get Evil
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
(load-theme 'ef-night t)

;; set font
(set-face-attribute 'default nil :font "Terminus" :height 160)
(set-face-attribute 'fixed-pitch nil :font "Droid Sans Mono" :height gfont-height)

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

;; corfu-mode for completions
(unless (package-installed-p 'corfu)
  (package-install 'corfu))
(setq corfu-cycle t)
(setq corfu-auto t)
(setq corfu-echo-documentation 0.25)
(corfu-mode t)

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
