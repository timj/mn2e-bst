
mnras.bst
========

`mnras.bst` is the bibliography style file used for the `latex2e` Monthly
Notices of the Royal Astronomical Society style file.  See the
journal's instructions for authors at [OUP][] (Sect. 6.3), and the downloadable
files at [CTAN][].

[OUP]: http://www.oxfordjournals.org/our_journals/mnras/for_authors/
[CTAN]: http://www.tex.ac.uk/CTAN/macros/latex/contrib/mnras/

Previously this file was distributed by Blackwell Scientific.


Style-file support
------------------

Recent changes to the .bst file potentially require support from the
mnras.cls class file.

  * The `.bst` file generates references to DOIs, and to URIs mentioned
    in the `.bib` file, but using macros `\doi` and `\url`.  The
    `hyperref` package defines the `\url` macro, but one can define
    suitable alternatives which typeset the URIs appropriately, even
    if they don't actually make the hyperlink.  These macros are used
    only within the generated `.bbl` file.  See below.

  * The style file also generates references which implement MN's
    'three authors' rule using a macro `\mniiiauthor`.  These macros
    are used in citations (that is, via the `\cite` macro) and so
    outside the generated bibliography (in `.bbl`).

The file `mnras-bst.sty` contains the definitions required to support
the newly-generated `.bst` output.

Currently, `mnras.bst` is configured so that (i) it incorporates the
content of the `mnras-bst.sty` file into the generated `.bbl` file (see
the function `begin.bib`, at the bottom), and (ii) the `\mniiiauthor`
functionality is disabled, using the setting `#0 threeauthorvar :=` in
`initialise.mnras`.  This means that the generated `.bbl` file is
standalone, but doesn't support the MN 'three-authors' prescription.

Ideally, this file will be incorporated directly into the `mnras.cls`
file, or at a pinch loaded as usual using the usual
`\usepackage{mnras-bst}`.  In this case, (i) the function `begin.bib`
should be edited to remove the now-superfluous definitions; and (ii)
the line `#0 'threeauthorvar :=` in `mnras.bst` can be changed to `#1
'threeauthorvar :=`.

If hyperref is _not_ used, then it is necessary to define the `\href`
and `\url` macros as follows:

    \def\href#1#2{#2}
    \def\urlinner#1{#1\endgroup}
    \def\url{\begingroup\def\do##1{\catcode`##1 12 }%
      \do\\\do\$\do\&\do\#\do\^\do\_\do\%\do\~ \ttfamily \urlinner}

(there is a more compact alternative at the top of `mnras-bst.sty`,
which can be used within a class file).


Authors
-------

This style file was originally written by John Sleath and Tim Jenness
at the Mullard Radio Astronomy Observatory in the summer of 1995. It
was derived from the `astron.bst` style file which itself was derived
from the `apalike.bst` style file.

Norman Gray (<http://nxg.me.uk> and <http://8ameter.com>)
provided the multi-author style fixes, and the additions to the
style-file to support DOIs and the MN three-author requirement.

This style was originally known as `mn2e.bst` but has been renamed
to `mnras.bst` to match the new naming convention for the recently
upgraded `mnras.cls`.
