;; -*- no-byte-compile: t; -*-
;;; private/my-cc/packages.el

(when (featurep! :private lsp)
  (if IS-WINDOWS
      (package! cquery)
    (package! ccls)))

(package! google-c-style)

(package! cmake-project :recipe (:fetcher github :repo "xhcoding/cmake-project"))
