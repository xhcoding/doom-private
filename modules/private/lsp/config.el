;;; private/lsp/config.el -*- lexical-binding: t; -*-

(def-package! spinner)

(def-package! lsp-mode
  :commands (lsp-register-client)
  :config
  (setq lsp-auto-guess-root t
        lsp-prefer-flymake nil
        lsp-session-file (expand-file-name ".lsp-session" doom-etc-dir)
        lsp-project-blacklist '("^/usr/")
        lsp-highlight-symbol-at-point nil))

(def-package! company-lsp
  :after lsp-mode
  :init
  (setq company-transformers nil)
  :config
  (set-company-backend! 'lsp-mode 'company-lsp)
  )

(def-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (set-lookup-handlers! 'lsp-ui-mode
    :definition #'lsp-ui-peek-find-definitions
    :references #'lsp-ui-peek-find-references)
  (setq
   lsp-ui-doc-max-height 20
   lsp-ui-doc-max-width 50
   lsp-ui-sideline-enable nil
   lsp-ui-peek-always-show t)
  (map!
   :map lsp-ui-peek-mode-map
   "h" #'lsp-ui-peek--select-prev-file
   "j" #'lsp-ui-peek--select-next
   "k" #'lsp-ui-peek--select-prev
   "l" #'lsp-ui-peek--select-next-file))


(def-package! dap-mode
  :after lsp-mode
  :config
  (setq dap--breakpoints-file (expand-file-name ".dap-breakpoints" doom-etc-dir))
  (dap-mode +1)
  (dap-ui-mode +1))


;; lsp client config

(load! "+ccls")


;; ms-python
(def-package! ms-python
  :config
  (add-hook 'python-mode-hook #'+my-python/enable-lsp)
  (setq ms-python-server-install-dir (expand-file-name "ms-pyls" doom-etc-dir))
  )

(def-package! dap-python
  :after (ms-python))

;; lsp-java
(def-package! lsp-java
  :config
  (add-hook 'java-mode-hook #'lsp)
  (setq lsp-java-server-install-dir (expand-file-name "lsp-java/server" doom-etc-dir)
        lsp-java-workspace-dir (expand-file-name "lsp-java/workspace" doom-etc-dir)))


(def-package! dap-java
  :after (lsp-java))

(def-package! lsp-java-treemacs
  :after (treemacs))
