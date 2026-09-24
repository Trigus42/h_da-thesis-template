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

# Full build; kept as a separate target so CI can call `make test`.
test: all

publish: all
	@ps2pdf14 -dPDFSETTINGS=/prepress $(MASTER).pdf $(MASTER)-prepress.pdf
	@mv $(MASTER)-prepress.pdf $(MASTER).pdf

clean:
	@cd $(SOURCE_DIR) && latexmk -outdir=../$(BUILD_DIR) -C $(MASTER) 2>/dev/null || true
	@rm -rf $(BUILD_DIR)

cleanall: clean
	@rm -f $(MASTER).pdf

bz2: clean
	@echo 'creating package including Docs'
	@tar --exclude-vcs -cf `pwd`/../${MASTER}-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`.tar `pwd`/../`pwd | sed "s,^\(.*/\)\?\([^/]*\),\2,"`
	@bzip2 `pwd`/../${MASTER}-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`.tar

bz2-small: clean
	@echo 'creating package excluding Docs'
	@tar --exclude-vcs --exclude=Docs -cf `pwd`/../${MASTER}-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`_small.tar `pwd`/../`pwd | sed "s,^\(.*/\)\?\([^/]*\),\2,"`
	@bzip2 `pwd`/../${MASTER}-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`_small.tar
