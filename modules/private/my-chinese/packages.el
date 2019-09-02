;; -*- no-byte-compile: t; -*-
;;; input/chinese/packages.el

(package! pyim)
(if (featurep! +rime)
    (package! liberime-config
      :recipe (:host github
                        :repo "xhcoding/liberime"
                        :files ("liberime-config.el" "src" "CMakeLists.txt" "Makefile"))))
(package! fcitx)
(package! ace-pinyin)
(package! pangu-spacing)
