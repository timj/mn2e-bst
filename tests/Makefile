CHECKS=test-multiauthor test-eprints

%.bbl: %.aux mn2e-test.bib ../mn2e.bst
	bibtex $<

%.diff: %.bbl
	rm -f $@
	diff ${<}-correct $< >$@ || :

# The following succeeds, and prints 'All tests OK', if all of the
# .diff files are of zero size; if one or more is non-empty, it
# reports that, and ends reporting an error.
#
# 'test -s filename' is true if 'filename' exists and has non-zero size
check: $(CHECKS:=.diff)
	@allgood=:; \
	  for f in $(CHECKS); do \
	    if test -s $$f.diff; then \
	      echo "FAIL: $$f"; allgood=false; \
	    else \
	      echo "OK: $$f"; rm $$f.diff; \
	    fi; \
	  done; \
	$$allgood
	@echo "All tests OK"

mn2e-example.pdf: mn2e-example.tex test-multiauthor.bbl
	TEXINPUTS=..: pdflatex mn2e-example

clean:
	rm -f *.bbl *.blg *.diff
