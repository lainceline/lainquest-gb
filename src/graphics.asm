; graphics.asm

; Section for graphics data in ROM
SECTION "Graphics Data", ROM0

; Example tile data (16 bytes per 8x8 tile)
TileData:
    db $00, $00, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

; Section for graphics code in ROM
SECTION "Graphics Code", ROM0

LoadGraphics:
    ; Set up for DMA transfer to load tile data into VRAM
    ld hl, TileData        ; Source address (in ROM)
    ld de, $8000           ; Destination address (VRAM)
    ld bc, 16              ; Number of bytes to transfer
    call DmaTransfer
    ret

DmaTransfer:
    ; Copy data from ROM to VRAM manually
    push bc
    push hl
    push de
CopyLoop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, CopyLoop
    pop de
    pop hl
    pop bc
    ret

DrawGraphics:
    ; Draw background and sprites
    ; TODO: Add code to draw graphics on the screen
    ret

DrawBackground:
    ; TODO: Add code to draw the background
    ret

DrawSprites:
    ; TODO: Add code to draw sprites
    ret
