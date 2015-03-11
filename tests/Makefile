check: mnras-test.bbl mnras-test.bbl-correct
	@diff mnras-test.bbl-correct mnras-test.bbl >mnras-test.diff \
	  && echo OK \
	  || { echo FAIL; cat mnras-test.diff; }

mnras-test.bbl: mnras-test.aux mnras-test.bib ../mnras.bst
	bibtex mnras-test

mnras-example.pdf: mnras-example.tex mnras-test.bbl
	TEXINPUTS=..: pdflatex mnras-example

clean:
	rm -f mnras-test.bbl mnras-test.blg mnras-test.diff
