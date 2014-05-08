mn2e-insert.txt: mn2e-insert.sty minify.sed
	rm -f mn2e-insert.txt
	sed -f minify.sed mn2e-insert.sty >mn2e-insert.txt
