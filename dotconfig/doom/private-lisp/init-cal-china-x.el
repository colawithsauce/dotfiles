;;; ../../dotfiles/Emacs/.config/doom/private-lisp/init-cal-china-x.el -*- lexical-binding: t; -*-

(with-eval-after-load 'calendar
  (use-package! cal-china-x
    :config
    (setq calendar-mark-holidays-flag t)
    (setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
    (setq cal-china-x-general-holidays '((holiday-lunar 4 15 "我农历生日")
                                         (holiday-lunar 10 1 "爷爷生日")
                                         (holiday-lunar 2 12 "奶奶生日")
                                         (holiday-lunar 8 18 "妹妹生日")
                                         (holiday-lunar 5 23 "爸爸生日&肖昕生日")
                                         (holiday-lunar 4 6 "妈妈生日")))
    (setq calendar-holidays
          (append cal-china-x-important-holidays
                  cal-china-x-general-holidays))))
