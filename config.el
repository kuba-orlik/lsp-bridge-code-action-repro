(setq package-enable-at-startup nil) ;; recommended in straight README
(setq straight-repository-branch "develop") ;; see https://github.com/org-roam/org-roam/issues/2361#issuecomment-1671601796

(setq comp-deferred-compilation t) ;; to enable JIT compilation (gccemacs). Disable due to some problems with mu4e. Maybe we can reenable it later
;; (setq straight-disable-byte-compilation 1)


(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(use-package yasnippet :straight t :defer t
  :config
  ;; this is where the snippets are saved. It's a good idea to put it in
  ;; a place where you can easily sync files with your other machines
  (setq yas-snippet-dirs '("~/.emacs.d/config/snippets"))
  (yas-global-mode)
  )

(use-package lsp-bridge
  :defer t
  :straight
  '(lsp-bridge
    :type git :host github :repo "manateelazycat/lsp-bridge"
    :files (:defaults "*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
    :build (:not compile))
  
  :bind (("M-." . lsp-bridge-find-def)
	 ("M-," . lsp-bridge-find-def-return)
	 ("C-M-." . lsp-bridge-peek)
	 ("C-c c a" . lsp-bridge-code-action)
	 ("M-?" . lsp-bridge-find-references)
	 ("C-c ! n" . lsp-bridge-diagnostic-jump-next)
	 ("C-c ! p" . lsp-bridge-diagnostic-jump-prev)
	 ("C-c c r" . lsp-bridge-rename)
	 ("C-h ." . lsp-bridge-popup-documentation)
	 ("C-h >" . lsp-bridge-show-documentation)
	 )
  :init
  (setq lsp-bridge-enable-log t)
  (setq lsp-bridge-python-command "python3")

  ;; otherwise it freezes emacs see https://github.com/manateelazycat/lsp-bridge/issues/711
  (setq lsp-bridge-code-action-enable-popup-menu nil)

  (setq  lsp-bridge-enable-completion-in-string t)
  
  :hook ((typescript-ts-mode js-ts-mode web-mode html-mode css-mode scss-mode json-mode yaml-mode sh-mode shell-script-mode bash-ts-mode dockerfile-mode markdown-mode qml-mode emacs-lisp-mode tsx-ts-mode) . lsp-bridge-mode)  

  )
