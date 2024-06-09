; main.asm
; Include other assembly files
INCLUDE "src/graphics.asm"
INCLUDE "src/input.asm"
INCLUDE "src/sound.asm"
INCLUDE "src/combat.asm"
INCLUDE "src/maps.asm"

SECTION "Header", ROM0[$0100]
; Entry point
    jp Start

SECTION "Logo", ROM0[$0104]
; Nintendo logo (must match exactly for Game Boy to run the cartridge)
    db $CE, $ED, $66, $66, $CC, $0D, $00, $0B
    db $03, $73, $00, $83, $00, $0C, $00, $0D
    db $00, $08, $11, $1F, $88, $89, $00, $0E
    db $DC, $CC, $6E, $E6, $DD, $DD, $D9, $99
    db $BB, $BB, $67, $63, $6E, $0E, $EC, $CC
    db $DD, $DC, $99, $9F, $BB, $B9, $33, $3E

SECTION "Header Information", ROM0[$0134]
; Game title (11 characters)
    db "GB RPG DEMO"
    db " "  ; Padding to ensure 16 bytes total for the title
; Manufacturer code (4 characters)
    db "0000"
; CGB flag
    db $80                ; Supports CGB functions, but works on old Game Boys
; New licensee code (2 characters)
    db $33                ; Super Game Boy functions
; SGB flag
    db $03
; Cartridge type
    db $00
; ROM size
    db $00
; RAM size
    db $00
; Destination code
    db $00
; Old licensee code
    db $00
; Mask ROM version number
    db $00
; Header checksum (calculated later)
    db $00
; Global checksum (calculated later)
    dw $0000

SECTION "Main", ROM0[$0150]
Start:
    ; Disable interrupts
    di

    ; Initialize the stack pointer
    ld sp, $FFFE

    ; Initialize Game Boy hardware
    call Init

    ; Enable interrupts
    ei

MainLoop:
    ; Main game loop
    call Update
    call Draw
    jp MainLoop

Init:
    ; Initialize graphics
    call LoadGraphics
    ; TODO: Add other hardware initialization code here
    ret

Update:
    ; TODO: Add game update logic here (e.g., handling input, updating game state, etc.)
    ret

Draw:
    ; TODO: Add drawing logic here (e.g., rendering sprites, backgrounds, etc.)
    ret
