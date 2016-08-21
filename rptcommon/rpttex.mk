SHELL = /bin/sh
RPTCOMMON_DIR ?= /home/base/rptcommon
MAKE_RULES = $(RPTCOMMON_DIR)/rpttex.mk

TARGET_FILE = report.pdf
SRC_FILES := report.tex
ifeq ($(TYPE),project)
    BIB_FILE = references.bib
endif

LATEXMK = latexmk
LATEXMK_ARGS = -silent -xelatex -interaction=nonstopmode
ifdef DEBUG
LATEXMK_ARGS = -xelatex
endif

all : $(TARGET_FILE)
.SILENT : $(TARGET_FILE)
.PHONY : all clean

$(TARGET_FILE) : $(SRC_FILES) $(MAKE_RULES) $(BIB_FILE)
	$(LATEXMK) $(LATEXMK_ARGS) $(SRC_FILES)

clean :
	-$(LATEXMK) -C
	-$(RM) *bbl *fls
