.PHONY: test_perso  test_public
ALL: test_public

# Launch the test with the vasm version of my machine
test_perso:
	python vasm_eval.py 

# Launch the test with the public version of vasm
test_public:
	-rm -rf vasm
	wget http://sun.hasenbraten.de/vasm/daily/vasm.tar.gz -O vasm.tar.gz
	tar -xvzf vasm.tar.gz
	rm vasm.tar.gz
	cd vasm && make CPU=z80 SYNTAX=oldstyle
	python vasm_eval.py vasm/vasmz80_oldstyle | tee current_state.txt


update_current_state:
	$(MAKE) test_public
	git add current_state.txt
	-git commit -m "Update log results with current vasm version"
