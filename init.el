;; =========================================================================================================
;; ZuggRugg Emacs Config File :: Default System Settings ===================================================
;; =========================================================================================================

;;set default font
(set-frame-font "default -outline-Iosevka-regular-normal-normal-mono-17-*-*-*-c-*-iso10646-1" nil t)

(setq custom-file "~/.emacs.d/.emacs.custom")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired. See`package-archive-priorities
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;; STANDARD FUCKING ENCODING
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)

;; stop the creation of useless ~files
(setq make-backup-files nil)

;;increase garbage collection size
(setq gc-cons-threshold #x40000000)

(setq read-process-output-max (* 1024 1024 4))

;;frame settings
(setq frame-resize-pixelwise t)
(setq frame-inhibit-implied-resize t)

;; maximize screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;scroll less janky 
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq pixel-scroll-precision-large-scroll-height 40.0)

;;narrow to region allowed
(put 'narrow-to-region 'disabled nil)

;;remove GUI 
(when window-system
 (menu-bar-mode -1)
 (scroll-bar-mode -1)
 (window-divider-mode)
 (tool-bar-mode -1)
 (tooltip-mode -1))

;;theme
(load-theme 'ef-winter t)

;;only y/n
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-kill-emacs 'y-or-n-p)

;;silent beep
(set-message-beep 'asterick)


;; =========================================================================================================
;; ZuggRugg Emacs Config File :: Editing and Macros  =======================================================
;; =========================================================================================================
;;custom keybindings 
(global-set-key (kbd "C-c w") 'eww-list-bookmarks)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-c l") 'reload-init-file)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c e") 'elfeed)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c r") 'recompile)
(global-set-key (kbd "C-c b") 'bookmark-bmenu-list)
(global-set-key (kbd "C-,") 'rc/duplicate-line)    
(global-set-key (kbd "C-c m") 'mc/edit-lines)    
(global-set-key (kbd "C-;") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-;") 'mc/mark-all-like-this)
;; (global-set-key (kbd "C-x C-b") 'ibuffer-list-buffers)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

;;move-text package default bindings
(require 'move-text)
(move-text-default-bindings)


(defun rc/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))


;;minibuffer framework
(icomplete-mode)

;;line settings and tweaks
(setq next-line-add-newlines t)
;;(line-number-mode -1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq-default truncate-lines t)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)


;;(setq mode-line-position 0)
;;(global-hl-line-mode 1) 

;;rainbow delimiters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;Enable transient mark mode
(transient-mark-mode)

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
(set-frame-parameter (selected-frame) 'alpha '(93 . 93))
(add-to-list 'default-frame-alist '(alpha . (93 . 93)))
)

(defun t-lighter ()
"lightest transparancy setting"
(interactive)
(set-frame-parameter (selected-frame) 'alpha '(85 . 85))
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))
)

(defun t-default ()
"change transparency back to normal"
(interactive)
(set-frame-parameter (selected-frame) 'alpha '(100 . 100))
(add-to-list 'default-frame-alist '(alpha . (100 . 100)))
)

;; =========================================================================================================
;; ZuggRugg Config File :: Misc Packages ===================================================================
;; =========================================================================================================

;;golden ratio mode
(golden-ratio-mode)

;; modeline
(display-time-mode t)

;;icons 
(use-package nerd-icons)
(setf dired-kill-when-opening-new-dired-buffer t)

;; tabs
;;(global-tab-line-mode t)

;;company mode 
(add-hook 'after-init-hook 'global-company-mode)

(use-package corfu
  ;; Optional customizations
   ;; :hook ((prog-mode . corfu-mode)
   ;;        (shell-mode . corfu-mode)
   ;;        (eshell-mode . corfu-mode))
  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))

(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
   (add-hook 'completion-at-point-functions #'cape-history)
)

;;competions config
(setopt enable-recursive-minibuffers t)
(setopt completion-auto-help 'always)
(setopt completions-max-height 20)
(setopt completions-format 'one-column)
(setopt completion-auto-select 'second-tab)


(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))


;;flymake config
(use-package flymake
  :ensure nil          ;; This is built-in, no need to fetch it.
  :defer t
  :custom
  (flymake-margin-indicators-string
   '((error "!»" compilation-error) (warning "»" compilation-warning)
	 (note "»" compilation-info))))


;;startup buffer setup 
(setq inhibit-startup-screen t)


;;;; Org mode configuration
(require 'org)
;;(setq org-startup-folded t)
(setq org-return-follows-link t)
(add-hook 'org-mode-hook 'visual-line-mode)


(add-to-list 'load-path "path/to/which-key.el")
(require 'which-key)
(which-key-mode)


;;git integration 
(use-package magit
 :bind (("C-x g" . magit))
 )


(require 'conda)
;; if you want interactive shell support, include:
(conda-env-initialize-interactive-shells)
;; if you want eshell support, include:
(conda-env-initialize-eshell)
;; if you want auto-activation (see below for details), include:
(conda-env-autoactivate-mode t)
;; if you want to automatically activate a conda environment on the opening of a file:
;; (add-hook 'find-file-hook (lambda () (when (bound-and-true-p conda-project-env-path)
;;                                           (conda-env-activate-for-buffer))))


(require 'multiple-cursors)

;;pulsar package
(require 'pulsar)
(pulsar-global-mode 1)
(setq pulsar-delay 0.070)
(setq pulsar-face 'pulsar-yellow)


;;diminish mode for modeline
(require 'diminish)
(diminish 'rainbow-delimiters-mode "")
(diminish 'auto-complete-mode "")
;;(diminish 'projectile-mode "")
(diminish 'eldoc-mode "Eldoc")
(diminish 'golden-ratio-mode "")
(diminish 'javascript-mode "JS")


;;elfeed list
(setq elfeed-search-filter "@4-weeks-ago +unread")
(setq elfeed-search-title-max-width 100)
(setq elfeed-search-title-min-width 30)
(setq elfeed-search-trailing-width 50)
(setq elfeed-show-truncate-long-urls t)
(setq elfeed-feeds
      '(("https://protesilaos.com/codelog.xml" emacs)
        ("https://www.noahpinion.blog/feed" blog)
	("https://www.richardhanania.com/feed" blog)
	("https://www.infinitescroll.us/feed" blog)
        ("https://www.honest-broker.com/feed" blog)
        ("https://www.astralcodexten.com/feed" blog)
        ("https://rss.beehiiv.com/feeds/owMwaGYU36.xml" blog)
        ("https://openrss.org/www.reuters.com/world/" news)
	("https://rss.politico.com/politics-news.xml" politics)
	("https://www.propublica.org/feeds/propublica/main" politics)
	("https://fakenous.substack.com/feed" blog)
        ("https://hhyu.org/index.xml" blog)
	("https://www.dorfonlaw.org/feeds/posts/default?alt=rss" blog)
	("https://adamgarfinkle.substack.com/feed" blog)
	("https://www.ntufilmsociety.com/exposure?format=rss" blog)
))
                                    

  (add-hook 'after-init-hook
    (lambda ()
      (message "Emacs has fully loaded. This code runs after startup.")
      ;; Insert a welcome message in the *scratch* buffer displaying loading time and activated packages.
      (with-current-buffer (get-buffer-create "*scratch*")
        (insert (format
"        Emacs, a GNU text editor
 ⠀⠀⠀⢰⠶⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠶⠲⣄⠀
 ⠀⠀⣠⡟⠀⠈⠙⢦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⡶⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠾⠋⠁⠀⠀⢽⡄
 ⠀⠀⡿⠀⠀⠀⠀⠀⠉⠷⣄⣀⣤⠤⠤⠤⠤⢤⣷⡀⠙⢷⡄⠀⠀⠀⠀⣠⠞⠉⠀⠀⠀⠀⠀⠈⡇
 ⠀⢰⡇⠀⠀⠀⠀⠀⠀⠀⠉⠳⣄⠀⠀⠀⠀⠀⠈⠁⠀⠀⠹⣦⠀⣠⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀⡗
 ⠀⣾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣻⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣏
 ⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡇
 ⠀⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠂
 ⠀⢿⠀⠀⠀⠀⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣤⣤⣤⡀⠀⠀⠀⠀⠀⣸⠇⠀
 ⠀⠘⣇⠀⠀⠀⠀⠉⠉⠛⠛⢿⣶⣦⠀⠀⠀⠀⠀⠀⢴⣾⣟⣛⡋⠋⠉⠉⠁⠀⠀⠀⠀⣴⠏⠀⠀
 ⢀⣀⠙⢷⡄⠀⠀⣀⣤⣶⣾⠿⠋⠁⠀⢴⠶⠶⠄⠀⠀⠉⠙⠻⠿⣿⣷⣶⡄⠀⠀⡴⠾⠛⠛⣹⠇
 ⢸⡍⠉⠉⠉⠀⠀⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⣬⠷⣆⣠⡤⠄⢀⣤⠞⠁⠀
 ⠈⠻⣆⡀⠶⢻⣇⡴⠖⠀⠀⠀⣴⡀⣀⡴⠚⠳⠦⣤⣤⠾⠀⠀⠀⠀⠀⠘⠟⠋⠀⠀⠀⢻⣄⠀⠀
 ⠀⠀⣼⠃⠀⠀⠉⠁⠀⠀⠀⠀⠈⠉⢻⡆⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⠀⠀
 ⠀⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡀⠀⠀⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⣀⡿⠧⠿⠿⠟⠀⠀
 ⠀⣾⡴⠖⠛⠳⢦⣿⣶⣄⣀⠀⠀⠀⠀⠘⢷⣀⠀⣸⠃⠀⠀⠀⣀⣀⣤⠶⠚⠉⠀⠀⠀⠀⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⠀⠈⢷⡀⠈⠻⠦⠀⠀⠀⠀⠉⠉⠁⠀⠀⠀⠀⠹⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⠀⢀⡴⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⢠⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⡄⠀⠀⠀⠀⠀⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⢲⡗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡆⠀⠀⠀⠀⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀
    Emacs version: %s
    Loading time : %s
    Packages     : %s
"                
 (substring (emacs-version) 0 15)
 (emacs-init-time)
 (number-to-string (length package-activated-list)))))))

;;create new session for org-clock
(defun session-new(num)
"Create a new session"
(interactive "sEnter Session Number: ")
(insert (format"* TODO - Session %s" num)
(insert "\n")))







