return {
	description = "Git configurations.",
	packages = {
		"git",
	},
	dotfiles_sync = true,
	dotfiles = {
		{ source = "config/git", target = "~/.config/git/config" },
	},
}
