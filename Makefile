mn2e.bst: mn2e.bst.in mn2e-insert.txt assemble-bst.sed
	rm -f mn2e.bst
	sed -f assemble-bst.sed mn2e.bst.in >mn2e.bst.tmp && mv mn2e.bst.tmp mn2e.bst

mn2e-insert.txt: mn2e-insert.sty minify.sed
	rm -f mn2e-insert.txt
	sed -f minify.sed mn2e-insert.sty >mn2e-insert.txt

# assemble-bst.sed is a sed script which assembles the mn2e.bst.in
assemble-bst.sed: .git
	rm -f assemble-bst.sed
# is the following (-1) the correct specifier of the 'parent' revision?
	git log -1 --pretty=format:'s/@REV@/%h/%ns/@DATE@/%ad/%n/@MN2E-INSERT@/ {%n  a\%n  %% (DO NOT EDIT THIS TEXT: it is pasted in during construction of the mn2e.bst from its sources)%n  r mn2e-insert.txt%n  d%n}%n' >assemble-bst.sed

check: mn2e.bst
	cd tests; $(MAKE) check

clean:
	rm -f assemble-bst.sed mn2e-insert.txt mn2e.bst
