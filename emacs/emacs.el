(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(golden-ratio-mode t))
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
       '(cssh el-get switch-window vkill google-maps xcscope yasnippet golden-ratio)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get-cleanup my-packages)
(el-get 'sync my-packages)

(global-set-key "\C-cc" 'org-capture)
