# Run all test files
test: lua/plenary.nvim lua/telescope.nvim luacheck
	@nvim \
		--headless \
		--noplugin \
		-u scripts/minimal_init.vim \
		-c "PlenaryBustedDirectory lua/tests { minimal_init = './scripts/minimal_init.vim' }"

luacheck:
	luacheck lua scripts

lua/plenary.nvim:
	git clone \
		--filter=blob:none \
		https://github.com/nvim-lua/plenary.nvim $@

lua/telescope.nvim:
	git clone \
		--filter=blob:none \
		https://github.com/nvim-telescope/telescope.nvim $@
