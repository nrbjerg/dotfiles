(require 'doom-themes)

(defgroup mininal-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(def-doom-theme minimal
  "A minimal theme, inspired the iA text editor."

  ;; name        default   256       16
  ((bg         '("#1A181A" nil       nil            ))
   (bg-alt     '("#222222" nil       nil            ))

   (fg         '("#aeaeae" "#424242" "black"        ))
   (fg-alt     '("#eeeeee" "#c7c7c7" "brightblack"  ))

   (base0      '("#636363" "#efefef" "white"        ))
   (base1      '("#696d6e" "#e7e7e7" "brightblack"  ))
   (base2      '("#dfdfdf" "#dfdfdf" "brightblack"  ))
   (base3      '("#c6c7c7" "#c6c7c7" "brightblack"  ))
   (base4      '("#8c8c84" "#9ca0a4" "brightblack"  ))
   (base5      '("#979791" "#424242" "brightblack"  ))
   (base6      '("#595a55" "#2e2e2e" "brightblack"  ))
   (base7      '("#2c2f34" "#1e1e1e" "brightblack"  ))
   (base8      '("#1b2229" "black"   "black"        ))

   (grey       '("#494b4a" "#a0a1a7" "brightblack"  ))
   (red        '("#86333b" "#c16759" "red"          ))
   (orange     '("#b2823d" "#b2823d" "brightred"    ))
   (green      '("#70955b" "#70955b" "green"        ))
   (teal       '("#70955b" "#70955b" "brightgreen"  ))
   (yellow     '("#b2823d" "#b2823d" "yellow"       ))
   (blue       '("#688cb4" "#688cb4" "brightblue"   ))
   (dark-blue  '("#688cb4" "#688cb4" "blue"         ))
   (magenta    '("#a2729a" "#a2729a" "magenta"      ))
   (violet     '("#a2729a" "#a2729a" "brightmagenta"))
   (cyan       '("#22a5d4" "#22a5d4" "brightcyan"   ))
   (dark-cyan  '("#22a5d4" "#22a5d4" "cyan"         ))

   (highlight      green)
   (vertical-bar   grey)
   (selection      blue)
   (builtin        blue)
   (comments       grey)
   (doc-comments   yellow)
   (constants      red)
   (functions      green)
   (keywords       magenta)
   (methods        green)
   (operators      fg-alt)
   (type           blue)
   (strings        yellow)
   (variables      fg-alt)
   (numbers        red)
   (region         base6)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    yellow)
   (vc-added       green)
   (vc-deleted     red)

   (modeline-fg     nil)
   (modeline-fg-alt (doom-blend violet base4 0.2))

   (modeline-bg base1)
   (modeline-bg-l base2)
   (modeline-bg-inactive (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(doom-darken (car bg-alt) 0.05) ,@(cdr base1))))

  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg-alt)

   (doom-modeline-bar :background fg-alt :forground bg-alt)
   ;;(doom-modeline-active :background fg-alt :forground bg)
   (doom-modeline-project-dir :foreground magenta :weight 'bold)
   (doom-modeline-buffer-file :weight 'regular)


   (magit-blame-heading :foreground orange :background bg-alt)
   (magit-diff-removed :foreground (doom-darken red 0.2) :background (doom-blend red bg 0.1))
   (magit-diff-removed-highlight :foreground red :background (doom-blend red bg 0.2) :bold bold)

   (evil-ex-lazy-highlight :background blue)

   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   (markdown-markup-face     :foreground base5)
   (markdown-header-face     :inherit 'bold :foreground red)
   (markdown-code-face       :background base1)
   (mmm-default-submode-face :background base1)

   (org-block            :background yellow)
   (org-level-1          :foreground yellow :weight 'bold :height 1.25)
   (org-level-2          :foreground magenta :weight 'bold :height 1.1)
   (org-level-3          :foreground green :bold bold :height 1.0)
   (org-level-4          :foreground blue :bold bold :height 1.0)
   (org-ellipsis         :underline nil :background bg-alt     :foreground grey)
   (org-quote            :background base1)
   (org-checkbox-statistics-done :foreground base2 :weight 'normal)
   (org-done nil)
   (org-done :foreground green :weight 'normal)
   (org-headline-done :foreground magenta :weight 'normal :strike-through t)
   (org-date :foreground magenta)
   (org-code :foreground dark-blue)
   (org-special-keyword :foreground fg-alt :underline t)
   (org-document-title :foreground green :weight 'bold :height 1.3)
   (org-document-info-keyword :foreground base4 :height 0.75)
   (org-block-begin-line :foreground base4 :height 0.65)
   (org-meta-line :foreground grey :height 0.65)
   (org-list-dt :foreground blue)


   (helm-candidate-number :background blue :foreground bg)

   (web-mode-current-element-highlight-face :background dark-blue :foreground bg)

   (wgrep-face :background base1)

   (ediff-current-diff-A        :foreground red   :background (doom-lighten red 0.8))
   (ediff-current-diff-B        :foreground green :background (doom-lighten green 0.8))
   (ediff-current-diff-C        :foreground blue  :background (doom-lighten blue 0.8))
   (ediff-current-diff-Ancestor :foreground teal  :background (doom-lighten teal 0.8))

   (tooltip :background base1 :foreground fg)

   (ivy-posframe :background base0)

   (lsp-ui-doc-background      :background bg)
   (lsp-face-highlight-read    :background fg-alt)
   (lsp-face-highlight-textual :inherit 'lsp-face-highlight-read)
   (lsp-face-highlight-write   :inherit 'lsp-face-highlight-read)


   )

  ;; --- extra variables ---------------------
  ;;()
  )

