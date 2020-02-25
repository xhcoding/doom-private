;; -*- no-byte-compile: t; -*-
;;; input/chinese/packages.el

(package! pyim)

(when (featurep! +rime)
    (package! liberime-config :ignore t))


(package! fcitx)
(package! ace-pinyin)
(package! pangu-spacing)
