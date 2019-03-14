;; -*- no-byte-compile: t; -*-
;;; config/private/packages.el

(disable-packages! anaconda-mode company-irony company-irony-c-headers flycheck-irony irony irony-eldoc ivy-rtags rtags)

(package! visual-regexp)
(package! visual-regexp-steroids)
(package! org-edit-latex)
(package! pyim)
(package! package-lint)

(package! company-english-helper :recipe (:fetcher github :repo "manateelazycat/company-english-helper"))

(package! auto-save :ignore t)
(package! openwith :ignore t)
