%%+
%%  Name:
%%     mn2e.bst

%%  Purpose:
%%     BibTeX Bibliography style file for MNRAS

%%  Invocation:
%%     latex <latexfile>
%%     bibtex <latexfile>
%%     latex <latexfile>
%%     latex <latexfile>

%%  Description:
%%     Provides a bibliography style that will allow bibtex to be
%%     used when writing papers for MNRAS. This allows references
%%     to be inserted automatically. For LaTeX2e we recommend that
%%     NatBIB is used to specify references. For latex2.09 you must
%%     use \cite to give (Smith \& Jones 1995) or \shortcite to give the year
%%     (in brackets) only.

%%  Notes:
%%     This file should be used in conjunction with the Monthly Notices
%%     style/class (mn2e.cls or mn.sty) from Blackwell Scientific
%%
%%  Hyperlinks:
%%     To make the eprint and doi bibtex fields hyperlinks, you need
%%     to have \usepackage{hyperref} in your latex preamble.

%%  Authors:
%%     John P. Sleath (MRAO)
%%     Tim Jenness (MRAO/JAC)
%%     Norman Gray (Glasgow University, Starlink) <norman@astro.gla.ac.uk>

%%  Bugs:
%%     The formatting has been compared to the MN style, and is
%%     believed to be compatible with it.  However this comparison has
%%     (for obvious reasons) been done most carefully for articles, so
%%     there may be deviations from it for other entry types.
%%
%%     In the text MN style forces 3 author papers
%%     to fully list the authors first time the reference is mentioned. This
%%     cannot be done automatically. Use \cite*{} the first time.

%%  History:
%%     Summer 1995 (JPS/TJ):
%%        Extensively modified from astron.bst and apalike.bst
%%     19 Jul 1995 (JPS/TJ):
%%        First release (version 1.1b)
%%     02 May 2001 (NG):
%%        Limit the author lists to eight people.
%%     19 Jun 2001 (TJ):
%%        Fix inproceedings
%%     30 Oct 2001 (NG):
%%        Adjust author-limiting to conform to MN style (version 1.2)
%%     22 Sep 2012 (Philip Hall):
%%        Remove comma before et al when many authors.
%%     01 July 2013 (Simeon Bird):
%%        Ported Antony Lewis' hyperlinked arxiv entry additions across.
%%        Originally modified for hyperlinked arxiv eprints by Antony Lewis April 2006
%%     August 2013 (NG):
%%        Fixed a/b/c... year suffixes -- these now appear in the
%%        correct order.
%%
%%-

ENTRY
  { address
    doi
    eprint
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
%    month              not used in apalike
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
    url
  }
  {}
  { label extra.label sort.label presort.key }


INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

% If threeauthorvar is set to #1 in initialise.mn2e, then the bibitem for a
% three-author reference is generated using a \mniiiauthor command.
% This command should be defined in the .cls file as follows:
%
%    \def\mniiiauthor#1#2#3{%
%      \@ifundefined{mniiiauth@#1}
%        {\global\expandafter\let\csname mniiiauth@#1\endcsname\null #2}
%        {#3}}
%
% The effect of this is that the first time that \mniiiauthor{X}{a}{b}
% is evaluated, it expands to 'a', and it thereafter expands to 'b'.
% This implements the MN style guide stipulation that "For three
% authors, give all three names at first mention, e.g. (Brown, Jones &
% Smith 1994), but use first author et al. (in roman, not italic)
% thereafter, e.g. (Brown et al. 1994)."
%
% The above definition consumes a command for each such author.  It's
% surely possible to avoid this (with some constructions involving
% {\\#1}; see Appendix D cleverness), but that would verge on the
% arcane, and not be really worth it.
INTEGERS { maxauthors threeauthorvar }

FUNCTION {initialise.mn2e}
{
  #8 'maxauthors :=
  #1 'threeauthorvar :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { ". " *  write$
          newline$
%          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { ", " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output.nonnull.extra}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { ", " *  write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { ", " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output.nonnull.nocomma}
{'s :=
  output.state mid.sentence =
    { write$ }
    { output.state after.block =
        { ". " *  write$
          newline$
%          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { ", " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}


FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.extra}
{ duplicate$ empty$
    'pop$
    'output.nonnull.extra
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.check.nocomma}
{ 't :=
  duplicate$ empty$
   % { pop$ "empty " t * " in " * cite$ * warning$ }
     'pop$
    'output.nonnull.nocomma
  if$
}

FUNCTION {output.check.extra}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull.extra
  if$
}

FUNCTION {output.year.check}
{ year empty$
    { "empty year in " cite$ * warning$ }
    { write$
      " " year * extra.label *
      mid.sentence 'output.state :=
    }
  if$
}

% Redundant?  See discussion in {misc}, below.
FUNCTION {output.year.misc.check}
{ year empty$
    { "empty year in " cite$ * warning$ }
    { write$
     output.state mid.sentence =
      { "," write$ } {} if$
      " " year * extra.label *
      mid.sentence 'output.state :=
    }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  label write$
  "]{" write$
  cite$ write$
  "}" write$
  % debugging: define eg \def\logsortkey#1{{[\tiny #1]}} to see this
  %"\logsortkey{" presort.key * "/" * sort.key$ * "}" * write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {boldface}
{ duplicate$ empty$
    { pop$ "" }
    { "{ " swap$ * "}" * }
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{ " swap$ * "}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

%% Name formatting.  According to the MN instructions for authors, `In
%% the references list [...] List all authors if eight or fewer,
%% otherwise et al.'.  This means (according to a ruling from the MN
%% editors) that if there are eight or more authors, they should be
%% listed as "first one plus et al."
FUNCTION {format.names}
{ 's :=
  s num.names$ 'numnames :=
  numnames maxauthors >
    { % Too many authors -- format as First author et al.
      s #1 "{vv }{ll}{ jj}{ f. }" format.name$  % last name first
      " et~al.," *
    }
    { % maxauthors or fewer -- print them all
      numnames 'namesleft :=
      #1 'nameptr :=
      { namesleft #0 > }
        { s nameptr "{vv }{ll}{ jj}{ f., }" format.name$ 't := % last name first
          nameptr #1 >
            { namesleft #1 >
                { " " * t * }
                { numnames #2 >
                    { "  " * }
                    'skip$
                  if$
                  t "others" =
                    { " et~al.," * }
                    { " " * t * }
                  if$
                }
              if$
            }
            't
          if$
          nameptr #1 + 'nameptr :=
          namesleft #1 - 'namesleft :=
        }
      while$
    }
  if$
}

FUNCTION {format.names.full}
{ 's :=
  s num.names$ 'numnames :=
  numnames maxauthors >
    { % Too many authors -- format as First author et al.
      s #1 "{vv }{ll}{ jj}" format.name$  % last name first
      " et~al.," *
    }
    { % maxauthors or fewer -- print them all
      numnames 'namesleft :=
      #1 'nameptr :=
      { namesleft #0 > }
        { s nameptr "{vv }{ll}{ jj}" format.name$ 't :=   % last name first
          nameptr #1 >
            {
              namesleft #1 >
                { ", " * t * }
                {
                  t "others" =
                    { " et~al.," * }
                    { " \& " * t * }
                  if$
                }
              if$
            }
            't
          if$
          nameptr #1 + 'nameptr :=
          namesleft #1 - 'namesleft :=
        }
      while$
    }
  if$
}

FUNCTION {format.ed.names}
{ 's :=
  s num.names$ 'numnames :=
  numnames maxauthors >
    { % Too many authors -- format as First author et al.
      s #1 "{vv }{ll}{ jj}{ f. }" format.name$  % last name first
      " et~al.," *
    }
    { % maxauthors or fewer -- print them all
      numnames 'namesleft :=
      #1 'nameptr :=
      { namesleft #0 > }
        { s nameptr "{vv }{ll}{ jj}{ f., }" format.name$ 't :=
          nameptr #1 >
            { namesleft #1 >
                { " " * t * }
                { numnames #2 >
                    { " " * }
                    'skip$
                  if$
                  t "others" =
                     { " et~al." * }
                    { " " * t * }
                  if$
                }
              if$
            }
            't
          if$
          nameptr #1 + 'nameptr :=
          namesleft #1 - 'namesleft :=
        }
      while$
    }
  if$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.key}                   % this function is just for apalike
{ empty$
    { key field.or.null }
    { "" }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
        { " eds," * }
        { " ed." * }
      if$
    }
  if$
}

FUNCTION {format.editors.extra}
{ editor empty$
    { "" }
    { editor format.ed.names
      editor num.names$ #1 >
        { " eds" * }
        { " ed." * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$ }
  if$
}

FUNCTION {format.eprint}
{ eprint empty$
    { "" }
    {  ", \eprint{" * eprint * "}" }
    if$
}

FUNCTION {format.doi}
{ doi empty$
    { "" }
    { ", \doi{" * doi * "}" }
    if$
}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {first.page.number}
{ 't :=
  ""
    { t "" =
        { #0 }
        { t #1 #1 substring$ "-" = not }
      if$
    }
    { t #1 #1 substring$ *
      t #2 global.max$ substring$ 't :=
    }
  while$
}

FUNCTION {format.btitle}
{ title
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #5 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "" series tie.or.space.connect
      volume empty$
        'skip$
        { " Vol. " * volume * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { output.state mid.sentence =
            { "No." }
            { "No." }
          if$
          number tie.or.space.connect
          series empty$
            { "there's a number but no series in " cite$ * warning$ }
            { " in " * series * }
          if$
        }
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
        { edition "l" change.case$ " edn" * }
        { edition "t" change.case$ " edn" * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
        { "pp" pages n.dashify tie.or.space.connect }
        { "p." pages tie.or.space.connect }
      if$
    }
  if$
}

FUNCTION {format.page}
{ pages empty$
    { "" }
    { "p.~" pages first.page.number * }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    { "(" number * ")" * *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { ", " * pages n.dashify * }
      if$
    }
  if$
}

FUNCTION {format.vol.page}
{ volume field.or.null
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { ", " * pages first.page.number * }
      if$
    }
  if$
}

FUNCTION {format.vol.num.page}
{ volume field.or.null
  number empty$
    'skip$
    { "(" number * ")" * *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { ", " * pages first.page.number * }
      if$
    }
  if$
}
FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { "Chapt." }
        { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
        'skip$
        { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
        { "in " booktitle * }
	{ format.bvolume empty$
      		{ "in " format.editors.extra * ", " * booktitle * }
        	{ "in " format.editors.extra * ", " * format.bvolume * ", " * booktitle * }
		if$
	}
      if$
    }
  if$
}

FUNCTION {format.in.ed.collect}
{ booktitle empty$
    { "" }
    { editor empty$
      { "in " }
      { "in " format.editors.extra * ", " * }
      if$
      series empty$
      { skip$ }
      { series * }
      if$
      volume empty$
      { number empty$
        { }
        { output.state mid.sentence =
            { "No." }
            { "No." }
          if$
          number tie.or.space.connect *
        }
        if$
      }
      {
	output.state mid.sentence =
        { ", " * }
	{ skip$ }
	if$
        "Vol." volume tie.or.space.connect *
      }
      if$
      output.state mid.sentence =
      { ", " * }
      { skip$ }
      if$
      booktitle *
    }
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.url}
{
  url empty$
    { skip$ }
    { "\verb+" url * "+" * output.nonnull }
  if$
}

FUNCTION {format.tr.number}
{
  type empty$
    { "Technical Report" }
    { type }
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{ "in"                                                  % this is for apalike
  " \cite{" * crossref * "}" *
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "in "
    }
    { "Vol." volume tie.or.space.connect
      " of " *
    }
  if$
  "\cite{" * crossref * "}" *                           % this is for apalike
}

FUNCTION {format.incoll.inproc.crossref}
{ "in"                                                  % this is for apalike
  " \cite{" * crossref * "}" *
}

FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  crossref missing$
    { journal "journal" output.check.extra
      format.vol.page output.extra
    }
    { format.article.crossref output.nonnull
      format.page output
    }
  if$
  format.eprint "eprint" output.check.nocomma
  format.doi "doi" output.check.nocomma
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check
      editor format.key output
    }
    { format.authors output.nonnull
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  output.year.check                             % special for apalike
  format.btitle "title" output.check
  format.edition output
  new.block
  crossref missing$
    { format.bvolume output
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
      {format.book.crossref output.nonnull}
  if$
  format.eprint "eprint" output.check.nocomma
  format.doi "doi" output.check.nocomma
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.authors output
  author format.key output                              % special for
  output.year.check                                     % apalike
  format.btitle "title" output.check
  howpublished output
  address output
  format.eprint "eprint" output.check.nocomma
  format.doi "doi" output.check.nocomma
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check
      editor format.key output
    }
    { format.authors output.nonnull
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  output.year.check                             % special for apalike
  format.btitle "title" output.check
  format.edition output
  new.block
  crossref missing$
    {
%      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
      format.pages output
    }
    { format.chapter.pages "chapter and pages" output.check
      format.book.crossref output.nonnull
    }
  if$
  format.eprint "eprint" output.check.nocomma
  format.doi "doi" output.check.nocomma
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  crossref missing$
    {
      format.in.ed.collect "booktitle" output.check
      format.edition output
      booktitle empty$ edition empty$ =
        { } { new.block } if$
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  format.chapter.pages output
  format.eprint "eprint" output.check.nocomma
  format.doi "doi" output.check.nocomma
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  crossref missing$
    {

      format.in.ed.booktitle "booktitle" output.check
      ". " *
%      format.bvolume output
      before.all 'output.state :=
      new.block
%      format.title "title" output.check
      format.number.series output
      new.block
%      organization output
      publisher output
      address output
      format.pages output
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$
  format.eprint "eprint" output.check.nocomma
  format.doi "doi" output.check.nocomma
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  format.authors output
  author format.key output                              % special for
  output.year.check                                     % apalike
  format.btitle "title" output.check
  new.block
  organization address new.block.checkb
  organization output
  address output
  format.edition output
  format.eprint "eprint" output.check.nocomma
  format.doi "doi" output.check.nocomma
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  "Master's thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  % The following at one time included output.year.misc.check rather
  % than output.year.check.  It's not clear why, since this seems to
  % have inevitably resulted in an extra comma in this case (ie,
  % "Jones A, Smith B., , 2000, ....").  Use plain output.year.check
  % until it becomes clear what the function of the (erroneous)
  % output.year.misc.check is or was.
  author format.key output                              % special for
  %output.year.misc.check                               % apalike
  output.year.check
  format.btitle output
  howpublished output
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  "PhD thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  format.editors output
  editor format.key output                              % special for
      mid.sentence 'output.state :=
  output.year.check                                     % apalike
  format.btitle "title" output.check
  " " *
  before.all 'output.state :=
%  new.block
  format.bvolume output
  format.number.series output
  new.block
%  organization output                           % a nonempty organization
  publisher output
  address output
  format.eprint "eprint" output.check.nocomma
  format.doi "doi" output.check.nocomma
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  format.tr.number output.nonnull
  format.btitle "title" output.check
  format.url
  new.block
  institution "institution" output.check
  address output
  format.eprint "eprint" output.check.nocomma
  format.doi "doi" output.check.nocomma
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  author format.key output                              % special for
  output.year.check                                     % apalike
  format.btitle "title" output.check
  note "note" output.check
  format.eprint "eprint" output.check.nocomma
  format.doi "doi" output.check.nocomma
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"Jan."}

MACRO {feb} {"Feb."}

MACRO {mar} {"Mar."}

MACRO {apr} {"Apr,"}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"Aug."}

MACRO {sep} {"Sept."}

MACRO {oct} {"Oct."}

MACRO {nov} {"Nov."}

MACRO {dec} {"Dec."}

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

% There are three apalike cases: one person (Jones),
% two (Jones and de~Bruijn), and more (Jones et~al.).
% This function is much like format.crossref.editors.
%
% In the 'and others' branch below, the second space before 'et~al'
% means that 'Smith and others' sorts after 'Smith' but before 'Smith
% and Jones'.  This may or may not be compatible with the MN style
% prescription that:
%     If there are several references with the same first author,
%     arrange in the following order: firstly single-author papers (by
%     date); then two-author papers (alphabetically by co-author, then by
%     date); then multi-author papers (by date). 
% This ordering is acting as if 'Jones and others' is a single-author
% paper which always sorts after other 'Jones' papers.  As well, it's
% unexpectedly tricky to get this sorting with the multi-author papers
% (since the label we're generating appears in the output, so we can't
% put just anything in here).
FUNCTION {format.lab.names}
{ 's :=
  s #1 "{vv~}{ll}" format.name$
  s num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
        'skip$
        { s #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
            { "  et~al." * }
            { " \& " * s #2 "{vv~}{ll}" format.name$ * }
          if$
        }
      if$
    }
  if$
}

% Format names in full
%
FUNCTION {format.lab.names.full}
{ 's :=
  s #1 "{vv~}{ll}" format.name$
  s num.names$ duplicate$
  #2 <
    'skip$
    { s #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
	'skip$
        { " \& " * s #2 "{vv~}{ll}" format.name$ * }
      if$
    }
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key                                    % apalike uses the whole key
      if$
    }
    { author format.lab.names }
  if$
}


FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            'key                                % apalike uses the whole key
          if$
        }
        { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.editor.key.label.full}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            'key
          if$
        }
        { editor format.names.full }
      if$
    }
    { author format.names.full }
  if$
}

FUNCTION {editor.key.label}
{ editor empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key                    % apalike uses the whole key, no organization
      if$
    }
    { editor format.lab.names }
  if$
}

% Calculate the 'label' for the entry, which is used for sorting.
% Note that this does not include the a/b/c... for disambiguating
% years (that's added later, in forward.pass).
FUNCTION {calc.label}
{ % Define t: this is the 'full' set of names
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label.full
    { type$ "proceedings" =
        { editor format.names.full }
        { author format.names.full }
      if$
    }
  if$
  't :=
  % Define s: this is the 'shortened' set of names, with 'et al.',
  % which are to appear in citations
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
        'editor.key.label                       % apalike ignores organization
        'author.key.label                       % for labeling and sorting
      if$
    }
  if$
  's :=
  % the '\protect... is for apalike
  "\protect\citeauthoryear{" t * "}{" *
  threeauthorvar
  numnames #3 =
  and
    { "\protect\mniiiauthor{" cite$ * "}{" *
      t * "}{" * s * "}" * }
    { s }
  if$
  *
  "}{" *
  year field.or.null purify$ #-1 #4 substring$  % use all four digits
  *
  % the matching closing "}" comes in at the reverse.pass
  'label :=
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { "   " * }
        'skip$
      if$                                               % apalike uses initials
      s nameptr "{vv{ } }{ll{ }}{  f{ }}{  jj{ }}" format.name$ 't := % <= here
      "Mc" t #2 text.prefix$ =
          { "mac" t #3 t text.length$ substring$ * 't := }
          'skip$
      if$
      nameptr numnames = t "others" = and
       { " et~al." * }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.sort}
{ editor empty$
    { key empty$
        { "to sort, need editor or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

% Format numbers (eg volume, number, pages) into a fixed-width string,
% for sorting.
FUNCTION {number.for.presort}
{ field.or.null
  duplicate$ text.length$ 'len :=
  ""
  { #5 len > }
    { "0" *
      len #1 + 'len := }
  while$
  swap$ *
}

% apalike uses two sorting passes; the first one sets the
% labels so that the `a's, `b's, etc. can be computed;
% the second pass puts the references in "correct" order.
% The presort function is for the first pass. It computes
% presort.key, sort.label, and sort.key$
FUNCTION {presort}
{ calc.label
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
        'editor.key.label                       % apalike ignores organization
        'author.key.label                       % for labeling and sorting
      if$
    }
  if$
  "    "
  *
  year number.for.presort *
  #1 entry.max$ substring$
  'presort.key :=
  presort.key
  "    "
  *
  % Style apalike prefers 'title field.or.null sort.format.title *' here.
  % We don't, because we will predominantly be sorting articles in
  % this style, and we don't include their titles in the final bibliography.
  volume number.for.presort *
  number number.for.presort *
  pages empty$
    { "0" }
    { pages first.page.number }
  if$
  number.for.presort *
  #1 entry.max$ substring$
  'sort.key$ :=
  sort.key$ 'sort.label :=
}
  
EXECUTE {initialise.mn2e}

ITERATE {presort}

SORT            % by label, sort.label, title---for final label calculation

% Manage the construction of the 'extra' labels for references.  These
% are the a/b/c/... year suffixes which distinguish different
% publications by the same author.
%
% These apalike labels are only for the text; the 'label' does not
% appear in the bibiliography, so that the 'longest.label' variable is
% unnecessary in this style.
STRINGS { last.key next.extra }

INTEGERS { last.extra.num }

FUNCTION {initialize.extra.label.stuff}
{ #0 int.to.chr$ 'last.key :=
  "" 'next.extra :=
  #0 'last.extra.num :=
}

% By the time that this function is iterated over, the entries have
% had presort.key assigned, and have been presorted.  However these labels
% do not (by design) respect the presence of multiple entries in the
% same year, so that there are duplicates.  Detect successive
% duplicates, and add an extra a/b/c... suffix.
%
% At the end of this forward.pass, each entry with a duplicate presort.key
% will have an extra.label, starting with 'b' for the first duplicate,
% 'c' for the second, and so on.  That is, only the first
% soon-to-be-discovered-to-be-duplicate label will not have an
% extra.label.
FUNCTION {forward.pass}
{ last.key presort.key =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { % first time we've seen this key
      "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      presort.key 'last.key :=
    }
  if$
}

% Work back through the labels.  If, on this pass we discover that the
% next entry in the sequence (which is the last entry processed in
% this reverse pass) had an extra.label of 'b', then this tells us
% that _this_ entry should have an extra.label of 'a', which we were
% unable to detect in the forward.pass above.
%
% We also close the brace pair {...} opened in calc.label
FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  label extra.label * "}" * 'label :=
  extra.label 'next.extra :=
}

EXECUTE {initialize.extra.label.stuff}

ITERATE {forward.pass}

REVERSE {reverse.pass}

% Now that the label is right we sort for real.  We sort on sort.label
% then year then title.  Since sort.label starts with presort.key,
% this sorting is compatible with the letter suffixes added to years.
%
% This is for the second sorting pass.
FUNCTION {bib.sort.order}
{ sort.label
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {bib.sort.order}

SORT            % by sort.label, year, title---giving final bibliography order

FUNCTION {begin.bib}
{
  preamble$ empty$                              % no \etalchar in apalike
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{}"
    write$ newline$           % no labels in apalike
  " \providecommand{\href}[2]{#2} "
    write$ newline$
  "  \providecommand{\doi}[1]{\href{http://dx.doi.org/#1}{doi:#1}}"
    write$ newline$
  "  \providecommand{\eprint}[1]{\href{http://arxiv.org/abs/#1}{arXiv:#1}}"
    write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
