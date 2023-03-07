;;; themes/graphite-theme.el -*- lexical-binding: t; -*-
;;; zaiste-theme.el
(require 'doom-themes)

(defgroup graphite-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(def-doom-theme graphite
  "A light theme inspired by Bluloco"

  ;; name        default   256       16
  ((bg         '("#2c2c2c" nil       nil            ))
   (bg-alt     '("#343434" nil       nil            ))
   (base0      '("#101010" "black"   "black"        ))
   (base1      '("#303030" "#1e1e1e" "brightblack"  ))
   (base2      '("#656565" "#2e2e2e" "brightblack"  ))
   (base3      '("#9c9c9c" "#424242" "brightblack"  ))
   (base4      '("#a0a0a0" "#9ca0a4" "brightblack"  ))
   (base5      '("#b0b0b0" "#c6c7c7" "brightblack"  ))
   (base6      '("#c5c5c5" "#dfdfdf" "brightblack"  ))
   (base7      '("#dfdfdf" "#e7e7e7" "brightblack"  ))
   (base8      '("#f5f5f5" "#efefef" "white"        ))
   (fg         '("#f5f5f5" "#424242" "black"        ))
   (fg-alt     '("#dfdfdf" "#c7c7c7" "brightblack"  ))

   (grey       '("#a0a1a7" "#a0a1a7" "brightblack"  ))
   (red        '("#f97a7b" "#2e2e2e" "brightblack"  ))
   (orange     '("#c5c5c5" "#dfdfdf" "brightblack"  ))
   ;;(green      '("#c5c5c5" "#dfdfdf" "brightblack"  ))
   (green      '("#70955b" "#50a14f" "green"        ))
   (teal       '("#4db5bd" "#44b9b1" "brightgreen"  ))
   (yellow     '("#8c8c8c" "#424242" "brightblack"  ))
   (blue       '("#6ba4e7" "#0098dd" "brightblue"   ))
   (dark-blue  '("#c5c5c5" "#dfdfdf" "brightblack"  ))
   (magenta    '("#a0a0a0" "#9ca0a4" "brightblack"  ))
   (violet     '("#8c8c8c" "#424242" "brightblack"  ))
   (cyan       '("#c5c5c5" "#dfdfdf" "brightblack"  ))
   (dark-cyan  '("#dfdfdf" "#e7e7e7" "brightblack"  ))

   (highlight      blue)
   (vertical-bar   base7)
   (selection      blue)
   (builtin        base4)
   (comments       fg-alt)
   (doc-comments   (doom-lighten comments 0.15))
   (constants      base4)
   (functions      red)
   (keywords       blue)
   (methods        base4)
   (operators      base4)
   (type           green)
   (strings        fg)
   (variables      base8)
   (numbers        base8)
   (region         blue)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   (modeline-fg     bg)
   (modeline-fg-alt bg-alt)
   (modeline-battery-fg bg)

   (modeline-bg base8)
   (modeline-bg-l fg)
   (modeline-bg-inactive base7)
   (modeline-bg-inactive-l `(,(doom-darken (car bg-alt) 0.05) ,@(cdr base1))))


  ((font-lock-comment-face
    :foreground comments
    :slant 'italic)
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments
    :weight 'regular)

   ((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground base8)

   (doom-modeline-bar :background highlight)
   (doom-modeline-project-dir :foreground bg-alt :weight 'bold)
   (doom-modeline-buffer-file :weight 'regular)

   (mode-line :background modeline-bg :foreground modeline-fg)
   (mode-line-inactive :background modeline-bg-inactive :foreground modeline-fg-alt)
   (mode-line-emphasis :foreground highlight)

   (magit-blame-heading :foreground orange :background bg-alt)
   (magit-diff-removed :foreground (doom-darken red 0.2) :background (doom-blend red bg 0.1))
   (magit-diff-removed-highlight :foreground red :background (doom-blend red bg 0.2) :bold bold)

   (evil-ex-lazy-highlight :background bg-alt)

   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   (markdown-markup-face     :foreground base5)
   (markdown-header-face     :inherit 'bold :foreground blue)
   (markdown-code-face       :background base1)
   (mmm-default-submode-face :background base1)

   (org-block            :background base0)
   (org-level-1          :foreground base8 :weight 'bold :height 1.25)
   (org-level-2          :foreground base6 :weight 'bold :height 1.1)
   (org-level-3          :foreground base5 :bold bold :height 1.0)
   (org-level-4          :foreground base4 :bold bold :height 1.0)
   (org-ellipsis         :underline nil :background bg-alt     :foreground grey)
   (org-quote            :background base1)
   (org-checkbox-statistics-done :foreground base2 :weight 'normal)
   (org-done nil)
   (org-done :foreground green :weight 'normal)
   (org-headline-done :foreground base3 :weight 'normal :strike-through t)
   (org-date :foreground orange)
   (org-code :foreground dark-blue)
   (org-special-keyword :foreground base8 :underline t)
   (org-document-title :foreground base8 :weight 'bold :height 1.5)
   (org-document-info-keyword :foreground base4 :height 0.75)
   (org-block-begin-line :foreground base4 :height 0.65)
   (org-meta-line :foreground base4 :height 0.65)
   (org-list-dt :foreground magenta)

   (org-todo-keyword-faces
    '(("TODO" :foreground "#7c7c75" :weight normal :underline t)
      ("WAITING" :foreground "#9f7efe" :weight normal :underline t)
      ("INPROGRESS" :foreground "#0098dd" :weight normal :underline t)
      ("DONE" :foreground "#50a14f" :weight normal :underline t)
      ("CANCELLED" :foreground "#ff6480" :weight normal :underline t)))

   (org-priority-faces '((65 :foreground "#e45649")
                         (66 :foreground "#da8548")
                         (67 :foreground "#0098dd")))

   (helm-candidate-number :background blue :foreground bg)

   (web-mode-current-element-highlight-face :background dark-blue :foreground bg)

   (wgrep-face :background base1)

   (ediff-current-diff-A        :foreground red   :background (doom-lighten red 0.8))
   (ediff-current-diff-B        :foreground green :background (doom-lighten green 0.8))
   (ediff-current-diff-C        :foreground blue  :background (doom-lighten blue 0.8))
   (ediff-current-diff-Ancestor :foreground teal  :background (doom-lighten teal 0.8))

   (tooltip :background base1 :foreground fg)

   (ivy-posframe :background base0)

   (lsp-ui-doc-background      :background base0)
   (lsp-face-highlight-read    :background (doom-blend red bg 0.3))
   (lsp-face-highlight-textual :inherit 'lsp-face-highlight-read)
   (lsp-face-highlight-write   :inherit 'lsp-face-highlight-read)


   )

  ;; --- extra variables ---------------------
  ;;()
  )

(after! org
  (setq
   org-bullets-bullet-list '("⁖")
   org-ellipsis " ... "
   org-todo-keyword-faces
   '(("TODO" :foreground "#7c7c75" :weight normal :underline t)
     ("WAITING" :foreground "#9f7efe" :weight normal :underline t)
     ("INPROGRESS" :foreground "#0098dd" :weight normal :underline t)
     ("DONE" :foreground "#50a14f" :weight normal :underline t)
     ("CANCELLED" :foreground "#ff6480" :weight normal :underline t))
   org-priority-faces '((65 :foreground "#e45649")
                        (66 :foreground "#da8548")
                        (67 :foreground "#0098dd"))
   ))

;;; zaiste-theme.el ends here
