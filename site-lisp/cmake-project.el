;;; cmake-project --- Create and build c/c++ project with cmake

;; Filename: cmake-project.el
;; Description: Create and build c/c++ project with cmake
;; Author: Yong Cheng <xhcoding@163.com>
;; Copyright (C) 2018, Yong Cheng, all right reserved
;; Created: 2018-08-07 08:16:00
;; Version: 0.1
;; Last-Update:
;; URL:
;; Keywords: cmake
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

;;; Reuqire

(require 'dired)

;;; Code:
;;

;;; Custom
(defgroup cmake-project nil
  "Create and build c/c++ project with cmake."
  :group 'applications
  :prefix "cp-")


(defcustom cp-cmake-minimum-version nil
  "CMake version."
  :group 'cmake-project
  :type 'string)

(defcustom cp-default-build-dir nil
  "CMake project default build directory."
  :group 'cmake-project
  :type 'string)

;;; Variable

(defvar cp-root-dir nil
  "CMake project root directory.")

(defvar cp-project-name nil
  "CMake project name.")

(defvar cp-build-dir "build"
  "CMake project build directory.")

(defvar cp-binary-dir "build/bin")

(defvar cp-root-cmakelists-path "CMakeLists.txt"
  "`CMakeLists.txt' path.")

(defvar cp-cmake-config-command "cmake -Bbuild -H."
  "Default cmake command.")

(defvar cp-cmake-cache-filename "CMakeCache.txt"
  "CMake cache filename.")

(defvar cp-cmake-compile-commands "compile_commands.json"
  "CMake compile commands filename.")

(defvar cp-default-run-terminal-buffer "eshell"
  "Run in terminal buffer.")

;;; Functions
(defun cp--get-cmake-version()
  "Get cmake installed version."
  (let ((version-str (shell-command-to-string "cmake --version")))
    (string-match "[1-9]\\.[0-9]\\{2\\}" version-str)
    (match-string 0 version-str)))

(defun cp--get-cmake-config-command ()
  "Get cmake config command."
  (format "cmake -B%s -H." cp-build-dir))

(defun cp--get-cmake-build-command()
  "Get cmake build command."
  (format "cmake --build %s" cp-build-dir))

(defun cp-insert-default-cmakelists-template (&optional version name)
  "Insert a default `CMakeLists.txt' template.
VERSION is require cmake minimum version.
NAME is project name."
  (let ((version (or version cp-cmake-minimum-version (cp--get-cmake-version)))
        (name    (or name cp-project-name)))
    (save-excursion
      (insert (concat
               (format "cmake_minimum_required(VERSION %s)" version)
               (format "\nset(PROJECT_NAME \"%s\")" name)
               (format "\nproject(${PROJECT_NAME})")
               (format "\nset(CMAKE_EXPORT_COMPILE_COMMANDS ON)")
               (format "\n\nadd_executable(main main.cpp)")
               )))))

(defun cp--init-path(root-dir)
  "Initialize useful path with ROOT-DIR."
  (setq cp-root-dir root-dir)
  (setq cp-project-name (file-name-nondirectory cp-root-dir))
  (setq cp-build-dir (or cp-build-dir cp-default-build-dir))
  (setq cp-root-cmakelists-path (expand-file-name cp-root-cmakelists-path cp-root-dir)))

(defun cp--create-symbol-link(src-dir tar-dir)
  (message "%s %s" src-dir tar-dir)
  (shell-command (format "ln -sf %s %s" src-dir tar-dir)))

(defun cp--build-path()
  (expand-file-name cp-build-dir cp-root-dir))

(defun cp--compile-commands-path()
  (expand-file-name cp-cmake-compile-commands (cp--build-path)))

(defun cp--create-empty-compile-commands()
  (with-temp-file (cp--compile-commands-path)))

(defun cp-create-new-project(root-dir)
  "Create a new CMake project at ROOT-DIR."
  (interactive "DRoot Directory:")
  (cp--init-path root-dir)
  (dired-create-directory (expand-file-name cp-build-dir cp-root-dir))
  (with-temp-file cp-root-cmakelists-path
    (cp-insert-default-cmakelists-template))
  (with-temp-file (expand-file-name "main.cpp" cp-root-dir)
    (insert "int main() {}"))
  (cp--create-empty-compile-commands)
  (cp--create-symbol-link
   (cp--compile-commands-path) (expand-file-name cp-cmake-compile-commands cp-root-dir))
  (find-file cp-root-cmakelists-path)
  (cp-cmake-config-project))



(defun cp--get-cmake-cache(dir)
  "Get `CMakeCache.txt'"
  (let ((path (expand-file-name cp-cmake-cache-filename dir)))
    (if (file-exists-p path)
        path
      nil)))

(defun cp--get-cmake-compile-commands(dir)
  "Get `compile_commands.json'"
  (let ((path (expand-file-name cp-cmake-compile-commands dir)))
    (if (file-exists-p path)
        path
      nil)))

(defun cp--parent-dir (dir)
  "Return DIR's parent dir."
  (file-name-directory (directory-file-name dir)))

(defun cp--in-project-dir(dir)
  "DIR is in current project."
  (if cp-root-dir
      (string-match (regexp-quote cp-root-dir) dir)
    nil))

(defun cp--get-root-dir(&optional dir)
  "Get project root dir."
  (let ((current-dir (or dir (file-name-directory (buffer-file-name))))
        (i 0)
        found
        )
    (if (cp--in-project-dir current-dir)
        cp-root-dir
      (progn
        (while (and (< i 16) (not found) (not (string-equal "/" current-dir)))
          (if (and (not (cp--get-cmake-cache current-dir))
                   (cp--get-cmake-compile-commands current-dir))
              (progn (setq cp-root-dir current-dir)
                     (setq found t))
            (setq current-dir (cp--parent-dir current-dir))
            )
          (setq i ( + i 1 ))
          )
        found))))


(defun cp-load-all()
  (interactive)
  (condition-case nil
      (cp--get-root-dir)
    (error nil)))


(defun cp-cmake-config-project()
  (interactive)
  (let ((compile-command (cp--get-cmake-config-command))
        (default-directory cp-root-dir))
    (call-interactively 'compile)))

(defun cp-cmake-build-project()
  (interactive)
  (let ((compile-command (cp--get-cmake-build-command))
        (default-directory cp-root-dir))
    (call-interactively 'compile)))


(defun cp--read-run-args(binary-dir &optional args)
  (list (let ((default-directory binary-dir))
          (find-file-read-args "Run file: " t))
        (if args
            (read-string "Args: "))))

(defun cp--binary-path()
  (expand-file-name cp-binary-dir cp-root-dir))

;;TODO: fix first start eshell
(defun cp-cmake-run-project-with-args(file args)
  (interactive (cp--read-run-args (cp--binary-path) t))
  (with-current-buffer cp-default-run-terminal-buffer
    (eshell-return-to-prompt)
    (insert (format "%s %s" file args))
    (eshell-send-input)
    ))



(provide 'cmake-project)


;;; cmake-project.el ends here
