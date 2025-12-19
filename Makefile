# Should be redefined
LOG_DIR ?= log
PROJECT_DIR ?= Project_matte 
SPROCESS_SCRIPT ?= sprocess_fps.cmd
SDEVICE_SCRIPT ?= sdevice_des.cmd
SVISUAL_SCRIPT ?= svisualScript.tcl
INSPECT_SCRIPT ?= recordInspectDIBL.cmd
PYTHON_SCRIPT ?= sub.py


PROJECT_PATH = $(shell find /home/ist25.10/ -name $(PROJECT_DIR))
SPROCESS_PATH ?= $(shell find $(PROJECT_PATH)/ -name $(SPROCESS_SCRIPT))
SDEVICE_PATH ?= $(shell find $(PROJECT_PATH)/ -name $(SDEVICE_SCRIPT)) 

WORKDIR_PATH = $(shell pwd)
 # unsure if should be moved in every folder
LOG_PATH ?= .
SVISUAL_PATH ?= SDEVICE_PATH
INSPECT_PATH ?= SDEVICE_PATH 

SPROCESS_DEFAULT_FLAGS = -b
SPROCESS_USER_FLAGS ?= # by default there are no other
SPROCESS_FLAGS = SPROCESS_DEFAULT_FLAGS
SPROCESS_FLAGS += SPROCESS_USER_FLAGS

SDEVICE_DEFAULT_FLAGS = 
SDEVICE_USER_FLAGS ?= # by default there are no other
SDEVICE_FLAGS = SDEVICE_DEFAULT_FLAGS
SDEVICE_FLAGS += SDEVICE_USER_FLAGS

SVISUAL_DEFAULT_FLAGS = -s 
SVISUAL_USER_FLAGS ?= # by default there are no other
SVISUAL_FLAGS = SVISUAL_DEFAULT_FLAGS
SVISUAL_FLAGS += SVISUAL_USER_FLAGS

LOG_MACRO = >$(LOG_PATH)/log/$@.log 2>&1 # also catches stderr

sprocess:
	sprocess $(SPROCESS_FLAGS) $(SPROCESS_PATH)/$(SPROCESS_SCRIPT) $(LOG_MACRO)

sdevice:
	sdevice $(SDEVICE_FLAGS) $(SDEVICE_PATH)/$(SDEVICE_SCRIPT) $(LOG_MACRO)

# graph exporting works only in X11 forwarding
svisual:
	svisual $(SVISUAL_FLAGS) $(SVISUAL_PATH)/$(SVISUAL_SCRIPT) $(LOG_MACRO) 

# to pass scripts inside project folder, as a setup
setup:
	cp ./$(SVISUAL_SCRIPT) $(PROJECT_PATH)/$(SPROCESS_PATH) 
	cp ./$(INSPECT_SCRIPT) $(PROJECT_PATH)/$(SPROCESS_PATH)

