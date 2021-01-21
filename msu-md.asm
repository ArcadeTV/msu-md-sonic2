
;                               | ID | Track | Loop
;--------------------------------------------------- regular:
;Opening Theme                  | 99 |  01   | -
;Options                        | 91 |  02   | 223
;Emerald Hill Zone              | 82 |  03   | 260
;Act Clear                      | 9A |  04   | -
;Chemical Plant Zone            | 8E |  05   | 1049
;Drowning                       | 9F |  06   | -
;Aquatic Ruin Zone              | 87 |  07   | 0
;Casino Night Zone              | 89 |  08   | 121
;Hill Top Zone                  | 86 |  09   | 120
;Mystic Cave Zone               | 8B |  10   | 183
;Oil Ocean Zone                 | 84 |  11   | 469
;Metropolis Zone                | 85 |  12   | 543
;Sky Chase Zone                 | 8D |  13   | 3051
;Wing Fortress Zone             | 8F |  14   | 66
;Death Egg Zone                 | 8A |  15   | 340641
;Robotnik                       | 93 |  16   | 0
;Final Boss                     | 94 |  17   | 392
;Continue?                      | 9C |  18   | -
;Ending Theme                   | 95 |  19   | -
;Staff Roll                     | 9E |  20   | -
;Game Over                      | 9B |  21   | -
;Invincibility                  | 97 |  22   | 90
;Super Sonic                    | 96 |  23   | 0
;1-up                           | 98 |  24   | -
;2 Player Results               | 81 |  25   | -
;Emerald Hill (2 Player)        | 8C |  26   | 127
;Casino Night (2 Player)        | 88 |  27   | 547
;Mystic Cave (2 Player)         | 83 |  28   | 83
;Special Stage                  | 92 |  29   | 782
;Chaos Emerald                  | 9D |  30   | -
;Hidden Palace Zone             | 90 |  31   | 0
;SEGA                           | -- |  32   | -
;--------------------------------------------------- 20% faster:
;Emerald Hill Zone       (fast) | 82 |  33   | 221
;Chemical Plant Zone     (fast) | 8E |  34   | 875
;Aquatic Ruin Zone       (fast) | 87 |  35   | 0
;Casino Night Zone       (fast) | 89 |  36   | 70
;Mystic Cave Zone        (fast) | 8B |  37   | 154
;Oil Ocean Zone          (fast) | 84 |  38   | 391
;Metropolis Zone         (fast) | 85 |  39   | 454
;Sky Chase Zone          (fast) | 8D |  40   | 2543
;Wing Fortress Zone      (fast) | 8F |  41   | 55
;Death Egg Zone          (fast) | 8A |  42   | 544
;Invincibility           (fast) | 97 |  43   | 75
;Emerald Hill (2 Player) (fast) | 8C |  44   | 105
;Casino Night (2 Player) (fast) | 88 |  45   | 144
;Mystic Cave  (2 Player) (fast) | 83 |  46   | 70
;Super Sonic             (fast) | 96 |  47   | 0
;Hill Top Zone           (fast) | 86 |  48   | 100

MCD_STAT 		= $A12020                   ; 0-ready, 1-init, 2-cmd busy
MCD_CMD			= $A12010 
MCD_ARG			= $A12011
MCD_SEEK		= $A12012
MCD_CMD_CK		= $A1201F

v_MSU_counter	equ $FFF100  ; l
v_MSU_1upFlag	equ $FFF108  ; b
v_MSU_lastTrack	equ $FFF110  ; b

Vint_MSUMD:
    addi.b  #1,(v_MSU_lastTrack).l
    tst.b   (v_MSU_1upFlag).l
    beq.s   Vint_MSUMD_return       ; return if flag is 0
    move    (v_MSU_counter).l,d0
    addi.b  #1,d0
    move    d0,(v_MSU_counter).l
Vint_MSUMD_return:
    rts

PlayMusic:
	jsr     findAndPlayTrack
    rts

findAndPlayTrack:
    cmp.b   #MusID_FadeOut,d0       ; --Fades Music Out-----
    beq     msuStop
    cmp.b   #$80,d0                 ; --Music Stops-----
    beq     msuStop
    cmp.b   #$99,d0                 ; Opening Theme
    beq     msuPlayTrack_01
    cmp.b   #$91,d0                 ; Options
    beq     msuPlayTrack_02
    cmp.b   #$82,d0                 ; Emerald Hill Zone
    beq     msuPlayTrack_03
    cmp.b   #$9A,d0                 ; Act Clear
    beq     msuPlayTrack_04
    cmp.b   #$8E,d0                 ; Chemical Plant Zone
    beq     msuPlayTrack_05
    cmp.b   #$9F,d0                 ; Drowning
    beq     msuPlayTrack_06
    cmp.b   #$87,d0                 ; Aquatic Ruin Zone
    beq     msuPlayTrack_07
    cmp.b   #$89,d0                 ; Casino Night Zone
    beq     msuPlayTrack_08
    cmp.b   #$86,d0                 ; Hill Top Zone
    beq     msuPlayTrack_09
    cmp.b   #$8B,d0                 ; Mystic Cave Zone 
    beq     msuPlayTrack_10
    cmp.b   #$84,d0                 ; Oil Ocean Zone
    beq     msuPlayTrack_11
    cmp.b   #$85,d0                 ; Metropolis Zone
    beq     msuPlayTrack_12
    cmp.b   #$8D,d0                 ; Sky Chase Zone
    beq     msuPlayTrack_13
    cmp.b   #$8F,d0                 ; Wing Fortress Zone
    beq     msuPlayTrack_14
    cmp.b   #$8A,d0                 ; Death Egg Zone
    beq     msuPlayTrack_15
    cmp.b   #$93,d0                 ; Robotnik
    beq     msuPlayTrack_16
    cmp.b   #$94,d0                 ; Final Boss
    beq     msuPlayTrack_17
    cmp.b   #$9C,d0                 ; Continue
    beq     msuPlayTrack_18
    cmp.b   #$95,d0                 ; Ending Theme
    beq     msuPlayTrack_19
    cmp.b   #$9E,d0                 ; Staff Roll
    beq     msuPlayTrack_20
    cmp.b   #$9B,d0                 ; Game Over
    beq     msuPlayTrack_21
    cmp.b   #$97,d0                 ; Invincibility
    beq     msuPlayTrack_22
    cmp.b   #$96,d0                 ; Super Sonic
    beq     msuPlayTrack_23
    ;cmp.b   #$98,d0                 ; 1-up
    ;beq     msuPlayTrack_24
    cmp.b   #$81,d0                 ; 2 Player Results
    beq     msuPlayTrack_25
    cmp.b   #$8C,d0                 ; Emerald Hill (2 Player)
    beq     msuPlayTrack_26
    cmp.b   #$88,d0                 ; Casino Night (2 Player)
    beq     msuPlayTrack_27
    cmp.b   #$83,d0                 ; Mystic Cave (2 Player)
    beq     msuPlayTrack_28
    cmp.b   #$92,d0                 ; Special Stage
    beq     msuPlayTrack_29
    cmp.b   #$9D,d0                 ; Chaos Emerald
    beq     msuPlayTrack_30
    cmp.b   #$90,d0                 ; Hidden Palace Zone
    beq     msuPlayTrack_31

    rts	
; End of function PlayMusic

msuPlayTrack_01:                        ; Title
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_01 
        
    move.w  #($1100|1),MCD_CMD          ; send cmd: play track #1, loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_02:                        ; Options
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_02 
        
    move.w  #($1A00|2),MCD_CMD          ; send cmd: play track #2, sloop
	move.l  #($00000000|223),MCD_SEEK	; seek to audio frame 223 when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_03:                        ; Emerald Hill Zone
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_03 
        
    move.w  #($1A00|3),MCD_CMD          ; send cmd: play track #3, sloop
	move.l  #($00000000|260),MCD_SEEK	; seek to audio frame 260 when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_04:                        ; Act Clear
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_04 
        
    move.w  #($1100|4),MCD_CMD          ; send cmd: play track #4, no-loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_05:                        ; Chemical Plant Zone
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_05 
        
    move.w  #($1A00|5),MCD_CMD          ; send cmd: play track #5, sloop
	move.l  #($00000000|1049),MCD_SEEK	; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_06:                        ; Drowning
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_06 
        
    move.w  #($1100|6),MCD_CMD          ; send cmd: play track #6, no-loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_07:                        ; Aquatic Ruin Zone        
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_07 
       
    move.w  #($1200|7),MCD_CMD          ; send cmd: play track #7, loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_08:                        ; Casino Nicht Zone
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_08 
        
    move.w  #($1A00|8),MCD_CMD          ; send cmd: play track #8, sloop
	move.l  #($00000000|121),MCD_SEEK	; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_09:                        ; Hill Top Zone
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_09 
        
    move.w  #($1A00|9),MCD_CMD          ; send cmd: play track #9, sloop
	move.l  #($00000000|120),MCD_SEEK	; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_10:                        ; Mystic Cave Zone
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_10 
        
    move.w  #($1A00|10),MCD_CMD         ; send cmd: play track #10, sloop
	move.l  #($00000000|183),MCD_SEEK	; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_11:                        ; Oil Ocean Zone
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_11 
        
    move.w  #($1A00|11),MCD_CMD         ; send cmd: play track #11, sloop
	move.l  #($00000000|469),MCD_SEEK	; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_12:                        ; Metropolis Zone
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_12 
        
    move.w  #($1A00|12),MCD_CMD         ; send cmd: play track #12, sloop
	move.l  #($00000000|543),MCD_SEEK	; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_13:                        ; Sky Chase Zone
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_13 

    move.w  #($1A00|13),MCD_CMD         ; send cmd: play track #13, sloop
    move.l  #($00000000|3051),MCD_SEEK	; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_14:                        ; Wing Fortress Zone
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_14 
        
    move.w  #($1A00|14),MCD_CMD         ; send cmd: play track #14, sloop
    move.l  #($00000000|66),MCD_SEEK	; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_15:                        ; Death Egg Zone
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_15 

    move.w  #($1A00|15),MCD_CMD         ; send cmd: play track #15, sloop
    move.l  #($00000000|340641),MCD_SEEK; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_16:                        ; Robotnik
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_16 
        
    move.w  #($1200|16),MCD_CMD         ; send cmd: play track #16, loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_17:                        ; Final Boss
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_17 
        
    move.w  #($1A00|17),MCD_CMD         ; send cmd: play track #17, sloop
    move.l  #($00000000|392),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_18:                        ; Continue
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_18 
        
    move.w  #($1100|18),MCD_CMD         ; send cmd: play track #18, no loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_19:                        ; Ending Theme
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_19 
        
    move.w  #($1100|19),MCD_CMD         ; send cmd: play track #19, no loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_20:                        ; Staff Roll
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_20 
        
    move.w  #($1100|20),MCD_CMD         ; send cmd: play track #20, no loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts

msuPlayTrack_21:                        ; Game Over
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_21 
        
    move.w  #($1100|21),MCD_CMD         ; send cmd: play track #21, no loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_22:                        ; Invincibility
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_22 
        
    move.w  #($1A00|22),MCD_CMD         ; send cmd: play track #22, sloop
    move.l  #($00000000|90),MCD_SEEK    ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_23:                        ; Super Sonic
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_23 
        
    move.w  #($1200|23),MCD_CMD         ; send cmd: play track #23, loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_24:                        ; 1-up
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_24 
        
    move.w  #($1100|24),MCD_CMD         ; send cmd: play track #24, no loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_25:                        ; 2 Player Results
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_25 
        
    move.w  #($1100|25),MCD_CMD         ; send cmd: play track #25, loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_26:                        ; Emerald Hill (2 Player)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_26 
        
    move.w  #($1A00|26),MCD_CMD         ; send cmd: play track #26, sloop
    move.l  #($00000000|127),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_27:                        ; Casino Night (2 Player)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_27 
        
    move.w  #($1A00|27),MCD_CMD         ; send cmd: play track #27, sloop
    move.l  #($00000000|547),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_28:                        ; Mystic Cave (2 Player)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_28 
        
    move.w  #($1A00|28),MCD_CMD         ; send cmd: play track #28, sloop
    move.l  #($00000000|83),MCD_SEEK    ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_29:                        ; Special Stage
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_29 
        
    move.w  #($1A00|29),MCD_CMD         ; send cmd: play track #29, sloop
    move.l  #($00000000|782),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_30:                        ; Chaos Emerald
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_30 
        
    move.w  #($1100|30),MCD_CMD         ; send cmd: play track #30, no loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts    

msuPlayTrack_31:                        ; Hidden Palace Zone
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_31 
        
    move.w  #($1200|31),MCD_CMD         ; send cmd: play track #31, loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts    
; ----- end regular Tracks, fast tracks from here -------------------------------

msuPlayTrack_33:                        ; Emerald Hill Zone (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_33 
        
    move.w  #($1A00|33),MCD_CMD         ; send cmd: play track #33, sloop
    move.l  #($00000000|221),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts   
    
msuPlayTrack_34:                        ; Chemical Plant Zone (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_34 
        
    move.w  #($1A00|34),MCD_CMD         ; send cmd: play track #34, sloop
    move.l  #($00000000|875),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_35:                        ; Aquatic Ruin Zone (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_35 
        
    move.w  #($1200|35),MCD_CMD         ; send cmd: play track #35, loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_36:                        ; Casino Night Zone (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_36 
        
    move.w  #($1A00|36),MCD_CMD         ; send cmd: play track #36, sloop
    move.l  #($00000000|70),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_37:                        ; Mystic Cave (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_37 
        
    move.w  #($1A00|37),MCD_CMD         ; send cmd: play track #37, sloop
    move.l  #($00000000|154),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_38:                        ; Oil Ocean Zone (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_38 
        
    move.w  #($1A00|38),MCD_CMD         ; send cmd: play track #38, sloop
    move.l  #($00000000|391),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_39:                        ; Metropolis Zone (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_39 
        
    move.w  #($1A00|39),MCD_CMD         ; send cmd: play track #39, sloop
    move.l  #($00000000|454),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_40:                        ; Sky Chase Zone (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_40 
        
    move.w  #($1A00|40),MCD_CMD         ; send cmd: play track #40, sloop
    move.l  #($00000000|2543),MCD_SEEK  ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_41:                        ; Wing Fortress Zone (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_41 
        
    move.w  #($1A00|41),MCD_CMD         ; send cmd: play track #41, sloop
    move.l  #($00000000|55),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_42:                        ; Death Egg Zone (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_42 
        
    move.w  #($1A00|42),MCD_CMD         ; send cmd: play track #42, sloop
    move.l  #($00000000|544),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_43:                        ; Invincibility (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_43 
        
    move.w  #($1A00|75),MCD_CMD         ; send cmd: play track #43, sloop
    move.l  #($00000000|221),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts

msuPlayTrack_44:                        ; Emerald Hill (2 Player) (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_44 
        
    move.w  #($1A00|44),MCD_CMD         ; send cmd: play track #44, sloop
    move.l  #($00000000|105),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts

msuPlayTrack_45:                        ; Casino Night (2 Player) (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_45 
        
    move.w  #($1A00|45),MCD_CMD         ; send cmd: play track #45, sloop
    move.l  #($00000000|144),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_46:                        ; Mystic Cave  (2 Player) (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_46 
        
    move.w  #($1A00|46),MCD_CMD         ; send cmd: play track #46, sloop
    move.l  #($00000000|70),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_47:                        ; Super Sonic (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_47 
        
    move.w  #($1200|47),MCD_CMD         ; send cmd: play track #47, loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuPlayTrack_48:                        ; Hill Top Zone (fast)
    tst.b   MCD_STAT
    bne.s   msuPlayTrack_48 
        
    move.w  #($1A00|48),MCD_CMD         ; send cmd: play track #48, sloop
    move.l  #($00000000|100),MCD_SEEK   ; seek to audio frame when complete
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    

msuPlaySega:                            ; 32: Sega Logo Sound
    tst.b   MCD_STAT
    bne.s   msuPlaySega 
        
    move.w  #($1100|32),MCD_CMD         ; send cmd: play track #7, no loop
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts   
; ----- end aditional Tracks

msuStop:
    tst.b   MCD_STAT
    bne.s   msuStop 
    move.w  #($1300|40),MCD_CMD         ; send cmd: pause track
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts
    
msuResume:
    tst.b   MCD_STAT
    bne.s   msuResume 
    move.w  #($1400),MCD_CMD            ; send cmd: resume track
    addq.b  #1,MCD_CMD_CK               ; Increment command clock
    rts