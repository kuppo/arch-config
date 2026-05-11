return {
	host = "vm",
	description = "My test vm",
	import = {
		"hosts/shared/default.lua",
	},
	enabled_modules = {
		"kernel",
		"firmware/cpu_gpu",
		"bootloader/systemd-boot",
		"pkgs_mods/git",
	},
	packages = {
		"neovim",
	},
	update_hooks = {
		pre_update = "scripts/pre_update.sh",
		behavior = "ask",
	},
}
