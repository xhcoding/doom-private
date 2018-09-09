;;; private/my-cc/autoload.el -*- lexical-binding: t; -*-

;;;###autload
(defun +my-cc/enable-lsp()
  (if IS-WINDOWS
      (lsp-cquery-enable)
    (lsp-ccls-enable)))

;;;###autoload
(defun +my-cc/enable-lsp-or-irony ()
  "Enable lsp, otherwise enable irony"
  (interactive)
  (condition-case nil
      (+my-cc/enable-lsp)
    (user-error
     (if (featurep! +irony)
         (irony-mode +1)
       nil))))
