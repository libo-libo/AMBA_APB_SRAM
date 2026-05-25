TOP_NAME=tb_top
dir := work
CUSTOM_UVM := off
UVM_CASE := apb_directed_reg_write_read_test
SIM_TOOL := vcs

FILE_LIST := ../tb_filelist.f
UVM_VERSION ?= uvm-1.2
UVM_HOME ?= $(VCS_HOME)/etc/$(UVM_VERSION)
VCS_UVM_ARGS ?= +define+UVM +incdir+$(UVM_HOME)/src \
				$(UVM_HOME)/src/uvm_pkg.sv +UVM_VERBOSITY=$(VCS_UVM_VERBOSITY)

ifeq ($(CUSTOM_UVM), on)
	VCS_UVM_ARGS += $(UVM_HOME)/src/dpi/uvm_dpi.cc
else
	VCS_UVM_ARGS += -ntb_opts $(UVM_VERSION)
endif

VCS_COMP_FLAGS  ?= $(VCS_UVM_ARGS) -kdb -lca  -debug_access+all+r+w+nomemcbk -debug_region+cell -debug_acc+pp+dmptf -debug_region+cell+encrypt -debug_access +vpi -sverilog -timescale=1ns/1ps +v2k \
				   -assert svaext -race=all -ignore unique_checks -full64 -top $(TOP_NAME) -l cmp.log

VCS_COMP := $(SIM_TOOL) $(VCS_COMP_FLAGS) -file $(FILE_LIST) \

VERDI_OPTIONS_RUN := -verdi

vcs_compile:
ifeq ($(wildcard ./$(dir)),) 
	@mkdir -p ./$(dir)
endif
	@cd $(dir) && $(VCS_COMP)

#see the uvm tou struct
uvm_run:
	@cd $(dir) && ./simv +UVM_VERBOSITY=$(UVM_VERBOSITY)  +UVM_TESTNAME=$(UVM_CASE) -l vcs.log \
	+UVM_TR_RECORD UVM_LOG_RECORD -gui=verdi +UVM_VERDI_TRACE="UVM_AWARE+RAL+HIER+COMPWAVE"

vcs_run:
	@cd $(dir) && ./simv +UVM_VERBOSITY=$(UVM_VERBOSITY) +UVM_TESTNAME=$(UVM_CASE) -l vcs.log \

verdi:
	@cd $(dir) && verdi -ssf $(TOP_NAME).fsdb &

uvm: clean vcs_compile uvm_run

all: clean vcs_compile vcs_run

clean:
	@rm -rf $(dir)*
