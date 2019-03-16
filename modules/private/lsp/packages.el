;; -*- no-byte-compile: t; -*-
;; lsp/packages.el

(package! lsp-mode)

(when EMACS26+
  (package! lsp-ui))

(when (featurep! :completion company)
  (package! company-lsp))

(package! dap-mode)

(when (featurep! :lang cc)
  (package! ccls))

(when (featurep! :lang python)
  (package! ms-python))

(package! lsp-java)
