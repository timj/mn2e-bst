# Edit the compacted mn2e-bst.sty into the .bst file,
# so that it's output at the beginning of the output .bbl file.
#
# Yes, we're replacing this file by its edited self.  It would be more
# natural to maintain mn2e.bst.in and generate mn2e.bst from that,
# with edits, but we want to have an immediately-usable file mn2e.bst
# in the repository.
mn2e.bst: mn2e-bst.sty.include Makefile
	sed -e '/^%%%+/,/^%%%-/d' -e '/^%%%=/r mn2e-bst.sty.include' mn2e.bst >$@.tmp && mv $@.tmp $@

mn2e-bst.sty.include: mn2e-bst.sty compress-sty.sed
	rm -f $@
	sed -f compress-sty.sed mn2e-bst.sty >$@.tmp && mv $@.tmp $@
