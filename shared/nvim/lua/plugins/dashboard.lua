return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function(_, opts)
			local logo = [[
        _____                     __      ______  __   __                                           __              
      |     \                   |  \    /      \|  \ |  \                                         |  \             
        \▓▓▓▓▓__    __  _______ _| ▓▓_  |  ▓▓▓▓▓▓\ ▓▓_| ▓▓_    ______   ______  _______   ______  _| ▓▓_    ______
          | ▓▓  \  |  \/       \   ▓▓ \ | ▓▓__| ▓▓ ▓▓   ▓▓ \  /      \ /      \|       \ |      \|   ▓▓ \  /      \
     __   | ▓▓ ▓▓  | ▓▓  ▓▓▓▓▓▓▓\▓▓▓▓▓▓ | ▓▓    ▓▓ ▓▓\ ▓▓▓▓▓▓ |  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\ \▓▓▓▓▓▓\\▓▓▓▓▓▓ |  ▓▓▓▓▓▓
    |  \  | ▓▓ ▓▓  | ▓▓\▓▓    \  | ▓▓ __| ▓▓▓▓▓▓▓▓ ▓▓ | ▓▓ __| ▓▓    ▓▓ ▓▓   \▓▓ ▓▓  | ▓▓/      ▓▓ | ▓▓ __| ▓▓    ▓▓
    | ▓▓__| ▓▓ ▓▓__/ ▓▓_\▓▓▓▓▓▓\ | ▓▓|  \ ▓▓  | ▓▓ ▓▓ | ▓▓|  \ ▓▓▓▓▓▓▓▓ ▓▓     | ▓▓  | ▓▓  ▓▓▓▓▓▓▓ | ▓▓|  \ ▓▓▓▓▓▓▓▓
    \ ▓▓    ▓▓\▓▓    ▓▓       ▓▓  \▓▓  ▓▓ ▓▓  | ▓▓ ▓▓  \▓▓  ▓▓\▓▓     \ ▓▓     | ▓▓  | ▓▓\▓▓    ▓▓  \▓▓  ▓▓\▓▓     \
      \▓▓▓▓▓▓  \▓▓▓▓▓▓ \▓▓▓▓▓▓▓    \▓▓▓▓ \▓▓   \▓▓\▓▓   \▓▓▓▓  \▓▓▓▓▓▓▓\▓▓      \▓▓   \▓▓ \▓▓▓▓▓▓▓   \▓▓▓▓  \▓▓▓▓▓▓▓
            ]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"
			opts.config.header = vim.split(logo, "\n")
			opts.theme = "doom"
		end,
	},
}