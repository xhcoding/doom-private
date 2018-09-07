;; -*- no-byte-compile: t; -*-
;;; private/my-cc/packages.el

(when (featurep! :private lsp)
  (if IS-WINDOWS
      (package! cquery)
    (package! ccls)))

(package! google-c-style)

(package! cmake-project :ignore t)
