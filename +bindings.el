;;; config/private/+bindings.el -*- lexical-binding: t; -*-
(map! [remap indent-region] #'+my/indent-or-format
      (:leader
        (:prefix "o"
          :desc "Blog"             :n  "B"    #'+my-blog/open-org-octopress
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
