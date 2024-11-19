# Run all test files
test: lua/plenary.nvim lua/telescope.nvim
	nvim \
		--headless \
		--noplugin \
		-u scripts/minimal_init.vim \
		-c "PlenaryBustedDirectory lua/tests { minimal_init = './scripts/minimal_init.vim' }"

lua/plenary.nvim:
	git clone \
		--filter=blob:none \
		https://github.com/nvim-lua/plenary.nvim $@

lua/telescope.nvim:
	git clone \
		--filter=blob:none \
		https://github.com/nvim-telescope/telescope.nvim $@
