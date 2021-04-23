;;; machine in G5e office
;; git paths
;(setenv "PATH" (concat "d:\\unix_env\\mingw\\bin;" (getenv "PATH")))
;(setenv "PATH" (concat "d:\\unix_env\\mingw\\bin\\core_perl;d:\\unix_env\\mingw\\bin\\site_perl;")(getenv "PATH"))
;(setenv "PATH" (concat "c:\\Program Files\\Git\\mingw64\\bin;"(getenv "PATH")))
; (push "d:/unix_env/mingw/bin" exec-path)
(push "c:/Program Files/Git/mingw64/bin" exec-path)

;; shell prompt fix
(setenv "PS1" "\\[\\e[32m\\]\\u@\\h \\[\\e[33m\\]\\w\\[\\e[0m\\]\\n\\$  ")

(defun transform-items (itemstring)
  (cl-flet ((alg (KEY ALIST ) (alist-get KEY ALIST nil nil 'equal)))
    (let ((json-object-type 'alist)
          (json-array-type 'list)
          (json-key-type 'string)
          (result (list "reward_items")))
      (let* ((items-sec (alg "items" (json-read-from-string itemstring)))
             (item-ids (alg "itemId" items-sec))
             (item-counts (alg "count" items-sec)))
        (loop for id in item-ids
              for count in item-counts
              collect (list (cons "id" id) (cons "count" count)) into inner-res
              finally return (nconc result (list inner-res)))))))

(defun transform-selected (begin end)
  (interactive "r")
  (atomic-change-group
    (let (;; Distinguish an empty objects from 'null'
          (json-null :json-null)
          ;; Ensure that ordering is maintained
          (json-object-type 'alist)
          (txt (delete-and-extract-region begin end)))
      (let* ((transformed (transform-items (concat "{" txt "}")))
             (json-encoding-pretty-print t)
             (prev-pos (point)))
        (insert (substring (json-encode transformed) 2 -2) "\n")
        (indent-region prev-pos (point))))))

(require 'squirrel-mode)
