check: mn2e-test.bbl mn2e-test.bbl-correct
	@diff mn2e-test.bbl-correct mn2e-test.bbl >mn2e-test.diff \
	  && echo OK \
	  || { echo FAIL; cat mn2e-test.diff; }

mn2e-test.bbl: mn2e-test.aux mn2e-test.bib ../mn2e.bst
	bibtex mn2e-test

mn2e-example.pdf: mn2e-example.tex mn2e-test.bbl
	TEXINPUTS=..: pdflatex mn2e-example

clean:
	rm -f mn2e-test.bbl mn2e-test.blg mn2e-test.diff
