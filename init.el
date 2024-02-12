;; Adam's custom emacs config I liked doom, but it's just too much overhead; I
;; mean, the kitchen sink was included It also has so many packages that I don't
;; know what they all do. For me, it's better to just build a config from
;; scratch, learn a bit about elisp, and the emacs environment along the way.

;; I also feel like the all-in-one solutions like doom, astrovim, and the like
;; go against the spirit of using extensible editors. They're extensibile for
;; YOU, when YOU'RE ready, or find it necessary to make customizations. Another
;; problem I had with the ready-made solutions is, how do I know where the
;; underlying tool stops and the customization begins?

;; It's kinda like REACT for front-end development. There's a tool to do the
;; job, Javascript, but people have piled cruft on top of it to make building a
;; website "easier". The problem is, now devs have to learn the language and the
;; framework(s).


;; Global variables
(setq gfont-height 130
      org-directory "~/org"
      org-agenda-files '("~/org"))
(setq tab-width 4)

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
(unless (package-installed-p 'doom-themes)
  (package-install 'doom-themes))
(require 'doom-themes)
;; Modus theme customization
;; (setq modus-themes-region '(bg-only))
;; (setq modus-themes-fringes 'intense)
(load-theme 'modus-vivendi)

;; set font
(set-face-attribute 'default nil :font "Fira Code Retina" :height gfont-height)
(set-face-attribute 'fixed-pitch nil :font "Droid Sans Mono" :height gfont-height)

;; UI
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(column-number-mode)
(global-display-line-numbers-mode t)
(global-hl-line-mode 1) 

;; No backup files DAMMIT!
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
(unless (package-installed-p 'corfu)
  (package-install 'corfu))
(setq corfu-cycle t)
(setq corfu-auto t)
(corfu-mode)

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
;;(load-file "am-keybinds.el")
(require 'am-keybinds)

;; For org-capture template
(defun end-of-week ()
  "Return the date of the end of the current week (Sunday)"
  (format-time-string "%F %a"
		      (time-add (current-time)
				(seconds-to-time (* (- 7 (nth 6 (decode-time))) 86400)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("016f665c0dd5f76f8404124482a0b13a573d17e92ff4eb36a66b409f4d1da410" "944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "2f8eadc12bf60b581674a41ddc319a40ed373dd4a7c577933acaff15d2bf7cc6" "5586a5db9dadef93b6b6e72720205a4fa92fd60e4ccfd3a5fa389782eab2371b" "6945dadc749ac5cbd47012cad836f92aea9ebec9f504d32fe89a956260773ca4" "1aa4243143f6c9f2a51ff173221f4fd23a1719f4194df6cef8878e75d349613d" "bf948e3f55a8cd1f420373410911d0a50be5a04a8886cabe8d8e471ad8fdba8e" "2078837f21ac3b0cc84167306fa1058e3199bbd12b6d5b56e3777a4125ff6851" "1cae4424345f7fe5225724301ef1a793e610ae5a4e23c023076dc334a9eb940a" "b54376ec363568656d54578d28b95382854f62b74c32077821fdfd604268616a" "3fe1ebb870cc8a28e69763dde7b08c0f6b7e71cc310ffc3394622e5df6e4f0da" "a9abd706a4183711ffcca0d6da3808ec0f59be0e8336868669dc3b10381afb6f" "8d8207a39e18e2cc95ebddf62f841442d36fcba01a2a9451773d4ed30b632443" "b99e334a4019a2caa71e1d6445fc346c6f074a05fcbb989800ecbe54474ae1b0" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "8b6506330d63e7bc5fb940e7c177a010842ecdda6e1d1941ac5a81b13191020e" "00cec71d41047ebabeb310a325c365d5bc4b7fab0a681a2a108d32fb161b4006" "1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700" "683b3fe1689da78a4e64d3ddfce90f2c19eb2d8ab1bab1738a63d8263119c3f4" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "49acd691c89118c0768c4fb9a333af33e3d2dca48e6f79787478757071d64e68" "0c83e0b50946e39e237769ad368a08f2cd1c854ccbcd1a01d39fdce4d6f86478" "7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" "f366d4bc6d14dcac2963d45df51956b2409a15b770ec2f6d730e73ce0ca5c8a7" default))
 '(package-selected-packages
   '(projectile marginalia consult evil-collection doom-themes corfu-mode rust-mode zig-mode lsp-mode which-key vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "#1d2026" :foreground "#bbc2cf" :box nil :height 1.1)))))
