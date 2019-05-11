screenib:
	cp cc65.dsk ibxII.dsk
	echo '10 PRINT CHR$$(4)"BRUN IBXII"' > loader.txt
	tokenize_asoft <loader.txt > ibxII_loader
	dos33 ibxII.dsk SAVE A ibxII_loader HELLO
	ca65 -t apple2 -D SCREENIB ibxII.s -o ibxII.o
	ld65 -o ibxII.bin ibxII.o -C apple2.cfg
	dos33 ibxII.dsk SAVE B ibxII.bin IBXII
	ca65 -t apple2 hvoff.s -o hvoff.o
	ld65 -o hvoff.bin hvoff.o -C apple2.cfg
	dos33 ibxII.dsk SAVE B hvoff.bin HVOFF
	ca65 -t apple2 hvon.s -o hvon.o
	ld65 -o hvon.bin hvon.o -C apple2.cfg
	dos33 ibxII.dsk SAVE B hvon.bin HVON
	rm ibxII_loader

withspectrum:
	cp cc65.dsk ibxII-D.dsk
	echo '10 PRINT CHR$$(4)"BRUN IBXII-D"' > loader.txt
	tokenize_asoft <loader.txt > ibxII_loader
	dos33 ibxII-D.dsk SAVE A ibxII_loader HELLO
	ca65 -t apple2 -D DEMO ibxII.s -o ibxII-D.o
	ld65 -o ibxII-D.bin ibxII-D.o -C apple2.cfg
	dos33 ibxII-D.dsk SAVE B ibxII-D.bin IBXII-D
	ca65 -t apple2 hvoff.s -o hvoff.o
	ld65 -o hvoff.bin hvoff.o -C apple2.cfg
	dos33 ibxII-D.dsk SAVE B hvoff.bin HVOFF
	ca65 -t apple2 hvon.s -o hvon.o
	ld65 -o hvon.bin hvon.o -C apple2.cfg
	dos33 ibxII-D.dsk SAVE B hvon.bin HVON
	rm ibxII_loader

measure:
	cp cc65.dsk ibxII-M.dsk
	tokenize_asoft <measurement-loader.txt > ibxII_loader
	dos33 ibxII-M.dsk SAVE A ibxII_loader HELLO
	ca65 -t apple2 -D MEASUREONLY ibxII.s -o ibxII-M.o
	ld65 -o ibxII-M.bin ibxII-M.o -C apple2.cfg
	dos33 ibxII-M.dsk SAVE B ibxII-M.bin IBXII-M
	ca65 -t apple2 hvoff.s -o hvoff.o
	ld65 -o hvoff.bin hvoff.o -C apple2.cfg
	dos33 ibxII-M.dsk SAVE B hvoff.bin HVOFF
	ca65 -t apple2 hvon.s -o hvon.o
	ld65 -o hvon.bin hvon.o -C apple2.cfg
	dos33 ibxII-M.dsk SAVE B hvon.bin HVON
	dsk2nib ibxII-M.dsk ibxII-M.nib
	rm ibxII_loader

clean:
	rm -f ibxII_loader
	rm -f ibxII.o ibxII.bin ibxII.dsk 
	rm -f ibxII-D.o ibxII-D.bin ibxII-D.dsk 
	rm -f ibxII-M.o ibxII-M.bin ibxII-M.dsk ibxII-M.nib

