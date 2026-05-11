return {
	host = "to_be_changed",
	packages = {
		"fzf",
		"timeshift",
		"arch-install-scripts",
		"dcli-arch-git",
		"archlinuxcn-keyring",
		"base-devel",
	},

	config_backups = {
		enabled = true,
		max_backups = 5,
	},

	system_backups = {
		enabled = true,
		backup_on_sync = true,
		backup_on_update = true,
		tool = "timeshift",
		snapper_config = "root",
		max_backups = 5,
	},

	flatpak_scope = "user",
	auto_prune = false,

	aur_helper = "yay",

	update_hooks = {
		pre_update = "scripts/pacman_conf.sh",
		behavior = "once",
	},
}
