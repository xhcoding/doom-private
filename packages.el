;; -*- no-byte-compile: t; -*-
;;; config/private/packages.el

(package! visual-regexp)
(package! visual-regexp-steroids)
(package! company-posframe)
(package! org-edit-latex)


(package! isolate :recipe (:fetcher github :repo "casouri/isolate"))
(package! color-rg :recipe (:fetcher github :repo "manateelazycat/color-rg"))
(package! company-english-helper :recipe (:fetcher github :repo "manateelazycat/company-english-helper"))

(package! auto-save :ignore t)
(package! scroll-other-window :ignore t)
(package! openwith :ignore t)
