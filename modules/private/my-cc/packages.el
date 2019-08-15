;; -*- no-byte-compile: t; -*-
;;; private/my-cc/packages.el

(package! google-c-style)

(package! my-work-c-style :ignore t)
(package! cmake-project :recipe (:fetcher github :repo "xhcoding/cmake-project"))
