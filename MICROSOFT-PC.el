;; provide paths to needed binaries, starting with git

;; git paths
(setenv "PATH" (concat (getenv "PATH") ";c:\\Program Files (x86)\\Git\\bin"))
(setenv "PLINK_PROTOCOL" "ssh")
(setenv "GIT_ASKPASS" "git-gui--askpass")

(setq exec-path (append exec-path '("c:/Program Files (x86)/Git/bin")))

;; mingw paths
(setenv "PATH" (concat "c:\\mingw_mine\\bin;" (getenv "PATH")))
(setq exec-path (append exec-path '("c:/mingw_mine/bin")))

;; Octave paths
(setenv "PATH" (concat (getenv "PATH") ";c:\\octave-4.0.0\\bin"))
(setq exec-path (append exec-path '("c:/octave-4.0.0/bin")))

;; pandoc paths
(setenv "PATH" (concat (getenv "PATH") ";c:\\Users\\Ivan\\AppData\\Local\\Pandoc"))
(setq exec-path (append exec-path '("c:/Users/Ivan/AppData/Local/Pandoc")))

;; tramp setup
(setq tramp-default-method "pscp")
;; putty paths
(setenv "PATH" (concat (getenv "PATH") ";c:\\Program Files (x86)\\PuTTY"))
(setq exec-path (append exec-path '("c:/Program Files (x86)/PuTTY")))

;; aspell setup
(setq
 ispell-russian-dictionary "russian"
 ispell-english-dictionary "english")

(custom-set-variables
  ;; i like aspell, and you?
 '(ispell-program-name "aspell")

; my dictionary-alist, using for redefinition russian dictionary
 '(ispell-dictionary-alist
   '(("russian"  ;; Russian
      "\\cy"
      "\\Cy" 
      "[-]"
      nil
      ("-C" "-d" "ru-yeyo.multi")
      nil utf-8)
     ("english"                       ; English
      "[a-zA-Z]"
      "[^a-zA-Z]"
      "[']"
      nil
      ("-d" "en_GB.multi" "--add-extra-dicts=en_GB-variant_1.multi")
      nil iso-8859-1)
     (nil ;; Default
      "[A-Za-z]"
      "[^A-Za-z]"
      "[']"
      nil
      ("-C")
      nil iso-8859-1)))
 '(flyspell-default-dictionary ispell-russian-dictionary)
 '(ispell-dictionary ispell-english-dictionary)
 '(ispell-local-dictionary ispell-russian-dictionary)
 '(ispell-extra-args '("--sug-mode=ultra" "--prefix=c:/mingw_mine")))

(require 'russification)

;; for info-mode
(add-hook 'Info-mode-hook (lambda () (setq coding-system-for-read 'utf-8)))
(add-hook 'org-mode-hook (lambda ()
                           (make-local-variable 'coding-system-for-read)
                           (make-local-variable 'coding-system-for-write)
                           (setq coding-system-for-read 'utf-8-dos)
                           (setq coding-system-for-write 'utf-8)))

;; add function for starting a msys shell
(defun msys-shell ()
  "Run (shell) with explicit-shell-file-name set to sh.exe from msys"
  (interactive)
  (let ((explicit-shell-file-name "c:/msys-w32/1.0/bin/sh.exe"))
    (setenv "MSYSTEM" "MSYS")
    (setenv "MSYSCON" "sh.exe")
    (call-interactively 'shell)))

;; explicitrly specify names of dlls for libjpeg and gnutls
(defun krv/sublist_append (listvar sym newel)
  "Append newel to the sublist of listvar that starts with sym"
  (let ((elem (find sym listvar :key 'car)))
    (if elem
        (setcdr (last elem)
                (list newel)))))

(krv/sublist_append dynamic-library-alist 'jpeg "libjpeg-62.dll")
(krv/sublist_append dynamic-library-alist 'gnutls "libgnutls-30.dll")

;; set gnutls trustfile
(require 'gnutls)
(setq gnutls-trustfiles (append gnutls-trustfiles
                                `(,(concat dotfiles-dir "/config/cacert.pem"))
                                `(,(concat dotfiles-dir "/config/ca-bundle.crt"))))

;; setup grep usage
(grep-apply-setting 'grep-command "\"c:\\Program Files (x86)\\Git\\bin\\grep.exe\" -nH -e")

;; parifinder-mode
(add-to-list 'load-path "d:/parifinder/parinfer-mode")
(require 'parinfer-mode)
(add-hook 'emacs-lisp-mode-hook 'parinfer-mode)
