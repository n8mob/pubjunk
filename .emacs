;; from http://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(require 're-builder)
(setq reb-re-syntax 'string)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq-default indent-tabs-mode nil)

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

(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

(add-hook 'text-mode-hook 'flyspell-mode 'visual-line-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode 'visual-line-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

(setq web-mode-enable-auto-quoting t)

;; Org stuff
;; syntax highlighting on HTML export from org-mode
(setq org-src-fontify-natively t)
(setq org-adapt-indentation nil)
(setq org-link-file-path-type relative)


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
 '(custom-enabled-themes (quote (misterioso)))
 '(org-export-backends (quote (ascii html md odt org confluence)))
 '(org-export-with-toc nil)
 '(package-selected-packages (quote (php-mode web-mode markdown-mode htmlize elpy))))
      
(tool-bar-mode -1)
