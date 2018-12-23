;;; private/my-cc/autoload.el -*- lexical-binding: t; -*-


;;;###autoload
(defun +my-python/enable-lsp()
  (unless pyvenv-virtual-env-name
    (pyvenv-activate "/home/xhcoding/Code/Python/.venv"))
  (lsp)
  (setq-local flycheck-checker 'python-pylint)
  )

;;;###autoload
(defun +my-python/restart-lsp-without-pyvenv()
  (interactive)
  (when pyvenv-virtual-env-name
    (pyvenv-deactivate)
    (lsp-restart-workspace)))
