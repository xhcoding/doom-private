;; -*- no-byte-compile: t; -*-
;;; private/my-lang/packages.el


(package! ccls :recipe (:fetcher github :repo "MaskRay/emacs-ccls"))

(package! google-c-style)

(package! cmake-project :ignore t)

(package! srefactor)

(package! lsp-python)

(package! lsp-java )

(package! matlab-mode)
