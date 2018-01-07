# Cart64 Maker
Tool to make a Commodore 64 16Kb cartridge .crt file from a .prg file

## Introduction
I was looking into a simple way to generate a C64 cartrige from an assembled (uncompressed) .prg file and could not found 
anything easy and ready to use. 
By looking at the great [Kobo64 project source code](https://sourceforge.net/projects/kobo64/), I noticed they put together a very simple and ingenuous way to 
generate a .crt file using exomizer (version 1.x) and 64tass. 
So this project is just made of code extracted from that project made generic, so it could be used by everyone. 
Of course I kept all licensing and copyright information as required by the GPLV2.

## How to use it
Simple Steps:

- Copy your .prg file to the repo folder
- Open Makefile and change line 7 from  "space.prg" to your .prg name
- Open crtr.asm and change lines 21 to 25 with your program info
- Run make
- Open the generated file "game.crt" on your favorite emulator to test.

To speed up I uploaded all needed binaries (for Windows only, sorry!).

## Resources used

- [Project Kobo64 by Soci/Singular](https://sourceforge.net/projects/kobo64/)
- [Project 64 Tass by Soci/Singular](https://sourceforge.net/projects/tass64/)
- [GNU Make by Free Software Foundation](https://www.gnu.org/software/make/)
