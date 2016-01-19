(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(global-linum-mode t)
 '(golden-ratio-mode t)
 '(package-archives
   (quote
    (("gnu" . "http://eLpa.gnu.org/packages/")
     ("ELPA" . "http://tromey.com/elpa/")
     ("melpa" . "http://melpa.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ("SC" . "http://joseito.republika.pl/sunrise-commander/")
     ("org" . "http://orgmode.org/elpa/")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(require 'el-get)

;; local sources
(el-get-bundle magit
  (global-set-key (kbd "C-x C-z") 'magit-status))
;; (el-get-bundle elpa:asciidoc
;;   (autoload 'doc-mode "doc-mode" nil t)
;;   (add-to-list 'auto-mode-alist '("\\.adoc$" . doc-mode))
;;   (add-hook 'doc-mode-hook
;; 	    '(lambda ()
;; 	       (turn-on-auto-fill)
;; 	       (require 'asciidoc))))
;; (el-get-bundle elpa:lisppaste)
;; (el-get-bundle apt-get:emacs-goodies-el)


(setq my-packages
      (append
       '(cssh el-get package switch-window vkill golden-ratio osx-clipboard htmlize linum-ex markdown-mode org-plus-contrib)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get-cleanup my-packages)
(el-get 'sync my-packages)

(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
;; (global-set-key (kbd "C-x o") 'switch-window)

(golden-ratio-mode t)

