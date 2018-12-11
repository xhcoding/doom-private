;;; private/my-cc/autoload.el -*- lexical-binding: t; -*-


;;;###autoload
(defun +my-python/enable-lsp()
  (unless pyvenv-virtual-env-name
    (pyvenv-activate "/home/xhcoding/Code/Python/.venv"))
  (lsp)
  (setq-local flycheck-checker 'python-pylint)
  )
