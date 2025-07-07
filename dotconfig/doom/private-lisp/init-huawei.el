;;; ../../dotfiles/Emacs/.config/doom/private-lisp/init-huawei.el -*- lexical-binding: t; -*-

(add-to-list 'auto-mode-alist '("\\.cce\\'" . c++-mode))

;; (when (featurep 'lsp-bridge)
;;   (setq lsp-bridge-remote-start-automatically t)
;;   (setq lsp-bridge-remote-python-file "~/.local/share/lsp-bridge/lsp-bridge.py")
;;   (setq lsp-bridge-remote-python-command "pypy3")
;;   (setq lsp-bridge-user-ssh-private-key "~/.ssh/id_rsa"))

(when (modulep! :tools lsp +eglot)
  (after! tramp
    (add-to-list 'tramp-remote-path "/root/llvm-project/build/bin")))
