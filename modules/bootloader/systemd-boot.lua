return {
	packages = {},
	description = "Systemd bootloader",
	post_install_hook = "scripts/systemd_boot.sh",
	hook_behavior = "once",
}
