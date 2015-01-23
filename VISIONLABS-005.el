;; provide paths to needed binaries, starting with git

;; git paths
(setenv "PATH" (concat (getenv "PATH") ";c:\\Program Files (x86)\\Git\\bin"))
(setenv "PATH" (concat (getenv "PATH") ";c:\\Qt\\5.3\\msvc2012_opengl\\bin"))
(setenv "PLINK_PROTOCOL" "ssh")
; (if (not (getenv "TERM")) (setenv "TERM" "msys"))

;; qt paths for lupdate
(setq exec-path (append exec-path '("c:/Program Files (x86)/Git/bin")))
(setq exec-path (append exec-path '("c:/Qt/5.3/msvc2012_opengl/bin")))

;; cmake support
(add-to-list 'load-path "c:/Program Files (x86)/CMake/share/cmake-3.1/editors/emacs/")
(require 'cmake-mode)
; Add cmake listfile names to the mode list.
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))
