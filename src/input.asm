; input.asm

; Define button masks
DEF BTN_A      EQU $01
DEF BTN_B      EQU $02
DEF BTN_SELECT EQU $04
DEF BTN_START  EQU $08
DEF BTN_RIGHT  EQU $10
DEF BTN_LEFT   EQU $20
DEF BTN_UP     EQU $40
DEF BTN_DOWN   EQU $80

; Section for input code in ROM
SECTION "Input Code", ROM0

ReadInput:
    ; Read the button states from register $FF00
    ld a, $FF
    ld [$FF00], a
    ld a, [$FF00]
    cpl
    and $3F   ; Mask upper 2 bits

    ; Store the button states in memory
    ld [ButtonState], a
    ret

SECTION "Input Data", WRAM0
ButtonState:
    ds 1  ; Reserve 1 byte for storing button state
