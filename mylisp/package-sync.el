;;; package-sync.el --- Make packages I add through Elpa
;;; auto-install on other Emacs instances

;; Copyright (C) 2015 Matt Jenkins <mdj@emdeejay.net>

(require 'cl)
(package-initialize)

(defvar installed-packages "List of packages that were installed as of last shutdown")

(defvar installed-packages-file (expand-file-name "installed-packages-list.el" (expand-file-name "mylisp" (expand-file-name user-emacs-directory))))

(require 'installed-packages-list)

(defun update-installed-packages ()
  (with-temp-file installed-packages-file
      (insert-string "(setq installed-packages '")
      (insert-string (format "%s"
		       (mapcar (lambda (pkg) (car pkg))
			  (remove-if-not (lambda (pkg)
					  (string= "installed"
					   (package-desc-status (cadr pkg))))
					   package-archive-contents))))
      (insert-string ")\n\n(provide 'installed-packages-list)")))

(add-hook 'kill-emacs-hook #'update-installed-packages)

(defun install-missing-packages ()
  (dolist (pkg installed-packages)
    (package-install pkg)))

(add-hook 'after-init-hook #'install-missing-packages)

(provide 'package-sync)
  
