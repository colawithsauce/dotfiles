;;; init-telega.el -*- lexical-binding: t; -*-
(use-package! telega
  :commands (telega)
  :init
  ;; telega use images
  (defun my/telega-use-images ()
    (if (display-graphic-p)
        (setq telega-use-images t)
      (setq telega-use-images nil)))

  (add-hook 'server-after-make-frame-hook #'my/telega-use-images)

  :custom
  (telega-completing-read-function completing-read-function)
  (telega-use-images t)
  (telega-chat-fill-column 90)
  (telega-use-docker t)
  (telega-emoji-use-images nil)

  (telega-proxies '((:server "127.0.0.1" :port 12334 :enable t :type (:@type "proxyTypeSocks5"))))
  :config
  (require 'telega-mnz)
  (require 'telega-alert)
  (global-telega-mnz-mode 1)
  (telega-alert-mode 1)
  ;; 解决头像裂开的问题
  ;; (setq telega-avatar-workaround-gaps-for '(return t))

  (add-hook 'telega-chat-mode-hook (lambda () (electric-pair-local-mode -1)))

  (map! :map telega-chat-mode-map
        :desc "Input Emoji" :i "C-c C-e" #'emoji-search)

  ;; Disable user status image.
  ;; (advice-add 'telega-ins--user-emoji-status :around #'ignore)

  ;; 拉黑
  (defun my/telega-blocked-user-p (msg)
    (telega-msg-match-p msg '(sender (ids 802596156 ; Huli
                                          ))))
  (add-to-list 'telega-msg-ignore-predicates #'my/telega-blocked-user-p)

  ;; Nerd icons
  (setq telega-symbol-reply (nerd-icons-faicon "nf-fa-reply")
        telega-symbol-reply-quote (nerd-icons-faicon "nf-fa-reply_all")
        telega-symbol-forward (nerd-icons-mdicon "nf-md-comment_arrow_right_outline")
        telega-symbol-checkmark (nerd-icons-codicon "nf-cod-check")
        telega-symbol-heavy-checkmark (nerd-icons-codicon "nf-cod-check_all")))
