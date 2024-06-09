# Makefile

# Define the assembler and linker
AS = rgbasm
LD = rgblink
FIX = rgbfix

# Define the source files and output file
SOURCES = src/main.asm
OBJECTS = $(SOURCES:.asm=.o)
OUTPUT = build/game.gb

# Build the Game Boy ROM
all: $(OUTPUT)

$(OUTPUT): $(OBJECTS)
	$(LD) -o $(OUTPUT) $(OBJECTS)
	$(FIX) -v -p 0 $(OUTPUT)

%.o: %.asm
	$(AS) -o $@ $<

# Clean up the build files
clean:
	rm -f build/*.o
	rm -f $(OUTPUT)
