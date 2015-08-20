;; provide paths to needed binaries, starting with git

;; git paths
(setenv "PATH" (concat (getenv "PATH") ";c:\\Program Files (x86)\\Git\\bin"))
(setenv "PLINK_PROTOCOL" "ssh")

(setq exec-path (append exec-path '("c:/Program Files (x86)/Git/bin")))

;; mingw paths
(setenv "PATH" (concat (getenv "PATH") ";c:\\mingw_mine\\bin"))
(setq exec-path (append exec-path '("c:/mingw_mine/bin")))

;; Octave paths
(setenv "PATH" (concat (getenv "PATH") ";c:\\octave-4.0.0\\bin"))
(setq exec-path (append exec-path '("c:/octave-4.0.0/bin")))
