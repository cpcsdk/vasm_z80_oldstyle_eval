.PHONY: test_perso  test_public
ALL: test_daily

# Launch the test with the vasm version of my machine
test_perso:
	python vasm_eval.py 

# Launch the test with the public version of vasm
test_daily:
	$(MAKE) __test__really__ VASM_URL=http://sun.hasenbraten.de/vasm/daily/vasm.tar.gz 


# Launch the test with a specific version
test_version_1.7c:
	$(MAKE) __test__really__ VASM_URL=http://server.owl.de/~frank/tags/vasm1_7c.tar.gz

test_version_1.7b:
	$(MAKE) __test__really__ VASM_URL=http://server.owl.de/~frank/tags/vasm1_7b.tar.gz



__test__really__:
	-rm -rf vasm
	wget $(VASM_URL) -O vasm.tar.gz
	tar -xvzf vasm.tar.gz
	rm vasm.tar.gz
	cd vasm && make CPU=z80 SYNTAX=oldstyle
	python vasm_eval.py vasm/vasmz80_oldstyle | tee current_state.txt
	rm -rf vasm

update_current_state:
	$(MAKE) test_public
	git add current_state.txt
	-git commit -m "Update log results with current vasm version"



THIRD_PARTIES_FILES_GOOD=thirdparties/vasmz80_testcases/z80validopcodes.asm 
include_third_parties:
	cd 
	for file in $(THIRD_PARTIES_FILES); \
		do \
		cat $$file | sed -e 's/\.section/section/' > good/$$(basename $$file) ; \
		cp $$(dirname $$file)/$$(basename -s 'asm' $$file).bin 

