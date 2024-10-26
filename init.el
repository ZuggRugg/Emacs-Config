;;set default font
(set-frame-font "default -outline-Iosevka-regular-normal-normal-mono-17-*-*-*-c-*-iso10646-1" nil t)

(setq custom-file "~/.emacs.d/.emacs.custom")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired. See`package-archive-priorities
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


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


;;remove GUI 
(when window-system
 (menu-bar-mode -1)
 (scroll-bar-mode -1)
 (tool-bar-mode -1)
 (tooltip-mode -1))


;;only y/n
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-kill-emacs 'y-or-n-p)


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
(global-set-key (kbd "C-,") 'rc/duplicate-line)


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


;;theme
(load-theme 'ef-dream t)


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
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))
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
(setf dired-kill-when-opening-new-dired-buffer t)

;; tabs
;;(global-tab-line-mode t)

;;auto complete
(ac-config-default)

;;flymake config
(use-package flymake
  :ensure nil          ;; This is built-in, no need to fetch it.
  :defer t
  :hook (prog-mode . flymake-mode)
  :custom
  (flymake-margin-indicators-string
   '((error "!»" compilation-error) (warning "»" compilation-warning)
	 (note "»" compilation-info))))


;;startup buffer setup 
(setq inhibit-startup-screen t)


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

;;;; Org mode configuration
(require 'org)
;;(setq org-startup-folded t)
(setq org-return-follows-link t)
(add-hook 'org-mode-hook 'visual-line-mode)


(add-to-list 'load-path "path/to/which-key.el")
(require 'which-key)
(which-key-mode)


;;vertical completion framework
(use-package vertico
  :init
(vertico-mode))


;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
          :init  (marginalia-mode))


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


;;elfeed
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
	("https://www.royalroad.com/fiction/syndication/58180" novel)
        ("https://www.royalroad.com/fiction/syndication/86047" novel)
        ("https://www.royalroad.com/fiction/syndication/61228" novel)
        ("https://www.royalroad.com/fiction/syndication/62125" novel)
        ("https://www.royalroad.com/fiction/syndication/83294" novel)
	("https://www.royalroad.com/fiction/syndication/81642" novel)
	("https://fakenous.substack.com/feed" blog)
        ("https://hhyu.org/index.xml" blog)
	("https://www.dorfonlaw.org/feeds/posts/default?alt=rss" blog)
	("https://adamgarfinkle.substack.com/feed" blog)
	("https://greyenlightenment.com/feed/" blog)
	("https://www.ntufilmsociety.com/exposure?format=rss" blog)
))
                                    


(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

  (add-hook 'after-init-hook
    (lambda ()
      (message "Emacs has fully loaded. This code runs after startup.")

      ;; Insert a welcome message in the *scratch* buffer displaying loading time and activated packages.
      (with-current-buffer (get-buffer-create "*scratch*")
        (insert (format
                 ";;    Welcome to Emacs!
;;
;;    Loading time : %s
;;    Packages     : %s
"
                  (emacs-init-time)
                  (number-to-string (length package-activated-list)))))))





