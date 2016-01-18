(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-lastsexp)))

;; (el-get 'sync)

;; local sources 
(setq el-get-sources 
      '((:name magit	     
	       :after (global-set-key (kbd "C-x C-z") 'magit-status))

	(:name asciidoc 
	       :type elpa 
	       :after (progn 
			(autoload 'doc-mode "doc-mode" nil t) 
			(add-to-list 'auto-mode-alist '("\\.adoc$" . doc-mode)) 
			(add-hook 'doc-mode-hook 
				  '(lambda () 
				     (turn-on-auto-fill) 
				     (require 'asciidoc))))) 

		       (:name lisppaste :type elpa)

		      (:name emacs-goodies-el :type apt-get)

		       (:name buffer-move :after(progn
						  (global-set-key (kbd "<C-S-up>") 'buf-move-up)
						  (global-set-key (kbd "<C-S-down>") 'buf-move-down)
						  (global-set-key (kbd "<C-S-left>") 'buf-move-left)
						  (global-set-key (kbd "<C-S-right>") 'buf-move-right)))
		       (:name goto-last-change
			      :after (progn
				       (global-set-key (kbd "C-x C-_") 'goto-last-change)))
))

(setq my-packages 
      (append 
       '(cssh el-get auto-complete switch-window vkill zencoding-mode color-theme color-theme-tango emacs-w3m js2-mode coffee-mode markdown-mode nxhtml xcscope yasnippet) 
       (mapcar 'el-get-source-name el-get-sources)))
;; (when (el-get-executable-find "cvs")
;;  (add-to-list 'my-packages 'emacs-goodies-el)) ; the debian addons for emacs

(when (el-get-executable-find "svn")
  (loop for p in '(psvn    ; M-x svn-status
		   )
	do (add-to-list 'my-packages p)))
 
(el-get 'sync my-packages)

;; settings
(line-number-mode 1)
(column-number-mode 1)
(tool-bar-mode -1)
(setq-default tab-width 4)

(unless (string-match "apple-darwin" system-configuration)
  (menu-bar-mode -1))

;; (global-linum-mode 1)
;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)

;; under mac, have Command as Meta and keep Option for localized input
(when (string-match "apple-darwin" system-configuration)
  (setq mac-allow-anti-aliasing t))

(require 'dired-x) ;; C-x C-j

;; use ido for minibuffer completion
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)

;(color-theme-andreas)

;arjen, billw, black-on-grey, blue-mood, blue-sea, calm-forest, dark-laptop, digital-ofs1, euphoria, fischmeister, 
;
;white: greiner, high-contrast, jb-simple, jedit-gray*, jsc-light, katester, mistyday, montz*, 
;black: hober, lawrence, lethe, oswald, renegade
;blue: resolve, 
;other: infodoc


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

;; markdown
;; (autoload 'markdown-mode "markdown-mode"
;;  "Major mode for editing Markdown files" t)
;;(setq auto-mode-alist
;;  (cons '("\\.text" . markdown-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.text$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.text$" . markdown-mode))

;; (require 'inf-ruby)
