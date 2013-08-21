check: mn2e-test.bbl-correct
	bibtex mn2e-test
	@diff mn2e-test.bbl-correct mn2e-test.bbl >mn2e-test.diff \
	  && echo OK \
	  || { echo FAIL; cat mn2e-test.diff; }

clean:
	rm -f mn2e-test.bbl mn2e-test.blg mn2e-test.diff
