LOG_DIR ?= log

# Should be redefined
PROJECT_DIR ?= Project_matte
SPROCESS_SCRIPT ?= sprocess_fps.cmd
SDEVICE_SCRIPT ?= sdevice_des.cmd
SVISUAL_SCRIPT ?= svisualScript.tcl
INSPECT_SCRIPT ?= recordInspectDIBL.cmd
PYTHON_SCRIPT ?= sub.py
X11 ?=


PROJECT_PATH = $(shell find /home/ist25.10/ -name $(PROJECT_DIR))
SPROCESS_PATH ?= $(shell find $(PROJECT_PATH)/ -name $(SPROCESS_SCRIPT))
SDEVICE_PATH ?= $(shell find $(PROJECT_PATH)/ -name $(SDEVICE_SCRIPT)) 
PYTHON_SCRIPT_PATH ?= .
WORKDIR_PATH = $(shell pwd)
 # unsure if should be moved in every folder
LOG_PATH ?= $(WORKDIR_PATH)
PROJECT_WORKDIR ?= $(shell ls $(PROJECT_PATH)/tmp/ | grep g_)
PROJECT_WORKDIR_PATH = $(PROJECT_PATH)/tmp/$(PROJECT_WORKDIR)
SVISUAL_PATH ?= $(shell ls $(PROJECT_PATH)/tmp/ | grep g_)
INSPECT_PATH ?= $(shell ls $(PROJECT_PATH)/tmp/ | grep g_)

SPROCESS_DEFAULT_FLAGS = -b
SPROCESS_USER_FLAGS ?= # by default there are no other
SPROCESS_FLAGS = $(SPROCESS_DEFAULT_FLAGS)
SPROCESS_FLAGS += $(SPROCESS_USER_FLAGS)

SDEVICE_DEFAULT_FLAGS = 
SDEVICE_USER_FLAGS ?=# by default there are no other
SDEVICE_FLAGS = $(SDEVICE_DEFAULT_FLAGS)
SDEVICE_FLAGS += $(SDEVICE_USER_FLAGS)

SVISUAL_DEFAULT_FLAGS = -s 
SVISUAL_USER_FLAGS ?= # by default there are no other
SVISUAL_FLAGS = $(SVISUAL_DEFAULT_FLAGS)
SVISUAL_FLAGS += $(SVISUAL_USER_FLAGS)


INSPECT_DEFAULT_FLAGS = -batch -f 
INSPECT_USER_FLAGS ?= # SHOULD NOT BE TOUCHED FOR NOW
INSPECT_FLAGS = $(INSPECT_DEFAULT_FLAGS)
INSPECT_FLAGS += $(INSPECT_USER_FLAGS)

ARSENIC_DOSE 	?=
ARSENIC_ENERGY 	?=
BORON_DOSE_LDD	?=
BORON_ENERGY_LDD?=
BORON_DOSE_HDD	?=
BORON_ENERGY_HDD?=
FINAL_RTA_TIME 	?=
FINAL_RTA_TEMP 	?=

# name that is appended at log file
LOG_SUBNAME ?=  

# Macro for logging targets
LOG_MACRO = >$(LOG_PATH)/$(LOG_DIR)/$@_$(LOG_SUBNAME).log 2>&1 # also catches stderr

# if someone only runs 'make' the target 'help' will run 
.DEFAULT_GOAL := help

.PHONY: mos
mos: setup change_params sprocess sdevice svisual inspect

.PHONY: sprocess
sprocess:
	@echo "running sprocess"
	@cd $(PROJECT_WORKDIR_PATH); \
	sprocess $(SPROCESS_FLAGS) $(SPROCESS_PATH) $(LOG_MACRO)

.PHONY: sdevice
sdevice:
	@echo "running sdevice"
	@cd $(PROJECT_WORKDIR_PATH); \
	sdevice $(SDEVICE_FLAGS) $(SDEVICE_PATH) $(LOG_MACRO)

# graph exporting works only in X11 forwarding
.PHONY: svisual
svisual:
ifdef X11
	@echo "running svisual"
	@cd $(PROJECT_WORKDIR_PATH); \
	svisual $(SVISUAL_FLAGS) $(SVISUAL_PATH) $(LOG_MACRO) 
endif

.PHONY: inspect
inspect: 
	@echo "running inspect"
	@cd $(PROJECT_WORKDIR_PATH); \
	inspect $(INSPECT_FLAGS) $(INSPECT_SCRIPT) $(LOG_MACRO)
	@cat $(LOG_DIR)/$@_$(LOG_SUBNAME).log
	@./filterInspectOut.sh $(LOG_PATH)/$(LOG_DIR) $@_$(LOG_SUBNAME).log $(PYTHON_SCRIPT_PATH) > $(LOG_PATH)/log/$(PROJECT_DIR)_$(LOG_SUBNAME).log

# to prepare and move scripts inside project folder, as a setup
# TODO: add script that changes name of saved file depending on project name
# Might not be necessary at all if parallelism is done in different folders
.PHONY: setup
setup:
	
	@echo "setting up"
	@mkdir -p $(LOG_PATH)/log
	@cp ./$(SVISUAL_SCRIPT) $(PROJECT_WORKDIR_PATH) 
	@cp ./$(INSPECT_SCRIPT) $(PROJECT_WORKDIR_PATH)

# TODO: check that params are numbers otherwise everything breaks
.PHONY: change_params
change_params:
ifdef ARSENIC_DOSE
	@cd $(PROJECT_WORKDIR_PATH); \
	sed -i -E "0,/implant\ Arsenic /s/(implant\ Arsenic.*dose=[[:space:]]+)[0-9+-]+\.?[e?0-9+-]*/\1$(ARSENIC_DOSE)/" $(SPROCESS_SCRIPT)
endif
 
ifdef ARSENIC_ENERGY
	@cd $(PROJECT_WORKDIR_PATH); \
	sed -i -E "0,/implant\ Arsenic /s/(implant\ Arsenic.*energy=[[:space:]]+)[0-9+-]+\.?[e?0-9+-]*/\1$(ARSENIC_ENERGY)/" $(SPROCESS_SCRIPT)
endif

# dark magic: finds last occurrence by casting reverse line order spell
ifdef BORON_DOSE_HDD
	@cd $(PROJECT_WORKDIR_PATH); \
	tac $(SPROCESS_SCRIPT) | sed -E "0,/implant\ Boron\ /s/(implant\ Boron.*dose=[[:space:]]+)[0-9+-]+\.?[e?0-9+-]*/\1$(BORON_DOSE_HDD)/" > TMP && tac TMP > $(SPROCESS_SCRIPT)
endif

ifdef BORON_ENERGY_HDD
	@cd $(PROJECT_WORKDIR_PATH); \
	tac $(SPROCESS_SCRIPT) | sed -E "0,/implant\ Boron\ /s/(implant\ Boron.*energy=[[:space:]]+)[0-9+-]+\.?[e?0-9+-]*/\1$(BORON_ENERGY_HDD)/"  > TMP && tac TMP > $(SPROCESS_SCRIPT)
endif

ifdef BORON_DOSE_LDD
	@cd $(PROJECT_WORKDIR_PATH); \
	sed -i -E "0,/implant\ Boron\ /s/(implant\ Boron.*dose=[[:space:]]+)[0-9+-]\.?[e?0-9+-]+/\1$(BORON_DOSE_LDD)/" $(SPROCESS_SCRIPT)
endif

ifdef BORON_ENERGY_LDD
	@cd $(PROJECT_WORKDIR_PATH); \
	sed -i -E "0,/implant\ Boron\ /s/(implant\ Boron.*energy=[[:space:]]+)[0-9+-]\.?[e?0-9+-]*/\1$(BORON_ENERGY_LDD)/" $(SPROCESS_SCRIPT)
endif

ifdef FINAL_RTA_TEMP
	@cd $(PROJECT_WORKDIR_PATH); \
	tac $(SPROCESS_SCRIPT) | sed -E "1,/diffuse\ /s/(diffuse.*temperature=[[:space:]]+)[0-9+-]+\.?[e?0-9+-]*/\1$(FINAL_RTA_TEMP)/" > TMP  && tac TMP > $(SPROCESS_SCRIPT)
endif

ifdef FINAL_RTA_TIME
	@cd $(PROJECT_WORKDIR_PATH); \
	tac $(SPROCESS_SCRIPT) | sed -E "1,/diffuse\ /s/(diffuse.*time=[[:space:]]+)[0-9+-]+\.?[e?0-9+-]*/\1$(FINAL_RTA_TIME)/" > TMP && tac TMP > $(SPROCESS_SCRIPT)
endif

.PHONY: clean
clean:
	@echo "cleaning $(LOG_DIR)..."
	@rm -r $(LOG_DIR)/*

.PHONY: help
help:
	@echo "\*\* Makefile for running sentaurus \*\*"
	@echo ""
	@echo "available modifiable params:"
	@echo "-ARSENIC_DOSE" 	
	@echo "-ARSENIC_ENERGY" 	
	@echo "-BORON_DOSE_LDD"	
	@echo "-BORON_ENERGY_LDD"
	@echo "-BORON_DOSE_HDD"	
	@echo "-BORON_ENERGY_HDD"
	@echo "-FINAL_RTA_TIME" 	
	@echo "-FINAL_RTA_TEMP" 	
	@echo ""
	@echo "available project params"
	@echo "-LOG_DIR: default is 'log/'"
	@echo "-LOG_SUBNAME: used to append a name to log files"
	@echo "-PROJECT_PATH: default is 'Project_matte' -> change to your own"
	@echo "-X11: if defined (in any way) be sure to be in an x11 session, otherwise svisual wont go"
	@echo ""
	@echo "available targets:"
	@echo "-setup, change_params, sprocess, sdevice, svisual, inspect"
	@echo "-to run all of these above, use target 'mos'"
	@echo "-clean: removes everything inside LOG_DIR folder"
