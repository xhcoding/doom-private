;;; config/private/+bindings.el -*- lexical-binding: t; -*-
(map! [remap indent-region] #'+my/indent-or-format
      :i "C-f" #'forward-char
      :i "C-b" #'backward-char
      :i "C-n" #'next-line
      :i "C-p" #'previous-line
      (:leader
        (:prefix "o"
          :desc "Blog"             :n  "B"    #'easy-hugo
          )
        (:desc "toggle" :prefix "t"
          :desc "Transparency"     :n  "T"    #'+my/toggle-transparency
          :desc "Auto save"        :n  "a"    #'+my/toggle-auto-save
          :desc "Comment "         :n  "c"    #'comment-line
          :desc "Cycle theme"      :n  "t"    #'+my/toggle-cycle-theme
          :desc "English Helper"   :n  "e"    #'toggle-company-english-helper
          )
        (:prefix "r"
          :desc "replace"          :n  "r"    #'vr/replace
          :desc "query replace"    :n  "R"    #'vr/query-replace)
        ))
