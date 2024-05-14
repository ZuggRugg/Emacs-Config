;;set default font
 (set-frame-font "Consolas 13" nil t)

;;start at full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;;remove GUI features
(when window-system
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1))


;;Alternate theme
;;(use-package shades-of-purple-theme
;;:config
;;(load-theme 'shades-of-purple))


;;main theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)


;; transparency
(set-frame-parameter nil 'alpha-background 75)
(add-to-list 'default-frame-alist '(alpha-background . 75))


;;extra package repository
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired. See`package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;;org-modern
(global-org-modern-mode)


;;auto complete text
(ac-config-default) 


;; new dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-startup-banner '"C:/Users/Shayn/Pictures/Art/Emac.jpg")
(setq dashboard-week-agenda t)
(setq dashboard-center-content t)


;;display lines and add new lines when at end of buffer
(global-display-line-numbers-mode 1)
(setq next-line-add-newlines t)


;;remove beeping
(set-message-beep 'silent)


;;golden ratio window resize
(require 'golden-ratio)
(golden-ratio-mode 1)
(setq golden-ratio-auto-scale t)


;; Enable transient mark mode
(transient-mark-mode)


;;;; Org mode configuration
;; Enable Org mode
(require 'org)
(setq org-startup-folded t)


;;vertico-mode
(use-package vertico
  :init
(vertico-mode))


;;magit-mode
(use-package magit
 :bind (("C-x g" . magit))
 )

;;projectile-mode
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

