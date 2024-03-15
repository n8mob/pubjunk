;; from http://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://stable.melpa.org/packages/") t)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq read-buffer-completion-ignore-case t)

(require 're-builder)
(setq reb-re-syntax 'string)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq-default indent-tabs-mode nil)

(setq help-window-select t)

(defun treys-find-file-check-make-large-file-read-only-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 10 1024 1024))
    (setq buffer-read-only t)
    (buffer-disable-undo)
    (fundamental-mode)
    ; (message "Buffer is set to read-only because it is large.  Undo also disabled.")
    ))

(add-hook 'find-file-hook 'treys-find-file-check-make-large-file-read-only-hook)

;; easy spell check
(setq ispell-program-name "/usr/local/bin/aspell")
(setq ispell-list-command "--list"); emacswicki.org/emacs/FlySpell said I need this for ASpell
(global-set-key (kbd "<f8>") 'ispell-word)
(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
(global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell-check the next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.zsh-theme?\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

(add-hook 'text-mode-hook 'flyspell-mode 'visual-line-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode 'visual-line-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

(setq web-mode-enable-auto-quoting t)

;; Org stuff
;; syntax highlighting on HTML export from org-mode
(setq org-src-fontify-natively t)
(setq org-adapt-indentation nil)
(setq org-list-allow-alphabetical t)
(setq org-directory "~/Documents/n/")
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Markdown stuff
(add-hook 'markdown-mode-hook 'visual-line-mode)
(setq markdown-asymmetric-header t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :foreground "magenta3" :height 1.0)))))
      
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(misterioso))
 '(org-agenda-files
   '("~/Documents/n/2022/12_11.org" "~/Documents/n/projects/" "~/Documents/n/areas/" "~/Documents/n/resources/" "~/Documents/n/2022/" "~/Documents/n/2021/"))
 '(org-export-backends '(ascii html md odt org confluence))
 '(org-export-with-toc nil)
 '(org-link-frame-setup
   '((vm . vm-visit-folder-other-frame)
     (vm-imap . vm-visit-imap-folder-other-frame)
     (gnus . org-gnus-no-new-news)
     (file . find-file)
     (wl . wl-other-frame)))
 '(package-selected-packages '(php-mode web-mode markdown-mode htmlize elpy)))
      
(tool-bar-mode -1)
