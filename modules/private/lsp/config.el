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
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-symbol nil
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-flycheck nil
        lsp-ui-sideline-show-code-actions nil
        )
  (map!
   :map lsp-ui-peek-mode-map
   "h" #'lsp-ui-peek--select-prev-file
   "j" #'lsp-ui-peek--select-next
   "k" #'lsp-ui-peek--select-prev
   "l" #'lsp-ui-peek--select-next-file))

;; lsp client config

(if IS-WINDOWS
    (load! "+cquery")
  (load! "+ccls"))

(def-package! lsp-intellij
  :disabled t
  :config
  (add-hook 'java-mode-hook #'lsp-intellij-enable))

(def-package! lsp-python
  :config
  (add-hook 'python-mode-hook #'lsp-python-enable))

(def-package! lsp-javascript-typescript
  :config
  (add-hook 'js-mode-hook #'lsp-javascript-typescript-enable))
