
mn2e.bst
========

`mn2e.bst` is the bibliography style file used for the `latex2e` Monthly
Notices of the Royal Astronomical Society style file.  See the
journal's instructions for authors at [OUP][] (Sect. 6.3), and the downloadable
files at [CTAN][].

[OUP]: http://www.oxfordjournals.org/our_journals/mnras/for_authors/
[CTAN]: http://www.tex.ac.uk/CTAN/macros/latex/contrib/mnras/

Previously this file was distributed by Blackwell Scientific.


Style-file support
------------------

Recent changes to the .bst file potentially require support from the
mn2e.cls class file.

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

The file `mn2e-bst.sty` contains the definitions required to support
the newly-generated `.bst` output.  This is packaged here as a `.sty`
file, and it can either be loaded as such, using the usual
`\usepackage{mn2e-bst}`, or else (better) incorporated directly into
the `mn2e.cls` file.  In either of these cases, (i) the 'magic
comments' should be removed from the definition of function
`begin.bib` at the bottom of `mn2e.bst`; and (ii) the line `#0
'threeauthorvar :=` in `mn2e.bst` can be changed to `#1
'threeauthorvar :=`.  In consequence (iii) the `compress-sty.sed` and
`Makefile` files can be removed from this directory (and this README
reworded appropriately).

Alternatively, `mn2e.bst` is currently configured so that (i) it
incorporates the `mn2e-bst.sty` file into the generated `.bbl` file, and
(ii) the `\mniiiauthor` functionality is disabled, using the
`threeauthorvar` switch mentioned above.  This means that the
generated `.bbl` file is almost standalone, but this route is rather
fiddly, and in consequence potentially fragile.

If hyperref is _not_ used, then it is necessary to define the `\href`
and `\url` macros as follows:

    \def\href#1#2{#2}
    \def\urlinner#1{#1\endgroup}
    \def\url{\begingroup\def\do##1{\catcode`##1 12 }%
      \do\\\do\$\do\&\do\#\do\^\do\_\do\%\do\~ \ttfamily \urlinner}

(there is a more compact alternative at the top of `mn2e-bst.sty`,
which can be used within a class file).


Authors
-------

This style file was originally written by John Sleath and Tim Jenness
at the Mullard Radio Astronomy Observatory in the summer of 1995. It
was derived from the `astron.bst` style file which itself was derived
from the `apalike.bst` style file.

Norman Gray (<http://nxg.me.uk> and <http://8ameter.com>)
provided the multi-author style fixes, and the additions

