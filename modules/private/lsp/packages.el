;; -*- no-byte-compile: t; -*-
;; lsp/packages.el

(package! lsp-mode)

(when EMACS26+
  (package! lsp-ui))

(when (featurep! :completion company)
  (package! company-lsp))

(when (featurep! :lang java)
  (package! lsp-intellij))

(when (featurep! :lang cc)
  (if IS-WINDOWS
      (package! cquery)
    (package! ccls)))

(when (featurep! :lang python)
  (package! lsp-python))

(package! lsp-javascript-typescript)
