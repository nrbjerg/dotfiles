;;; doom-one-theme.el --- inspired by Doom One -*- lexical-binding: t; no-byte-compile: t; -*-
(require 'doom-themes)

(defgroup doom-one-theme nil
  "Options for the `doom-one' theme."
  :group 'doom-themes)

(defcustom doom-one-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-one-theme
  :type 'boolean)

(defcustom doom-one-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-one-theme
  :type 'boolean)

(defcustom doom-one-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-one-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme modified
  "A dark theme inspired by Atom One Dark."

  ;; name        default   256           16
  ((bg         '("#282c34" "#282c34"       "black"  ))
   (fg         '("#bbc2cf" "#bbc2cf"     "brightwhite"  ))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#21242b" "#21242b"       "black"        ))
   (fg-alt     '("#7a8186" "#7a8186"     "white"        ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#1b2229" "#1b2229"       "black"        ))
   (base1      '("#1c1f24" "#1e1e1e"     "brightblack"  ))
   (base2      '("#202328" "#2e2e2e"     "brightblack"  ))
   (base3      '("#23272e" "#262626"     "brightblack"  ))
   (base4      '("#3f444a" "#3f3f3f"     "brightblack"  ))
   (base5      '("#5b6268" "#525252"     "brightblack"  ))
   (base6      '("#73797e" "#6b6b6b"     "brightblack"  ))
   (base7      '("#9ca0a4" "#979797"     "brightblack"  ))
   (base8      '("#dfdfdf" "#dfdfdf"     "white"        ))

 ;; margin: 0px 20px 0px 0px;
   (grey       base4)
   (red        '("#f97a7b" "#f97a7b" "red"          ))
   (orange     '("#ffae52" "#ffae52" "brightred"    ))
   (green      '("#98be65" "#98be65" "green"        ))
   (teal       '("#4db5bd" "#4db5bd" "brightgreen"  ))
   (yellow     '("#ecbe7b" "#ecbe7b" "yellow"       ))
   (blue       '("#51afef" "#51afef" "brightblue"   ))
   (dark-blue  '("#2257a0" "#2257a0" "blue"         ))
   (light-blue '("#33b2f5" "#33b2f5" "brightblue"   ))
   (magenta    '("#d193e3" "#c678dd" "brightmagenta"))
   (violet     '("#a9a1e1" "#a9a1e1" "magenta"      ))
   (cyan       '("#46d9ff" "#46d9ff" "brightcyan"   ))
   (dark-cyan  '("#5699af" "#5699af" "cyan"         ))

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   (highlight      violet)
   (vertical-bar   (doom-darken blue 0.8))
   (selection      dark-blue)
   (builtin        magenta)
   (comments       fg-alt)
   (doc-comments   yellow)
   (constants      green)
   (functions      magenta)
   (keywords       blue)
   (methods        magenta)
   (operators      (doom-lighten magenta 0.25))
   (type           green)
   (strings        yellow)
   (variables      (doom-lighten magenta 0.35));:base8)
   (numbers        orange)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; These are extra color variables used only in this theme; i.e. they aren't
   ;; mandatory for derived themes.
   (modeline-fg              fg)
   (modeline-fg-alt          fg-alt)
   (modeline-bg              (if doom-one-brighter-modeline
                                 (doom-darken blue 0.45)
                               (doom-darken bg-alt 0.1)))
   (modeline-bg-alt          (if doom-one-brighter-modeline
                                 (doom-darken blue 0.475)
                               `(,(doom-darken (car bg-alt) 0.15) ,@(cdr bg))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-alt `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg)))

   (-modeline-pad
    (when doom-one-padded-modeline
      (if (integerp doom-one-padded-modeline) doom-one-padded-modeline 4))))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground fg)
   ((line-number-current-line &override) :foreground fg-alt)
   ((font-lock-comment-face &override)
    :background (if doom-one-brighter-comments (doom-lighten bg 0.05)))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if doom-one-brighter-modeline base8 highlight))
   (doom-modeline-project-dir :foreground blue :weight 'bold)
   (doom-modeline-buffer-file :slant 'italic)

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-one-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)

   (org-level-1          :foreground magenta :weight 'bold :height 1.25)
   (org-level-2          :foreground blue :weight 'bold :height 1.1)
   (org-link             :foreground yellow :weight 'bold)
   (org-tag              :foreground violet :wieght 'regular)

   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;
   ;;;; ivy
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal)

   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)

   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground blue)
   (markdown-list-face :foreground magenta)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))

   ;;;; rjsx-mode
   (rjsx-tag :foreground red)
   (rjsx-attr :foreground orange)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt))))

  ;;;; Base theme variable overrides-
  ())

;;; doom-one-theme.el ends here
