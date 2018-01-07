;
;    Cart64 Maker 
;    (c) 2018 Marcelo Lv Cabral <https://github.com/lvcabral>
; 	 Based on code from project Kobo64
;    (c) 2013 Soci/Singular (soci@c64.rulez.org)
;
;    This program is free software; you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation; either version 2 of the License, or
;    (at your option) any later version.
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;
;    You should have received a copy of the GNU General Public License
;    along with this program; if not, write to the Free Software
;    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;
GAME 		= "<Game Name>"
COPYRIGHT 	= "Copyright (C) <Year> <Author Name>"
WEBSITE		= "http://<game website>"
LICENSETYPE	= "License MIT:"
LICENSEURL  = "<https://opensource.org/licenses/MIT>"

		.text "c64 cartridge   "
		.byte $00,$00		;header length
		.byte $00,$40		;header length
		.word $0001		;version
		.word $0000		;crt type
		.byte $00		;extrom line
		.byte $00		;game line
		.byte $00,$00,$00,$00,$00,$00;unused
		.text GAME 
		.text format(" v%.1f", VERSION)
name
		.fill ($0040-name),0
		.text "chip"
		.byte $00,$00,$40,$10	;chip length?
		.byte $00,$00		;chip type
		.byte $00,$00		;bank
		.byte $80,$00		;adress
		.byte $40,$00		;length

		.logical $8000
		.word launcher		;cold start
		.word launcher		;warm start
		.byte $c3		;c
		.byte $c2		;b
		.byte $cd		;m
		.byte $38		;8
		.byte $30		;0

launcher
		lda #$37
		sta $01
		lda #$2f
		sta $00
		lda $d011
		and #$ef
		sta $d011
		ldx #(starter_end-starter_start)
loop1		lda starter_start,x
		sta $100,x
		dex
		bpl loop1
		lda #$16
		sta $d018
		lda #0
		sta $d01a
		sta $d015
		sta $d020
		sta $d021
		sta $d418
		sta $dd02
		tax
		tay
-		sta $d800+range(4)*$100,x
		inx
		bne -
		lda #$7f
		sta $dc0d
		sta $dd0d
		sta $d019
		bit $dc0d
		bit $dd0d
		lda #8
		sta $d016
		jmp $100

note		.proc
		.enc "screen"
		;	 0123456789012345678901234567890123456789
		.shiftl GAME, format(" v%.1f", VERSION)
		.shiftl COPYRIGHT
		.shiftl WEBSITE
		.shiftl " "
		.shiftl LICENSETYPE
		.shiftl LICENSEURL
		.shiftl " "
		.shiftl "This is free software: you are free to"
		.shiftl "change and redistribute it.  There is NO"
		.shiftl "WARRANTY, to the extent permitted by law"
		.byte 0
		.enc "none"
		.pend
;---------------------------------
starter_start	.logical $100
-		lda a+2
		eor #$04^$d8
		sta b+2
c		lda note,x
		beq end
		inx
		bne +
		inc c+2
+		lsr
a		sta $400+7*40,y
		lda #1
b		sta $d800+7*40,y
		iny
		bcc c
		ldy #0
		lda a+1
		adc #40-1
		sta a+1
		sta b+1
		bcc -
		inc a+2
		bcs -
end
		lda #27
		sta $d011

		ldx #$40		;64 pages = 256 * 64 = 16384 Bytes
		ldy #0
loop
src		lda exomized_data,y
dst		sta $80b,y
		iny
		bne loop
		inc src+2
		inc dst+2
		dex
		bne loop
		jmp $80b
		.here
starter_end
;----------------------------------
exomized_data	.binary "game.prg",12
main_file_end
		.fill ($c000-main_file_end),$ff
		.here
