;;; config/private/+org -*- lexical-binding: t; -*-


(after! org
  (setq org-ellipsis " ▼ "
        org-image-actual-width '(400)
        org-ditaa-jar-path (concat doom-etc-dir "ditaa.jar")
        org-agenda-files (list (concat +my-org-dir "gtd.org"))
        +org-default-notes-file (expand-file-name "inbox.org" +my-org-dir)
        +org-default-todo-file (expand-file-name "todo.org" +my-org-dir)
        )
  (setcar (nthcdr 0 org-emphasis-regexp-components) " \t('\"{[:nonascii:]")
  (setcar (nthcdr 1 org-emphasis-regexp-components) "- \t.,:!?;'\")}\\[[:nonascii:]")
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
  (org-element-update-syntax)

  ;; org-latex
  (setq org-use-sub-superscripts "{}"
        org-latex-compiler "xelatex"
        org-preview-latex-process-alist
        '((dvipng :programs
                  ("latex" "dvipng")
                  :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
                  (1.0 . 1.0)
                  :latex-compiler
                  ("latex -interaction nonstopmode -output-directory %o %f")
                  :image-converter
                  ("dvipng -fg %F -bg %B -D %D -T tight -o %O %f"))
          (dvisvgm :programs
                   ("latex" "dvisvgm")
                   :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :use-xcolor t :image-input-type "dvi" :image-output-type "svg" :image-size-adjust
                   (1.7 . 1.5)
                   :latex-compiler
                   ("latex -interaction nonstopmode -output-directory %o %f")
                   :image-converter
                   ("dvisvgm %f -n -b min -c %S -o %O"))
          (imagemagick :programs
                       ("latex" "convert" "gs")
                       :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :use-xcolor t :image-input-type "pdf" :image-output-type "png" :image-size-adjust
                       (1.0 . 1.0)
                       :latex-compiler
                       ("xelatex -interaction nonstopmode -output-directory %o %f")
                       :image-converter
                       ("convert -density %D -trim -antialias %f -quality 100 %O")))
        org-preview-latex-default-process 'imagemagick

        org-latex-classes
        '(("ctexart"
           "\\documentclass[UTF8,a4paper]{ctexart}"
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
           ("\\paragraph{%s}" . "\\paragraph*{%s}")
           ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
          ("ctexrep"
           "\\documentclass[UTF8,a4paper]{ctexrep}"
           ("\\part{%s}" . "\\part*{%s}")
           ("\\chapter{%s}" . "\\chapter*{%s}")
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
          ("ctexbook"
           "\\documentclass[UTF8,a4paper]{ctexbook}"
           ("\\part{%s}" . "\\part*{%s}")
           ("\\chapter{%s}" . "\\chapter*{%s}")
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
          ("beamer"
           "\\documentclass{beamer}
               \\usepackage[UTF8,a4paper]{ctex}"
           org-beamer-sectioning))
        org-latex-default-class "ctexart"
        )

  ;; org-capture
  (require 'org-protocol)
  (setq org-capture-templates `(
	                            ("P" "Protocol" entry (file+headline ,(expand-file-name "web.org" +my-org-dir) "Inbox")
	                             "* [[%:link]]\nSource: %u\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
	                            ("L" "Protocol Link" entry (file+headline ,(expand-file-name "web.org" +my-org-dir) "Inbox")
	                             "* %? [[%:link][%:description]] \nCaptured On: %U")
                                ("t" "Todo" entry
                                 (file+headline ,(expand-file-name "todo.org" +my-org-dir) "Inbox")
                                 "* TODO %?\n%i" :prepend t :kill-buffer t)
                                ))
  )
