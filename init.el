(package-initialize)

;; Move customize
(setq custom-file (expand-file-name (concat user-emacs-directory "custom.el")))
(load custom-file)

;; I like my own elisp in it's own spot
(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "mylisp")))

(require 'flymake-python-pyflakes)

(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

;; Load my keybindings

(require 'my-global-keybindings)

(define-coding-system-alias 'UTF-8 'utf-8)
(setq x-alt-keysym 'meta) ; Force ALT to be meta in my keybindings world.


