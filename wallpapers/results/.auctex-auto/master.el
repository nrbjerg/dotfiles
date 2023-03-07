(TeX-add-style-hook
 "master"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "paperwidth=9.6in" "paperheight=5.4in" "left=5mm" "right=5mm" "top=10mm" "bottom=5mm")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "lscape"
    "graphicx"
    "lipsum"
    "multicol"
    "tcolorbox"
    "amsmath"
    "amsfonts"
    "geometry")
   (TeX-add-symbols
    '("abs" 1)
    '("norm" 1)
    "N"
    "Z"
    "Q"
    "F"
    "R"
    "C"
    "e")
   (LaTeX-add-xcolor-definecolors
    "fg"
    "bg_alt"
    "bg"))
 :latex)

