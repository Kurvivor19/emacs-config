;; Устанавливаем языковую среду
(set-language-environment 'Cyrillic-KOI8)

(set-input-method 'russian-computer)

(define-coding-system-alias 'windows-1251 'cp1251)
(define-coding-system-alias 'win-1251 'cp1251)

;; MS Windows clipboard is UTF-16LE.
(set-clipboard-coding-system 'utf-16le-dos)
;; Order is important here. If windows-1251 has higher priority than
;; utf-8 then utf-8 would note display correctly.
;; It works fine the other way around.
;; UTF-8 as default process coding system allows us to use cyrillic VC log.
(prefer-coding-system 'cp1251)
(prefer-coding-system 'utf-8)

;; Allows us to save russian file names.
(setq default-file-name-coding-system 'windows-1251)

;(set-terminal-coding-system 'cp866)
;(set-keyboard-coding-system 'cp1251)

; (setq selection-coding-system 'cp1251)

(provide 'russification)
