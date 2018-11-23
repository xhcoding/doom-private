;;; ms-python.el --- A lsp client for microsoft python language server.

;; Filename: ms-python.el
;; Description: A lsp client for microsoft python language server.
;; Author: Yong Cheng <xhcoding@163.com>
;; Copyright (C) 2018, Yong Cheng, all right reserved
;; Created: 2018-11-22 08:16:00
;; Version: 0.1
;; Last-Update:
;; URL: https://github.com/xhcoding/ms-python
;; Keywords: python
;; Compatibility: GNU Emacs 26.1

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:

;;; Require
(require 'lsp-mode)

;;; Code:
;;


;;; Custom
(defcustom ms-python-dir
  ""
  "Path of the microsoft python language server dir."
  :type 'directory
  :group 'ms-python)

(defcustom ms-python-database-dir
  ".ms-pyls"
  "Database directory."
  :type 'directory
  :group 'ms-python)

;;; Functions

(defun get-python-ver-and-syspath (workspace-root)
  "return list with pyver-string and json-encoded list of python search paths."
  (let ((python (executable-find python-shell-interpreter))
        (ver "import sys; print(f\"{sys.version_info[0]}.{sys.version_info[1]}\");")
        (sp (concat "import json; sys.path.insert(0, '" workspace-root "'); print(json.dumps(sys.path))")))
    (with-temp-buffer
      (call-process python nil t nil "-c" (concat ver sp))
      (subseq (split-string (buffer-string) "\n") 0 2))))

(defun ms-python-extra-init-params (workspace)
  (destructuring-bind (pyver pysyspath) (get-python-ver-and-syspath (lsp--workspace-root workspace))
    `(:interpreter (
                    :properties (
                                 :InterpreterPath ,(executable-find python-shell-interpreter)
                                 :DatabasePath ,(file-name-as-directory (expand-file-name ms-python-database-dir (lsp--workspace-root workspace)))
                                 :Version ,pyver))
                   ;; preferredFormat "markdown" or "plaintext"
                   ;; experiment to find what works best -- over here mostly plaintext
                   :displayOptions (
                                    :preferredFormat "plaintext"
                                    :trimDocumentationLines :json-false
                                    :maxDocumentationLineLength 0
                                    :trimDocumentationText :json-false
                                    :maxDocumentationTextLength 0)
                   :searchPaths ,(json-read-from-string pysyspath))))



(lsp-define-stdio-client lsp-python "python"
                         nil
                         `("dotnet" ,(concat ms-python-dir "Microsoft.Python.LanguageServer.dll"))
                         :extra-init-params #'ms-python-extra-init-params)

(provide 'ms-python)
