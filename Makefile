VERSION := 1.0
XFLAGS := -autostartprgmode 1 -autostart-warp +truedrive +cart -VICIIhwscale -VICIIborder 1 -sound
AS := 64tass

all: game.crt

game.prg: space.prg
	exomizer -q -s 2064 -n $< -o $@

game.crt: crtr.asm game.prg
	$(AS) -b -a $< -o $@ -DVERSION=$(VERSION)
