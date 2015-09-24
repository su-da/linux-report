SHELL = /bin/sh
RPTCOMMON_DIR = /home/base/rptcommon
MAKE_RULES = $(RPTCOMMON_DIR)/rptcommon.mk

TARGET_FILE = report.pdf
SRC_FILES := header.md work??.md
TEMPLATE_TEX = $(RPTCOMMON_DIR)/template.tex
DOCUMENTCLASS = report
GEOMETRY = "scale={.75,.8},top=3cm"
PANDOC = pandoc
PANDOC_ARGS = --template=$(TEMPLATE_TEX) --latex-engine=xelatex --toc \
	      -V fontsize=12pt -V papersize=a4paper \
	      -V documentclass=$(DOCUMENTCLASS) \
	      --toc-depth=3 -V geometry=$(GEOMETRY) -N

all : $(TARGET_FILE)

$(TARGET_FILE) : $(SRC_FILES) $(TEMPLATE_TEX) $(MAKE_RULES)
	@echo making report, please wait...
	$(PANDOC) $(PANDOC_ARGS) $(SRC_FILES) -o $@

.SILENT : $(TARGET_FILE)
.PHONY : all clean
clean :
	$(RM) $(TARGET_FILE)
