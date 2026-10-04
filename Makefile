MASTER  = thesis
VERSION = v4.4
NAME    = Max
SURNAME = Mustermann

SOURCE_DIR = src
BUILD_DIR = out

all:
	@mkdir -p $(BUILD_DIR)
	@cd $(SOURCE_DIR) && TEXINPUTS=.:config//: latexmk -pdf -outdir=../$(BUILD_DIR) -interaction=nonstopmode -halt-on-error $(MASTER)
	@cp $(BUILD_DIR)/$(MASTER).pdf $(MASTER).pdf

help:
	@echo "Available targets:"
	@echo "  all       - Build the thesis (default)"
	@echo "  clean     - Remove build artifacts"
	@echo "  cleanall  - Remove build artifacts and the final PDF"
	@echo "  publish   - Build and compress the PDF for publication"
	@echo "  test      - Build the thesis for CI"
	@echo "  bz2       - Create a tarball of the project"

publish: all
	@ps2pdf14 -dPDFSETTINGS=/prepress $(MASTER).pdf $(MASTER)-prepress.pdf
	@mv $(MASTER)-prepress.pdf $(MASTER).pdf

clean:
	@rm -rf $(BUILD_DIR)

cleanall: clean
	@rm -f $(MASTER).pdf

test: all

bz2: clean
	@echo 'creating package including Docs'
	@tar --exclude-vcs -cf `pwd`/../${MASTER}-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`.tar `pwd`/../`pwd | sed "s,^\(.*/\)\?\([^/]*\),\2,"`
	@bzip2 `pwd`/../${MASTER}-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`.tar

bz2-small: clean
	@echo 'creating package excluding Docs'
	@tar --exclude-vcs --exclude=Docs -cf `pwd`/../${MASTER}-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`_small.tar `pwd`/../`pwd | sed "s,^\(.*/\)\?\([^/]*\),\2,"`
	@bzip2 `pwd`/../${MASTER}-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`_small.tar
