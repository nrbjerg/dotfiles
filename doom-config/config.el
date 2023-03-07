;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq-default
 delete-by-moving-to-trash t
 window-combination-resize t
 x-stretch-cursor t)

(setq auto-save-default t)


(display-time-mode 1)                             ; Enable time in the mode-line

(unless (string-match-p "^Power N/A" (battery))   ; On laptops...
  (display-battery-mode 1))                       ; it's nice to know how much power you have

(global-subword-mode 1)                           ; Iterate through CamelCase words

;; NOTE: Disable colors on parenthesis
(after! cc-mode
  (remove-hook 'c-mode-common-hook #'rainbow-delimiters-mode))

(display-time-mode 1)

(global-subword-mode 1)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Martin Sig Nørbjerg"
      user-mail-address "mnarbj20@student.aau.dk")

;; SEC: FONTS
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 16 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font" :size 16)
      doom-big-font (font-spec :family "Iosevka Nerd Font" :size 24 :weight 'normal))

(after! doom-themes--colors
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))


(custom-set-faces!
  '(font-lock-function-name-face :slant italic)
  '(font-lock-comment-face :slant italic)
  '(font-lock-type-face :weight bold)
  '(font-lock-keyword-face :weight bold, :slant italic))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; SEC: THEMES
(setq doom-theme 'modified)
(map! :leader
      :desc "Load new theme"
      "h t" #'counsel-load-theme)

;; NOTE: ORG & LATEX
(after! org
  (setq org-directory "/Documents/org/"
        org-journal-dir "~/notes/journal/"
        org-journal-date-format "%a, %d. %b, %Y"
        org-journal-file-format "%d-%m-%Y.org"
        org-agenda-files '("~/.doom.d/agenda.org")))

;; for links in org-roam
(defadvice org-roam-insert (around append-if-in-evil-normal-mode activate compile)
  "If in evil normal mode and cursor is on a whitespace character, then go into
append mode first before inserting the link. This is to put the link after the
space rather than before."
  (let ((is-in-evil-normal-mode (and (bound-and-true-p evil-mode)
                                     (not (bound-and-true-p evil-insert-state-minor-mode))
                                     (looking-at "[[:blank:]]"))))
    (if (not is-in-evil-normal-mode)
        ad-do-it
      (evil-append 0)
      ad-do-it
      (evil-normal-state))))

(setq
  org-fancy-priorities-list '("[uni]" "[events]" "[misc]")
  org-priority-faces
    '((?A :foreground "#51afef" :weight bold)
      (?B :foreground "#51afef" :weight bold)
      (?C :foreground "#51afef" :weight bold)))

;; NOTE: org-roam-ui
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
    :config
     (setq org-roam-ui-sync-theme t
         org-roam-ui-follow t
         org-roam-ui-update-on-save t
         org-roam-ui-open-on-start t))

;; NOTE: CDLATEX
(map! :map cdlatex-mode-map :i "TAB" #'cdlatex-tab)

(setq cdlatex-math-symbol-alist
  '((?n ("\\cap"))
    (?N ("\\bigcap"))
    (?u ("\\cup" "\\uepsilon"))
    (?U ("\\bigcup" "\\Uepsilon"))
    (?{ ("\\subseteq" "\\subset"))
    (?E ("\\exists" "\\exists !"))
    (?: ("\\colon"))
    (?t ("\\to" "\\tau"))
    (?T ("\\mapsto" "\\mathcal{T}"))
    (?> ("\\implies"))
    (?< ("\\impliedby"))
    (?. ("\\ldots"))
    (?x ("\\times" "\\chi"))
    (?X ("\\varprod"))
    (?R ("\\perp"))
    (?| ("\\middle|"))
    (?c ("\\cdot" "\\circ"))
    (?C ("\\cdots"))))

(setq cdlatex-math-modify-alist
 '((?b "\\mathbb" nil t t nil)
   (?B "\\mathbf" nil t t nil)
   (?h "\\hat" nil t t nil)
   (?- "\\overline" nil t t nil)
   (?t "\\tilde" nil t t nil)))

;; NOTE: LINES
(setq display-line-numbers-type 'relative)
(map! :leader
      :desc "Toggle line numbers"
      "t t" #'toggle-truncate-lines)

;; NOTE: DIRED
(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file" "d v" #'dired-view-file)))

;; Make 'h' and 'l' go back and forward in dired. Much faster to navigate the directory structure!
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "R") 'dired-rename
  (kbd "T") 'dired-do-touch
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-up-directory)

;; If peep-dired is enabled, you will get image previews as you go up/down with 'j' and 'k'
(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

;; (add-hook 'python-mode-hook 'yapf-mode)
(after! lsp-python-ms
  (setq lsp-python-ms-executable (executable-find "python-language-server"))
  (set-lsp-priority! 'mspyls 1))

;; NOTE: Company stuff
(after! company
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 2))

(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

;; NOTE: DOOM MODELINE
(setq doom-modeline-icon t
      doom-modeline-major-mode-icon t
      doom-modeline-major-mode-color-icon nil
      doom-modeline-env-version nil
      doom-modeline-hud t
      doom-modeline--battery-status t)

(use-package lsp-mode :ensure t)

;;(add-hook 'haskell-mode-hook (lambda () (tree-sitter-hl-mode -1)))

;; NOTE: Treesitter config
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode))

(add-hook 'python-mode-hook #'tree-sitter-hl-mode)

(setq save-interprogram-paste-before-kill nil)

(after! 'haskell-mode
  setq lsp-haskell-formatting-provider "fourmolu")

;; NOTE: Custom latex setup
(add-hook 'LaTeX-mode-hook (lambda () (rainbow-delimiters-mode nil)))
(setq +latex-viewers '(pdf-tools))

;; MODIFIED FROM https://tecosaur.github.io/emacs-config/config.html#latex
(add-hook 'LaTeX-mode-hook (lambda ()
                             (TeX-fold-mode 1)))
(after! latex
  (setq TeX-fold-math-spec-list `(
                                  ;; missing / better symbols
                                  ("≤" ("le"))
                                  ("≥" ("ge"))
                                  ("≠" ("ne"))
                                  ;; private macros
                                  ("R" ("R"))
                                  ("F" ("F"))
                                  ("N" ("N"))
                                  ("Z" ("Z"))
                                  ("Q" ("Q"))
                                  ("C" ("C"))
                                  ("P" ("P"))
                                  ("H" ("H"))
                                  ("E" ("E")) ;; TODO: Add greek letters
                                  ("|{1}|" ("abs"))
                                  ("∥{1}∥" ("norm"))
                                  ("⇒" ("implies"))
                                  ("∊" ("in"))
                                  ("∀" ("forall"))
                                  ("∃" ("exists"))
                                  ("⌊{1}⌋" ("floor"))
                                  ("⌈{1}⌉" ("ceil"))
                                  ("𝑑{1}/𝑑{2}" ("dv"))
                                  ("𝛛{1}/𝛛{2}" ("pdv"))
                                  ("𝛛" ("partial"))
                                  ("\'{1}\'" ("cite"))
                                  ("(\'{1}\')" ("citep"))
                                  ("!{1}!" ("textbf"))
                                  ("\"{1}\"" ("text"))
                                  ("-" ("item"))
                                  ("(mod {1})" ("pmod"))
                                  ("⟨{1}⟩" ("gen"))
                                  ;; Left and right parenthesis that matches each other
                                  ;;("(" ("\left("))
                                  ;;(")" ("\right)"))
                                  ;;("[" ("\left["))
                                  ;;("]" ("\right]"))
                                  ("f[{1}]" ("footnote"))
                                  ("r[{1}]" ("ref"))
                                  ("r({1})" ("eqref"))
                                  ("l[{1}]" ("label"))
                                  ("00" ("infty")) ;; The unicode symbol is way to hard to read for me
                                  )))
(setq
 ;; Do cache: I have relatively long compilation times
 preview-auto-cache-preamble t
 ;; Don't raise/lower super/subscripts
 font-latex-fontify-script nil)

(defun compile-latex nil (interactive)
  """ Checks if there is a master in the project dir
      & compiles it if one is pressent """
  (let ((path (--first
                (file-exists-p it)
                (--map (concat (projectile-project-root) it)
                        venv-dirlookup-names)))))
    (let ((default-directory "path")) (shell-command "latexmk master.tex")))

(global-set-key (kbd "C-c c") 'compile-latex)

;; TODO: Create a proper keymap (map! :map latex-mode-map "C-c c" #'compile-latex)

(defun fold-latex nil
  "Folds the current latex buffer "
  (if (eq major-mode 'latex-mode)
      (run-with-idle-timer 0 nil 'TeX-fold-buffer)))
 ;; (when (eq major-mode 'latex-mode)
 ;;   run))

(latex-preview-pane-enable)

(map!
 :map LaTeX-mode-map
 :localleader
 :desc "View" "v" #'TeX-view)

(add-hook 'after-save-hook #'fold-latex)

;; NOTE: PDF VIEW
(use-package pdf-view
  :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
  :hook (pdf-tools-enabled . hide-mode-line-mode)
  :config
  (setq pdf-view-midnight-colors '("#bbc2cf" . "#21242b")))

(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

;;(add-hook 'LaTeX-mode-hook 'hl-todo-mode)

;; NOTE Emails (sync)
(setq mu4e-get-mail-command "mbsync gmail"
      ;; get emails and index every 5 minutes
      mu4e-update-interval 300
      ;; send emails with format=flowed
      mu4e-compose-format-flowed t
      ;; no need to run cleanup after indexing for gmail
      mu4e-index-cleanup nil
      mu4e-index-lazy-check t
      ;; more sensible date format
      mu4e-headers-date-format "%d.%m.%y")

;; NOTE: MU4E
(use-package mu4e
  :ensure nil
  :defer 5
  :load-path "/usr/share/emacs/site-lisp/mue4/"
  :config
  (require 'org-mu4e)

  ;; refresh mbsync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/Mail/")
  ;; use pass to store passwords
  ;; file auth looks for is ~/.password-store/<smtp.host.tld>:<port>/<name>
  (auth-source-pass-enable)
  (setq auth-sources '(password-store))
  (setq auth-source-debug t)
  (setq auth-source-do-cache nil)
  ;; no reply to self
  (setq mu4e-compose-dont-reply-to-self t)
  (setq mu4e-compose-keep-self-cc nil)
  ;; moving messages renames files to avoid errors
  (setq mu4e-change-filenames-when-moving t)
  ;; Configure the function to use for sending mail
  (setq message-send-mail-function 'smtpmail-send-it)
  ;; Display options
  (setq mu4e-view-show-images t)
  (setq mu4e-view-show-addresses 't)
  ;; Composing mail
  (setq mu4e-compose-dont-reply-to-self t)
  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t)
  ;; Don't ask for a 'context' upon opening mu4e
  (setq mu4e-context-policy 'pick-first)
  ;; Don't ask to quit... why is this the default?
  (setq mu4e-confirm-quit nil)

  ;; Set up contexts for email accounts
  (setq mu4e-contexts
        (list
         (make-mu4e-context
          :name "uni"
          :match-func
      (lambda (msg)
            (when msg
              (string-prefix-p "/uni" (mu4e-message-field msg :maildir))))
          :vars `((user-mail-address . "mnarbj20@student.aau.dk")
                  (user-full-name    . "Martin Sig Nørbjerg")
                  (smtpmail-smtp-server  . "smtp.aau.dk")
                  (smtpmail-smtp-service . "587")
                  (smtpmail-stream-type  . ssl)
                  (smtpmail-smtp-user . "mnarbj20@student.aau.dk")
                  (mu4e-compose-signature . "Best Regards\n\nMartin")
                  (mu4e-drafts-folder  . "/Drafts")
                  (mu4e-sent-folder  . "/Sent")
                  (mu4e-refile-folder  . "/Refile")
                  (mu4e-trash-folder  . "/Trash")))))

  (setq m/mu4e-inbox-query
        "(maildir:/uni/Inbox) AND flag:unread")
  (defun m/go-to-inbox ()
    (interactive)
    (mu4e-headers-search m/mu4e-inbox-query))
  ;; start mu4e
  (mu4e t))

;; NOTE: Evaluate elisp
(map! :leader
      (:prefix ("e". "evaluate/ERC/EWW")
       :desc "Evaluate elisp in buffer" "b" #'eval-buffer
       :desc "Evaluate defun" "d" #'eval-defun
       :desc "Evaluate elisp expression" "e" #'eval-expression
       :desc "Evaluate last sexpression" "l" #'eval-last-sexp
       :desc "Evaluate elisp in region" "r" #'eval-region))

(map! :leader
      (:prefix ("=" . "open file")
       :desc "Edit org agenda" "a" #'(lambda () (interactive) (find-file "~/.doom.d/agenda.org"))
       :desc "Edit doom config.el" "c" #'(lambda () (interactive) (find-file "~/.doom.d/config.el"))
       :desc "Edit doom init.el" "i" #'(lambda () (interactive) (find-file "~/.doom.d/init.el"))
       :desc "Edit doom packages.el" "p" #'(lambda () (interactive) (find-file "~/.doom.d/packages.el"))
       :desc "Edit theme modified.el" "m" #'(lambda () (interactive) (find-file "~/.doom.d/themes/modified-theme.el"))
       :desc "Edit .zshrc" "z" #'(lambda () (interactive) (find-file "~/.zshrc"))
       :desc "Edit i3 config" "w" #'(lambda () (interactive) (find-file "~/.config/i3/config"))
       :desc "Edit polybar config" "b" #'(lambda () (interactive) (find-file "~/.config/polybar/config"))
       :desc "Edit nixos config" "n" #'(lambda () (interactive) (find-file "/etc/nixos/configuration.nix"))
       :desc "Edit todo" "t" #'(lambda () (interactive) (find-file "~/todo.org"))))

;; SEC: Chance todo highlights, these work with the modified theme / doom one
(after! hl-todo
  (setq hl-todo-keyword-faces
	'(("TODO"   . "#98be65")
	  ("TEST"  . "#ecbe7b")
	  ("FIXME"  . "#e36d76")
	  ("NOTE"  . "#bbc2cf")
          ("SEC" . "#bbc2cf")
	  ("REF" . "#bbc2cf"))))

