#### PROJECT SETTINGS ####
# The name of the executable to be created
BIN_NAME := wsdiscovery
# Compiler used
CC = gcc
# Extension of source files used in the project
SRC_EXT = c
# Path to the source directory, relative to the makefile
SRC_PATH = .
# General compiler flags
COMPILE_FLAGS = -Wall -Wextra -g
# Additional release-specific flags
RCOMPILE_FLAGS = -D NDEBUG -O2
# Additional debug-specific flags
DCOMPILE_FLAGS = -D DEBUG -Og
# General linker settings
LINK_FLAGS = -lpthread
# Additional release-specific linker settings
RLINK_FLAGS = 
# Additional debug-specific linker settings
DLINK_FLAGS = 
#### END PROJECT SETTINGS ####

STRIP = strip

# Combine compiler and linker flags
release: export CXXFLAGS := $(CXXFLAGS) $(COMPILE_FLAGS) $(RCOMPILE_FLAGS)
release: export LDFLAGS := $(LDFLAGS) $(LINK_FLAGS) $(RLINK_FLAGS)
debug: export CXXFLAGS := $(CXXFLAGS) $(COMPILE_FLAGS) $(DCOMPILE_FLAGS)
debug: export LDFLAGS := $(LDFLAGS) $(LINK_FLAGS) $(DLINK_FLAGS)

# Build and output paths
release: export BUILD_PATH := build/release
release: export BIN_PATH := bin/release
debug: export BUILD_PATH := build/debug
debug: export BIN_PATH := bin/debug

# Macros for timing compilation
TIME_FILE = $(dir $@).$(notdir $@)_time
START_TIME = date '+%s' > $(TIME_FILE)
END_TIME = read st < $(TIME_FILE) ; \
	$(RM) $(TIME_FILE) ; \
	st=$$((`date '+%s'` - $$st - 86400)) ; \
	echo `date -u -d @$$st '+%H:%M:%S'`

# Standard release build
release: dirs
	@echo "Beginning release build v$(VERSION_STRING)"
	@$(START_TIME)
	@$(MAKE) all --no-print-directory
	@echo -n "Total build time: "
	@$(END_TIME)

# Debug build for gdb debugging
debug: dirs
	@echo "Beginning debug build v$(VERSION_STRING)"
	@$(START_TIME)
	@$(MAKE) all --no-print-directory
	@echo -n "Total build time: "
	@$(END_TIME)

# Create the directories used in the build
dirs:
	@echo "Creating directories"
	@mkdir -p $(dir $(OBJECTS))
	@mkdir -p $(BIN_PATH)

all: $(BIN_PATH)/$(BIN_NAME)

# Find all source files in the source directory
SOURCES = $(shell find $(SRC_PATH)/ -name '*.$(SRC_EXT)')
# Set the object file names, with the source directory stripped
# from the path, and the build path prepended in its place
OBJECTS = $(SOURCES:$(SRC_PATH)/%.$(SRC_EXT)=$(BUILD_PATH)/%.o)

$(BIN_PATH)/$(BIN_NAME): $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(STRIP) $(BIN_PATH)/wsdiscovery
	cp $(BIN_PATH)/wsdiscovery $(BIN_PATH)/ws-client

$(BUILD_PATH)/%.o: %.$(SRC_EXT)
	@echo "Compiling"
	$(CC) $(CXXFLAGS) $(INCLUDES) -MP -MMD -c $< -o $@

clean:	
	@$(RM) -r build
	@$(RM) -r bin
