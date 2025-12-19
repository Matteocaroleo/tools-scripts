LOG_DIR ?= log

# Should be redefined
PROJECT_DIR ?= Project_matte
SPROCESS_SCRIPT ?= sprocess_fps.cmd
SDEVICE_SCRIPT ?= sdevice_des.cmd
SVISUAL_SCRIPT ?= svisualScript.tcl
INSPECT_SCRIPT ?= recordInspectDIBL.cmd
PYTHON_SCRIPT ?= sub.py


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


LOG_MACRO = >$(LOG_PATH)/$(LOG_DIR)/$@.log 2>&1 # also catches stderr

sprocess:
	cd $(PROJECT_WORKDIR_PATH); sprocess $(SPROCESS_FLAGS) $(SPROCESS_PATH) $(LOG_MACRO)

sdevice:
	cd $(PROJECT_WORKDIR_PATH); sdevice $(SDEVICE_FLAGS) $(SDEVICE_PATH) $(LOG_MACRO)

# graph exporting works only in X11 forwarding
svisual:
	cd $(PROJECT_WORKDIR_PATH); svisual $(SVISUAL_FLAGS) $(SVISUAL_PATH) $(LOG_MACRO) 

inspect: 
	cd $(PROJECT_WORKDIR_PATH); inspect $(INSPECT_FLAGS) $(INSPECT_SCRIPT) $(LOG_MACRO)
	./filterInspectOut.sh $(LOG_PATH)/$(LOG_DIR) $@.log $(PYTHON_SCRIPT_PATH) > $(LOG_PATH)/log/$(PROJECT_DIR).log

# to prepare and move scripts inside project folder, as a setup
# TODO: add script that changes name of saved file depending on project name
setup:
	mkdir -p $(LOG_PATH)/log
	cp ./$(SVISUAL_SCRIPT) $(PROJECT_WORKDIR_PATH) 
	cp ./$(INSPECT_SCRIPT) $(PROJECT_WORKDIR_PATH)

