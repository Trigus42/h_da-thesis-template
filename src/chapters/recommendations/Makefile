MASTER = recommendations

all:
	@latexmk -pdf -interaction=nonstopmode -halt-on-error $(MASTER)

# Full build; kept as a separate target for parity with the main Makefile.
test: all

publish: all
	@ps2pdf14 -dPDFSETTINGS=/prepress $(MASTER).pdf $(MASTER)-prepress.pdf
	@mv $(MASTER)-prepress.pdf $(MASTER).pdf

# -c removes aux/log files but keeps the PDF; -C also removes the PDF.
clean:
	@latexmk -c $(MASTER)

cleanall:
	@latexmk -C $(MASTER)
