;; -*- no-byte-compile: t; -*-
;;; config/private/packages.el

(package! visual-regexp)
(package! visual-regexp-steroids)
(package! org-edit-latex)
(package! package-lint)

(package! lsp-python-ms)

(package! company-english-helper :recipe (:fetcher github :repo "manateelazycat/company-english-helper"))

(package! auto-save :ignore t)
(package! openwith :ignore t)
