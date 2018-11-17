;; -*- no-byte-compile: t; -*-
;; lsp/packages.el

(package! lsp-mode)

(when EMACS26+
  (package! lsp-ui))

(when (featurep! :completion company)
  (package! company-lsp))

(when (featurep! :lang cc)
  (if IS-WINDOWS
      (package! cquery)
    (package! ccls)))
