# Run all test files
test: lua/plenary.nvim lua/telescope.nvim
	@nvim \
		--headless \
		--noplugin \
		-u tests/minimal_init.vim \
		-c "PlenaryBustedDirectory tests { minimal_init = 'tests/minimal_init.vim' }"
.PHONY: test

static-analysis: luacheck
.PHONY: static-analysis

luacheck:
	luacheck lua tests

lua/plenary.nvim:
	git clone \
		--filter=blob:none \
		https://github.com/nvim-lua/plenary.nvim $@

lua/telescope.nvim:
	git clone \
		--filter=blob:none \
		https://github.com/nvim-telescope/telescope.nvim $@
