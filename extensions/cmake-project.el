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

(require 'cl)
(require 'dired)
;;; Code:
;;

;;; Custom
(defgroup cmake-project nil
  "Manage c/c++ project with cmake."
  :group 'applications
  :prefix "cp-")

(defcustom cp-project-root-files
  '("CMakeLists.txt"    ;Cmake project file
    )
  "A list of files considered to mark the root of a cmake project."
  :group 'cmake-project
  :type '(repeat string))

(defcustom cp-cmake-minimum-version "3.7"
  "Required Cmake minimum version."
  :group 'cmake-project
  :type 'string)

(defcustom cp-cmake-build-type "Debug"
  "Specifies the build type on single-configuration generators."
  :group 'cmake-project
  :type 'string
  :options '("Debug" "Release" "RelWithDebInfo" "MinSizeRel"))


(defcustom cp-project-build-directory "build"
  "A path relative project root path, which CMake project default build."
  :group 'cmake-project
  :type 'string)

(defcustom cp-project-template-function 'cp-project-gen-default-template
  "A function generated `CMakeLists.txt' template."
  :group 'cmake-project
  :type 'function)

;;; Variable

(defvar cp-project-root-cache nil
  "Cached value of function `cp-project-root'.")

(defvar cp-build-dir "build"
  "CMake project build directory.")

(defvar cp-binary-dir "build/bin")

(defvar cp-root-cmakelists-path "CMakeLists.txt"
  "`CMakeLists.txt' path.")

(defvar cp-cmake-config-command "cmake -Bbuild -H."
  "Default cmake command.")

(defvar cp-cmake-cache-filename "CMakeCache.txt"
  "CMake cache filename.")

(defvar cp-root-file "compile_commands.json"
  "CMake compile commands filename.")

(defvar cp-default-run-terminal-buffer "eshell"
  "Run in terminal buffer.")

(defvar cp-default-open-terminal '+eshell/open-popup)

;;; Functions
(defun cp-parent(path)
  "Return the parent directory of PATH.
PATH may be a file or directory and directory paths end with a slash."
  (directory-file-name (file-name-directory (directory-file-name (expand-file-name path)))))


(defun cp-project-root(dir)
  "Identify a project root in DIR by recurring top-down search for files in `cp-project-root-files'"
  (if (and cp-project-root-cache (string-match (regexp-quote cp-project-root-cache) dir))
      cp-project-root-cache
    (setq cp-project-root-cache
          (cl-some
           (lambda(f)
             (locate-dominating-file
              dir
              (lambda (dir)
                (and (file-exists-p (expand-file-name f dir))
                     (or (string-match locate-dominating-stop-dir-regexp (cp-parent dir))
                         (not (file-exists-p (expand-file-name f (cp-parent dir)))))))))
           cp-project-root-files))))

;;;TODO: Improve
(defun cp-project-gen-default-template()
  "Generate a default `CMakeLists.txt' template"
  (save-excursion
    (concat
     (format "cmake_minimum_required(VERSION %s)" cp-cmake-minimum-version)
     (format "\nset(PROJECT_NAME \"%s\")" (file-name-nondirectory (directory-file-name cp-project-root-cache)))
     (format "\nproject(${PROJECT_NAME})")
     (format "\nset(CMAKE_EXPORT_COMPILE_COMMANDS ON)")
     )))

;;;TODO: add cp-after-create-new-project-hook
(defun cp-project-create-new-project(dir)
  "Create a new project in DIR.
TEMPLATE is a CMakeLists.txt template. IF it is `nil', use `cp-project-gen-default-template'
instead.TEMPLATE can also be a function without argument and returning a string."
  (interactive "DDirectory: ")
  (setq cp-project-root-cache dir)
  (dired-create-directory cp-project-root-cache)
  (condition-case nil
      (progn
        (let ((file (expand-file-name "CMakeLists.txt"  cp-project-root-cache)))
          (with-temp-file  file
            (insert (funcall cp-project-template-function)))
          (find-file file)))
    (error
     (dired-delete-file cp-project-root-cache 'always)
     (setq cp-project-root-cache nil)
     (message "Create project failed!"))))

(defun cp-project-gen-project()
  "Generate project."
  (interactive)
  (let ((default-directory cp-project-root-cache)
        (compile-command))
    (setq compile-command
          (format "cmake -B%s -H." cp-project-build-directory))
    (call-interactively 'compile)))

(defun cp-project-cleanup-gen()
  "Clean up build directory."
  (interactive)
  (when (yes-or-no-p (format "Delete %s?" cp-project-build-directory))
    (dired-delete-file cp-project-build-directory 'always)))

(defun cp-project-build-project()
  "Build project."
  (interactive)
  (let ((compile-command)
        (default-directory cp-project-root-cache))
    (setq compile-command
          (format "cmake --build %s" cp-project-build-directory))
    (call-interactively 'compile)))

;;TODO: imporve run project
(defun cp-project-run(file &optional args)
  (interactive
   (list
    (let ((default-directory (or cp-project-root-cache default-directory)))
      (car (find-file-read-args "File: " t)))
    (read-from-minibuffer "Args: ")))
  (with-current-buffer (or (get-buffer eshell-buffer-name) (eshell))
    ;; eshell-return-to-prompt has beginning of buffer error
    (eshell-return-to-prompt)
    (insert (format "%s %s" file args))
    (eshell-send-input)))


(defun cp-project-refresh()
  (interactive)
  (condition-case nil
      (cp-project-root default-directory)
    (error (message "project refresh failed"))))

(provide 'cmake-project)


;;; cmake-project.el ends here
