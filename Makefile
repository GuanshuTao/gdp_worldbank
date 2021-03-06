####################
# Makefile template adapted from the following ...
# Copyright Brian A. Fannin 2015
# https://www.r-bloggers.com/makefiles-and-rmarkdown/
#
# alter the “Project Options” section of the “Tools/Project Options”#
# RStudio to ensure that the build tool moves from “none” to “Makefile”. 
#
# Within RStudio, you can just hit CTRL-SHIFT-B to execute make
#
####################

RDIR = .
DATA_DIR = $(RDIR)/data

GATHER_DIR = $(DATA_DIR)/gather
GATHER_SOURCE = $(wildcard $(GATHER_DIR)/*.Rmd)
GATHER_OUT = $(GATHER_SOURCE:.Rmd=.docx)

PROCESS_DIR = $(DATA_DIR)/process
PROCESS_SOURCE = $(wildcard $(PROCESS_DIR)/*.Rmd)
PROCESS_OUT = $(PROCESS_SOURCE:.Rmd=.docx)

ANALYSIS_DIR = $(RDIR)/analysis
ANALYSIS_SOURCE = $(wildcard $(ANALYSIS_DIR)/*.Rmd)
ANALYSIS_OUT = $(ANALYSIS_SOURCE:.Rmd=.docx)

PRESENTATION_DIR = $(RDIR)/presentation
PRESENTATION_SOURCE = $(wildcard $(PRESENTATION_DIR)/*.Rmd)
PRESENTATION_OUT = $(PRESENTATION_SOURCE:.Rmd=.docx)

KNIT = Rscript -e "require(rmarkdown); render('$<')"

all: $(GATHER_OUT) $(PROCESS_OUT) $(ANALYSIS_OUT) $(PRESENTATION_OUT)

#########################
## Gather 
$(GATHER_DIR)/%.docx:$(GATHER_DIR)/%.Rmd
	$(KNIT) 

#########################
# Process 
$(PROCESS_DIR)/%.docx:$(PROCESS_DIR)/%.Rmd $(GATHER_OUT)
	$(KNIT) 

#########################
# Analyze 
$(ANALYSIS_DIR)/%.docx:$(ANALYSIS_DIR)/%.Rmd $(PROCESS_OUT)
	$(KNIT) 

#########################
# Present 
$(PRESENTATION_DIR)/%.docx:$(PRESENTATION_DIR)/%.Rmd $(ANALYSIS_OUT)
	$(KNIT) 
	
clean:
	rm -fv $(GATHER_OUT)
	rm -fv $(PROCESS_OUT)
	rm -fv $(ANALYSIS_OUT)
	rm -fv $(PRESENTATION_OUT)