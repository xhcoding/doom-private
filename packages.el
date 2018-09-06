;; -*- no-byte-compile: t; -*-
;;; config/private/packages.el


;; disable some packages
(disable-packages! rtags
                   ivy-rtags
                   anaconda-mode
                   company-anaconda
                   )


(package! lsp-mode)
(package! lsp-ui)

(when (featurep! :completion company)
  (package! company-lsp))


(package! auto-save :ignore t)

(package! visual-regexp)
(package! visual-regexp-steroids)

(package! company-english-helper :ignore t)

(package! company-posframe)

(package! eaf :ignore t)

(package! scroll-other-window :ignore t)

(package! openwith :ignore t)

(package! org-edit-latex)

(package! isolate :recipe (:fetcher github :repo "casouri/isolate"))

(package! color-rg :recipe (:fetcher github :repo "manateelazycat/color-rg"))

(package! company-english-helper :recipe (:fetcher github :repo "manateelazycat/company-english-helper"))
