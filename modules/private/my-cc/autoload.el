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
     (irony-mode +1))))

;;;###autoload
(defun +my-cc/cc-newline()
  "Insert semicolon at end of line, and `newline-and-indent'"
  (interactive)
  (end-of-line)
  (delete-trailing-whitespace)
  (when (not (equal (char-before) 59))
    (insert ";"))
  (newline-and-indent))

;;;autoload
(defun +my-cc/cc-jump-out-structure()
  "Jump to `)}]'"
  (interactive)
  (ignore-errors
    (search-forward-regexp "[])}]")))
