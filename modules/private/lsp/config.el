;;; private/lsp/config.el -*- lexical-binding: t; -*-

(def-package! lsp-mode
  :commands (lsp-define-stdio-client)
  :config
  (setq lsp-project-blacklist '("^/usr/")
        lsp-highlight-symbol-at-point nil))

(def-package! company-lsp
  :after lsp-mode
  :config
  (set-company-backend! 'lsp-mode 'company-lsp))

(def-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (set-lookup-handlers! 'lsp-ui-mode
    :definition #'lsp-ui-peek-find-definitions
    :references #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-max-height 20
        lsp-ui-doc-max-width 50
        lsp-ui-sideline-ignore-duplicate t
        )
  (map!
   :map lsp-ui-peek-mode-map
   "h" #'lsp-ui-peek--select-prev-file
   "j" #'lsp-ui-peek--select-next
   "k" #'lsp-ui-peek--select-prev
   "l" #'lsp-ui-peek--select-next-file))
