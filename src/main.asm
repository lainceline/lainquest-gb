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
    nop

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
    db " " ; Padding to ensure 16 bytes total for the title
; Manufacturer code (4 characters)
    db "0000"
; CGB flag
    db $80 ; Supports CGB functions, but works on old Game Boys
; New licensee code (2 characters)
    db $33 ; Backward compatibility
; SGB flag
    db $03 ; Super Game Boy functions
; Cartridge type
    db $00 ; ROM only
; ROM size
    db $00 ; 32KB ROM
; RAM size
    db $00 ; No external RAM
; Destination code
    db $00 ; Japanese
; Old licensee code
    db $00 ; Use new licensee code
; Mask ROM version number
    db $00 ; Version 1.0
; Header checksum
    db $00 ; Header checksum (calculated later)
; Global checksum
    dw $0000 ; Global checksum (calculated later)

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
    ; Turn the LCD off
    ld a, $00
    ldh [$FF40], a

    ; Load graphics
    call LoadGraphics

    ; Set up the background tile map
    call SetBackgroundTiles

    ; Turn the LCD on
    ld a, $91       ; $91 = 10010001 in binary (LCD on, BG on)
    ldh [$FF40], a

    ; Initialize sprite position
    ld hl, SpriteXPosition
    ld [hl], $80   ; Starting X position
    inc hl
    ld [hl], $80   ; Starting Y position

    ; TODO: Add other hardware initialization code here
    ret

Update:
    ; Update game state
    call ReadInput

    ; Get button state
    ld a, [ButtonState]

    ; Example: Move a sprite based on input
    ; Assume HL points to the sprite's X position in memory
    ld hl, SpriteXPosition  ; Load sprite X position address into HL

    bit 5, a  ; Check if LEFT button is pressed (bit 5)
    jr z, CheckRight
    dec [hl]       ; Move left if left button pressed
CheckRight:
    bit 4, a  ; Check if RIGHT button is pressed (bit 4)
    jr z, CheckUp
    inc [hl]       ; Move right if right button pressed
CheckUp:
    bit 6, a  ; Check if UP button is pressed (bit 6)
    jr z, CheckDown
    inc hl         ; Point to Y position
    dec [hl]       ; Move up if up button pressed
    dec hl         ; Point back to X position
CheckDown:
    bit 7, a  ; Check if DOWN button is pressed (bit 7)
    jr z, EndUpdate
    inc hl         ; Point to Y position
    inc [hl]       ; Move down if down button pressed
    dec hl         ; Point back to X position

EndUpdate:
    ret

Draw:
    ; Draw graphics
    call DrawGraphics
    ret

SECTION "Game Data", WRAM0
SpriteXPosition:
    ds 1  ; Reserve 1 byte for storing sprite X position
SpriteYPosition:
    ds 1  ; Reserve 1 byte for storing sprite Y position
