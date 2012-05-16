(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)

;; local sources 
(setq el-get-sources '(
		       (:name magit :after (lambda () (global-set-key (kbd "C-x C-z") 'magit-status))) 
		       (:name asciidoc :type elpa 
			      :after (lambda () 
				       (autoload 'doc-mode "doc-mode" nil t) 
				       (add-to-list 'auto-mode-alist '("\\.adoc$" . doc-mode)) 
				       (add-hook 'doc-mode-hook '(lambda () 
								   (turn-on-auto-fill) 
								   (require 'asciidoc))))) 
		       (:name lisppaste :type elpa))) 

(setq my-packages (append '(el-get auto-complete zencoding-mode color-theme color-theme-tango emacs-w3m js2-mode coffee-mode) (mapcar 'el-get-source-name el-get-sources))) 
(el-get 'sync my-packages)

;; settings
(line-number-mode 1)
(column-number-mode 1)
(tool-bar-mode -1)
(setq-default tab-width 4)

(unless (string-match "apple-darwin" system-configuration)
  (menu-bar-mode -1))

(global-linum-mode 1)

;; under mac, have Command as Meta and keep Option for localized input
(when (string-match "apple-darwin" system-configuration)
  (setq mac-allow-anti-aliasing t))

(require 'dired-x) ;; C-x C-j

;(color-theme-tango)
;(color-theme-taming-mr-arneson)

(global-set-key (kbd "C-x SPC") 'set-mark-command)
(custom-set-variables '(x-select-enable-clipboard t))

;; w3m
 (setq browse-url-browser-function 'w3m-browse-url)
 (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
 ;; optional keyboard short-cut
 (global-set-key "\C-xm" 'browse-url-at-point)
(setq w3m-use-cookies t)
(setq w3m-display-inline-images t)

;; coffee
(defun coffee-custom ()
  "coffee-mode-hook"
  ;; CoffeeScript uses two spaces.
  (make-local-variable 'tab-width)
  (set 'tab-width 2)  
  (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer))

(add-hook 'coffee-mode-hook 'coffee-custom)

