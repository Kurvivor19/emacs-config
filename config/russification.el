;; Устанавливаем языковую среду
(set-language-environment 'Cyrillic-KOI8)

(set-input-method 'russian-computer)

(define-coding-system-alias 'windows-1251 'cp1251)
(define-coding-system-alias 'win-1251 'cp1251)

(setq default-buffer-file-coding-system 'cp1251)
(prefer-coding-system 'cp1251)

(set-terminal-coding-system 'cp1251)
(set-keyboard-coding-system 'cp1251)
(setq-default coding-system-for-read 'cp1251)
(setq-default coding-system-for-write nil)
(setq selection-coding-system 'cp1251)

(provide 'russification)
