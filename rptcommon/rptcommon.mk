SHELL = /bin/sh
RSYNC = rsync
PS2PDF = ps2pdf
PS2PDF_ARGS = -dPDFSETTINGS=/prepress
RPTCOMMON_DIR = /home/base/rptcommon
BUILD_DIR = .build
MAKE_RULES = $(RPTCOMMON_DIR)/rptcommon.mk

TARGET_FILE = report.pdf
TARGET_TEX = $(BUILD_DIR)/report.tex
SRC_FILES := header.yaml work??.md
TEMPLATE_TEX = $(RPTCOMMON_DIR)/template.tex
DOCUMENTCLASS = report
TYPE ?= labs
GEOMETRY = "scale={.75,.8},top=3cm"
PANDOC = pandoc
PANDOC_ARGS = --latex-engine=xelatex --toc -V indent -V tables \
	      -V fontsize=12pt -V papersize=a4paper -V $(TYPE) \
	      -V documentclass=$(DOCUMENTCLASS) -V biblio-style=gbt7714-2005 \
	      --toc-depth=3 -V geometry=$(GEOMETRY) -N \
	      --filter pandoc-crossref -M figPrefix="" -M tblPrefix="" \
	      -M figureTitle=图 -M tableTitle=表 -M lofTitle=插图 \
	      -M lotTitle=表格 -M eqnPrefix=""
ifdef PRINT
    PANDOC_ARGS += -V print --no-highlight
endif
ifeq ($(TYPE),project)
    APPENDICES := $(wildcard appendix??.md)
    APPENDICESTEX := $(addprefix $(BUILD_DIR)/, $(APPENDICES:.md=.tex))
    BIB_FILE = references.bib
    PANDOC_ARGS += --natbib --bibliography=$(BIB_FILE) -t latex
    PANDOC_EXARGS = --template=$(TEMPLATE_TEX)
    PANDOC_EXARGS += $(addprefix -A , $(APPENDICESTEX))
else
    PANDOC_ARGS += --template=$(TEMPLATE_TEX)
endif

all : $(TARGET_FILE)
# .SILENT : $(TARGET_FILE)
.PHONY : all clean

$(BUILD_DIR)/appendix%.tex: appendix%.md
	$(PANDOC) $(PANDOC_ARGS) $< -o $@

$(TARGET_FILE) : $(SRC_FILES) $(TEMPLATE_TEX) $(MAKE_RULES) \
    $(BIB_FILE) $(APPENDICESTEX)
	@echo making report, please wait...
ifeq ($(TYPE),project)
	$(PANDOC) $(PANDOC_ARGS) $(SRC_FILES) $(PANDOC_EXARGS) -o $(TARGET_TEX)
	$(RSYNC) -a --delete $(BIB_FILE) $(BUILD_DIR)
	$(MAKE) -C $(BUILD_DIR)
	# $(PS2PDF) $(PS2PDF_ARGS) $(BUILD_DIR)/$(TARGET_FILE) $(TARGET_FILE)
	$(RSYNC) -a --delete $(BUILD_DIR)/$(TARGET_FILE) $(TARGET_FILE)
else
	$(PANDOC) $(PANDOC_ARGS) $(SRC_FILES) -o $@
endif

clean :
	$(RM) $(TARGET_FILE)
ifeq ($(TYPE),project)
	$(MAKE) -C $(BUILD_DIR) clean
	$(RM) $(BUILD_DIR)/*tex $(BUILD_DIR)/*bib
endif
