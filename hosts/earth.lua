return {
	host = "earth",
	description = "Legion laptop",
	import = {
		"hosts/shared/default.lua",
	},
	enabled_modules = {
		"chassises/kernel",
		"chassises/firmware/cpu_gpu",
		"pkgs_mods/git",
	},
	update_hooks = {
		pre_update = "scripts/pre_update.sh",
		behavior = "once",
	},
}
