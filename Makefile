VHDL_ENTITY = adder8
TOP_ENTITY = tb_adder8
# VHDL_SRC = src/top.vhdl 
SRC_DIR = src
TB_DIR  = tb
OUT_DIR = out
VHDL_ARGS = -fexplicit -fsynopsys --std=08 --workdir=$(OUT_DIR) 

ELABORATION := e~$(TOP_ENTITY).o # file created outside of out/ dir 
VHDL_EXTENSIONS := .vhd .vhdl .VHD .VHDL
SRC_FILES := $(foreach ext,$(VHDL_EXTENSIONS),$(wildcard $(SRC_DIR)/*$(ext)))
TB_FILES := $(foreach ext,$(VHDL_EXTENSIONS),$(wildcard $(TB_DIR)/*$(ext)))

VHDL_FILES := $(SRC_FILES) $(TB_FILES)

.PHONY: all lint elaborate wave vcd clean prepare help

.DEFAULT_GOAL := help

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nAvailable commands:\n"} \
	/^[a-zA-Z_-]+:.*##/ { printf "  %-15s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

all: wave ## Run simulation and open waveform

once: clean elaborate surf 

lint: prepare ## Syntax check only
	ghdl -s $(VHDL_ARGS) $(VHDL_FILES)

analyze: prepare ## Lint verbose 
	ghdl -a -v $(VHDL_ARGS) $(VHDL_FILES)

elaborate: analyze ## Compile and elaborate
	ghdl -e $(VHDL_ARGS) -o $(TOP_ENTITY) $(TOP_ENTITY)

ghw: elaborate ## creates ghw file
	ghdl -r $(VHDL_ARGS) $(TOP_ENTITY) --wave=$(OUT_DIR)/$(TOP_ENTITY).ghw

surf: elaborate ## Run and dump GHW waveform
	ghdl -r $(VHDL_ARGS) $(TOP_ENTITY) --wave=$(OUT_DIR)/$(TOP_ENTITY).ghw
	surfer $(OUT_DIR)/$(TOP_ENTITY).ghw &

vcd: elaborate ## Run and dump VCD waveform
	ghdl -r $(VHDL_ARGS) $(TOP_ENTITY) --vcd=$(OUT_DIR)/$(TOP_ENTITY).vcd
	surfer $(OUT_DIR)/$(TOP_ENTITY).vcd &

clean: ## Remove output directory
	@rm -rf $(OUT_DIR) $(TOP_ENTITY) $(ELABORATION)

prepare: ## Ensure output directory exists
	@mkdir -p $(OUT_DIR)

NEW_ENTITY ?= $(VHDL_ENTITY)
replace: ## alters the project into a new project
	find . -type f -not -path "*/*.git/*" -exec sed -i 's/$(VHDL_ENTITY)/$(NEW_ENTITY)/g' {} + 
