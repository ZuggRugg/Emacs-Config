;;set default font
(set-frame-font "Consolas-13" nil t)


;;frame settings
(setq frame-resize-pixelwise t)
(setq frame-inhibit-implied-resize t)


;; maximize screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;;scroll less janky 
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq pixel-scroll-precision-large-scroll-height 40.0)


;;remove GUI 
(when window-system
 (menu-bar-mode -1)
 (scroll-bar-mode -1)
 (tool-bar-mode -1)
 (tooltip-mode -1))


;;only y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;silent beep
(set-message-beep 'asterick)


;;custom keybindings 
(global-set-key (kbd "C-c w") 'eww-list-bookmarks)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x C-l") 'reload-init-file)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c e") 'elfeed)
(global-set-key (kbd "C-c b") 'bookmark-bmenu-list)
(global-set-key (kbd "C-c s") 'avy-goto-char-2)


;;theme
(load-theme 'modus-vivendi t)

;;reload init file
(defun reload-init-file ()
  (interactive)
  (load-file user-init-file)
  (princ "Init-file reloaded.")
  )


;;pair compeltion
(electric-pair-mode t)


;; transparency
(defun t-darker ()
"medium transparency setting"
(interactive)
(set-frame-parameter (selected-frame) 'alpha '(88 . 88))
(add-to-list 'default-frame-alist '(alpha . (88 . 88)))
)

(defun t-lighter ()
"lightest transparancy setting"
(interactive)
(set-frame-parameter (selected-frame) 'alpha '(77 . 77))
(add-to-list 'default-frame-alist '(alpha . (77 . 77)))
)

(defun t-default ()
"change transparency back to normal"
(interactive)
(set-frame-parameter (selected-frame) 'alpha '(100 . 100))
(add-to-list 'default-frame-alist '(alpha . (100 . 100)))
)


;;golden ratio mode
(golden-ratio-mode)


;; modeline
(require 'doom-modeline)
(doom-modeline-mode 1)
(display-time-mode t)


;;icons 
(use-package nerd-icons)
(use-package nerd-icons-dired)
(nerd-icons-dired-mode t)

;;make dired mode show less
(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(use-package dired-subtree
  :config
  (bind-keys :map dired-mode-map)
  ("TAB" . dired-subtree-toggle))


;; tabs
;;(global-tab-line-mode t)


;;auto complete
(ac-config-default)


;;startup buffer setup 
(setq inhibit-startup-screen t)



;;line settings and tweaks
(setq next-line-add-newlines t)
(line-number-mode -1)
;;(global-visual-line-mode 1)
(setq-default truncate-lines t)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
;;(setq mode-line-position 0)


;;rainbow delimiters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;Enable transient mark mode
(transient-mark-mode)

;;;; Org mode configuration
;; Enable Org mode
(require 'org)
(setq org-startup-folded t)
(setq org-return-follows-link t)
(add-hook 'org-mode-hook 'visual-line-mode)

;;vertical completion framework
(use-package vertico
  :init
(vertico-mode))


;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))


;;git integration 
(use-package magit
 :bind (("C-x g" . magit))
 )

(require 'pulsar)
(pulsar-global-mode 1)
(setq pulsar-delay 0.070)
(setq pulsar-face 'pulsar-yellow)


;;diminish mode for modeline
(require 'diminish)
(diminish 'rainbow-delimiters-mode "")
(diminish 'auto-complete-mode "")
(diminish 'projectile-mode "")
(diminish 'eldoc-mode "Eldoc")
(diminish 'golden-ratio-mode "")
(diminish 'javascript-mode "JS")

                                    
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired. See`package-archive-priorities
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
