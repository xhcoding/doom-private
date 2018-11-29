;;; private/my-cc/autoload.el -*- lexical-binding: t; -*-


;;;###autoload
(defun +my-cc/gcc-toolchain()
  (with-temp-buffer
    (insert (shell-command-to-string "gcc -v"))
    (beginning-of-buffer)
    (search-forward-regexp "--prefix=\\(/\\w+\\)")
    (buffer-substring (match-beginning 1) (match-end 1))
    ))

;;;###autoload
(defun +my-cc/enable-lsp-or-irony ()
  "Enable lsp, otherwise enable irony"
  (interactive)
  (condition-case nil
      (lsp-ccls-enable)
    (user-error
     (if (featurep! :lang cc +irony)
         (irony-mode +1)
       nil))))


;;;###autoload
(defvar +ccls-path-mappings [])

;;;###autoload
(defvar +ccls-initial-blacklist [])

;;;###autoload
(defun +my-python/enable-lsp()
  (unless pyvenv-virtual-env-name
    (pyvenv-activate "/home/xhcoding/Code/Python/.venv"))
  (lsp-ms-python-enable)
  (setq-local flycheck-checker 'python-pylint)
  )
