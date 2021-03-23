;; .emacs.d/init.el

;; ===================================
;; MELPA Package Support
;; ===================================
;; Diz ao emacs para utilizar os pacotes
(require 'package)

;; Adiciona o MELPA na lista de fontes de pacotes
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Inicializa o sistema de empacotamento
(package-initialize)

;; Cria uma lista de pacote atual, se ele ainda não existir
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; Define uma lista de pacotes que seram instalados
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    elpy                            ;; Emacs Lisp python
    flycheck                        ;; Verificação de sintaxe
    blacken                         ;; Black formatting on save
    magit                           ;; Git integration
    material-theme                  ;; Tema escuro
    ;;doom-themes                   ;; Tema Doom
    expand-region                   ;; Ferramenta de seleçoã de trechos de código
    yafolding                       ;; Permite ocultar/exibir blocos de código
    yasnippet-classic-snippets      ;; Ferramenta de construção de trechos de código
    all-the-icons
    neotree                         ;; Janela de navegação em forma de árvore é aberta no lado esquerdo da tela
    )
  )

;; Scans the list in myPackages
;; Percorre a lista de pacotes e verifica qual desses não foi instalado
;; caso não tiver sido instalado antes, ele vai e instala.
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; ===================================
;; ---------- Preferences ------------
;; ===================================

(setq inhibit-startup-message t)    ;; Desativa a tela inicial do emacs
(global-linum-mode t)               ;; Exibe o número de linhas de cada buffer
(menu-bar-mode -1)                  ;; Desabilitando MenuBar
(tool-bar-mode -1)                  ;; Desabilitando ToolBar


;; ====================================
;; Python Preferences
;; ====================================
;; Enable elpy
(elpy-enable)
(setq elpy-rpc-python-command "python3")
;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;; Enable YASnippet
(yas-global-mode 1)
;; Permite visualizar identaçoã de blocos
(setq highlight-indentation-blank-lines t)
(set-face-background 'highlight-indentation-face "#373A40")
(set-face-background 'highlight-indentation-current-column-face "#949da8")
;; Enable yasfolging mode
(yafolding-mode 1)
;; Setando o interpretador do python para python3
(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")

;; ====================================
;; Themes
;; ====================================

(load-theme 'material t)            ;; Carrega e ativa o tema material
;; ====================================
;; Icons
;; ====================================
(require 'all-the-icons)

;; ====================================
;; Custom Shortcuts
;; ====================================
(global-set-key (kbd "C-x g") #'magit-status) ;; Atalho do 'magit-status'
(global-set-key (kbd "C-c t") #'ansi-term) ;; Atalho para acessar o terminal
(global-set-key (kbd "C-c k") 'yas-expand) ;; Atalho para completar blocos de código
(global-set-key (kbd "C-<enter>") 'elpy-goto-definition) ;; Atalho para inspecionar definição de um objeto
(global-set-key (kbd "C-S-<enter>") 'elpy-goto-definition-other-window) ;; Atalho para inspecionar definição de um objeto em outra janela
(global-set-key (kbd "C-=") 'er/expand-region) ;; Atalho para expandir a seleção de uma região
(global-set-key (kbd "C-x C-/") 'yafolding-toggle-element) ;; Atalho para ocultar ou exibir um bloco de código
;; ====================================
;; Window Shortcuts
;; ====================================


;; ====================================
;; File Explores Menu
;; ====================================
(require 'neotree) 
(global-set-key (kbd "C-x C-5") 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-window-fixed-size nil)

;; User-Defined init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (jedi material-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
