;;; private/my-blog/config.el -*- lexical-binding: t; -*-

(defvar +my-blog-root-dir
  "~/Blog/"
  "Blog root directory.")

(defvar +my-blog-img-dir
  (expand-file-name "images/" +my-blog-root-dir)
  "Blog's image directory.")

(defvar +my-blog-image-url
  "http://source.xhcoding.cn/images/")


(def-package! org-octopress
  :commands (org-octopress)
  :config
  (setq
   org-octopress-directory-top (expand-file-name "source" +my-blog-root-dir)
   org-octopress-directory-posts (expand-file-name "source/_posts" +my-blog-root-dir)
   org-octopress-directory-org-top +my-blog-root-dir
   org-octopress-directory-org-posts (expand-file-name "blog" +my-blog-root-dir)
   org-octopress-setup-file (expand-file-name "setupfile.org" +my-blog-root-dir)
   ))

(advice-add #'org-export-file-uri :before-until #'+my-blog*export-blog-image-url)
