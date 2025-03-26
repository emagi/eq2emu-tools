# Compiler and flags
NVCC = nvcc
CXX = g++
CXXFLAGS = -O3 -arch=sm_86 -Wall -std=c++17
#CXXFLAGS = -O2 -Wall -std=c++17
LDFLAGS = -lcudart

# CUDA source and object files
SRC = bias.cu
OBJ = bias.o

# Executable name
TARGET = bias

# Default target
all: $(TARGET)

# Compile CUDA file to object file
$(OBJ): $(SRC)
	$(NVCC) -c $(SRC) -o $(OBJ)

# Link object file to create the executable
$(TARGET): $(OBJ)
	$(NVCC) $(OBJ) -o $(TARGET) $(LDFLAGS)

# Clean the generated files
clean:
	rm -f $(OBJ) $(TARGET)

.PHONY: all clean
