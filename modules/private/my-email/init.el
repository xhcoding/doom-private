;;; private/my-email/init.el -*- lexical-binding: t; -*-

(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))

(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-sent
      'wl-draft-kill
      'mail-send-hook))
