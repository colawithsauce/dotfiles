;;; init.el -- init my private lisp config.

(setq my/private-lisp-dir (file-name-concat doom-user-dir "private-lisp"))
(dolist (module '("telega" "huawei" "cal-china-x"))
  (load (file-name-concat my/private-lisp-dir (concat "init-" module ".el"))))

(require 'mlir-mode)
(require 'tablegen-mode)
(require 'llvm-mode)

(unless (or (featurep 'lsp-bridge)
            (modulep! :tools lsp +eglot))
  (require 'mlir-lsp-client)
  (load! "tablegen-lsp.el")
  (lsp-mlir-setup)
  (lsp-tblgen-setup))
