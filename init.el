(when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
		      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

 ;; cl - Common Lisp Extension
 (require 'cl)

 ;; Add Packages
 (defvar my/packages '(
		;; --- Auto-completion ---
		company
		;; --- Better Editor ---
		hungry-delete
		swiper
		counsel
		smartparens
		;; --- Major Mode ---
		js2-mode
		;; --- Minor Mode ---
		nodejs-repl
		exec-path-from-shell
		;; --- Themes ---
		monokai-theme
		;; solarized-theme
		monokai-theme

		hungry-delete
		smex
		swiper
		smartparens
		nodejs-repl
		exec-path-from-shell
	       

	       
		) "Default packages")

 (setq package-selected-packages my/packages)

 (defun my/packages-installed-p ()
     (loop for pkg in my/packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))

 (unless (my/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg my/packages)
       (when (not (package-installed-p pkg))
	 (package-install pkg))))

 ;; Find Executable Path on OS X
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))
;; 关闭菜单栏
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)
;; 显示行号
(global-linum-mode t)
;; 添加智能提示mode
(global-company-mode t)
(defun open-init-file()
    (interactive)
    (find-file "~/.emacs.d/init.el"))
    
;; 把函数open-init-file绑定到快捷键<F2>键上
(global-set-key (kbd "<f1>") 'open-init-file)

;; 把光标设定为条
(setq-default cursor-type 'bar)

;; 禁止备份
(setq make-backup-files nil)
;; 文档语法高亮
(require 'org)
(setq org-src-fontify-natively t)
;; 经常打开的文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(delete-selection-mode t)
;; 开启全屏打开
;; (setq initial-frame-alist (quote ((fullscreen . maximized))))
;; 开启括号提示
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
;; 显示行高亮
(global-hl-line-mode t)
(load-theme 'monokai t)

;; 饥饿删除
;;(require 'hungry-delete)
;;(global-hungry-delete-mode)

;; 查找
(require 'smartparens-config)
(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

;;js-node mac的配置
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
;; elpy---主角
(require 'elpy)
(elpy-enable)

;;js
(setq auto-mode-alist
      (append
       '(("\\.js'" . js2-mode))
       auto-mode-alist))

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-minimum-prefix-length 1)
 '(custom-safe-themes
   (quote
    ("a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" default)))
 '(package-selected-packages
   (quote
    (virtualenvwrapper company-jedi flycheck elpl elpy company hungry-delete swiper counsel smartparens js2-mode nodejs-repl exec-path-from-shell monokai-theme monokai-theme hungry-delete smex swiper smartparens))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; 添加仓库
(require 'package)
(setq package-archives '(
             ("gnu" . "http://elpa.gnu.org/packages/")
             ("melpa" . "http://melpa.milkbox.net/packages/")
))
(package-initialize)


;; 语法检查：flycheck
(add-hook 'after-init-hook #'global-flycheck-mode);全局开启
; 关闭flymake，使用flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules(delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; 虚拟环境： virtualenvwrapper
(require 'virtualenvwrapper)
(venv-initialize-interactive-shells)
(venv-initialize-eshell)
(setq venv-location "~/pyvirtualenv/");设置虚拟环境目录
;; 如果有多个目录：
;; (setq venv-location '("~/myvenv-1/"
;;                       "~/myvenv-2/"))
;; M-x venv-workon 打开虚拟环境
