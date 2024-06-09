; graphics.asm

; Section for graphics data in ROM
SECTION "Graphics Data", ROM0

; Example tile data (16 bytes per 8x8 tile)
TileData:
    ; Tile 0: Empty tile (all 0s)
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    
    ; Tile 1: Checkerboard pattern
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00

; Example background tile map (32x32 tiles)
BackgroundMap:
    rept 32 * 32
    db $01  ; Use the checkerboard tile
    endr

; Section for graphics code in ROM
SECTION "Graphics Code", ROM0

LoadGraphics:
    ; Load tile data into VRAM
    ld hl, TileData        ; Source address (in ROM)
    ld de, $8000           ; Destination address (VRAM)
    ld bc, 32              ; Number of bytes to transfer (2 tiles * 16 bytes each)
    call DmaTransfer
    ret

SetBackgroundTiles:
    ; Load background map data into VRAM
    ld hl, BackgroundMap   ; Source address (in ROM)
    ld de, $9800           ; Destination address (BG Map in VRAM)
    ld bc, 32 * 32         ; Number of bytes to transfer (32x32 tiles)
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
    ret
