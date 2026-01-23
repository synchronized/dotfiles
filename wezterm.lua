local wezterm = require("wezterm")
local act = wezterm.action

-- tmux like 快捷键配置

-- 或者只显示进程名的 basename
wezterm.on("format-tab-title", function(tab)
	local process = tab.active_pane.foreground_process_name:match("([^/\\]+)$") or "term"
	local index = tab.tab_index + 1

	-- 图标映射
	local icons = {
		bash = "",
		zsh = "",
		fish = "",
		pwsh = "",
		nvim = "",
		vim = "",
		python = "",
		node = "",
		docker = "",
		git = "",
		ssh = "",
		mysql = "",
	}

	-- 程序名缩写
	local abbrevs = {
		bash = "sh",
		zsh = "zsh",
		fish = "fs",
		pwsh = "pwsh",
		nvim = "vim",
		vim = "vim",
		python = "py",
		node = "js",
		docker = "dkr",
		git = "git",
		ssh = "ssh",
		mysql = "sql",
	}

	local basename = process
	-- 移除常见扩展名（不区分大小写）
	local extensions = {
		"%.exe",
		"%.EXE",
		"%.bat",
		"%.BAT",
		"%.cmd",
		"%.CMD",
		"%.sh",
		"%.SH",
		"%.ps1",
		"%.PS1",
		"%.dll",
		"%.DLL",
		"%.so",
		"%.SO",
		"%.app",
		"%.APP",
	}

	for _, ext in ipairs(extensions) do
		basename = basename:gsub(ext .. "$", "")
	end

	local icon = icons[basename] or ""
	local text = abbrevs[basename] or basename

	return "" .. index .. ". " .. icon .. " " .. text .. " "
end)

-- 检测操作系统
local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

local keys = {
	-- 发送原始的 Ctrl+a（如果需要保持原功能）
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},

	-- Leader 组合键从这里开始配置
	-- Leader + c: 新建标签页
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	-- Leader + n: 下一个标签页
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},

	-- Leader + p: 上一个标签页
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},

	-- Leader + x: 关闭当前窗格（带确认）
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	-- 快速切换到特定标签页（Alt+数字）
	{
		key = "1",
		mods = "LEADER",
		action = act.ActivateTab(0),
	},
	{
		key = "2",
		mods = "LEADER",
		action = act.ActivateTab(1),
	},
	{
		key = "3",
		mods = "LEADER",
		action = act.ActivateTab(2),
	},
	{
		key = "4",
		mods = "LEADER",
		action = act.ActivateTab(3),
	},
	{
		key = "5",
		mods = "LEADER",
		action = act.ActivateTab(4),
	},
	{
		key = "6",
		mods = "LEADER",
		action = act.ActivateTab(5),
	},
	{
		key = "7",
		mods = "LEADER",
		action = act.ActivateTab(6),
	},
	{
		key = "8",
		mods = "LEADER",
		action = act.ActivateTab(7),
	},
	{
		key = "9",
		mods = "LEADER",
		action = act.ActivateTab(8),
	},

	-- Leader + z: 最大化/恢复窗格（类似 tmux 的 zoom）
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},

	-- ********** 拆分窗格 **********
	-- 垂直拆分（| 符号）
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- 水平拆分（- 符号）
	{
		key = "/",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- 使用 Vim 风格的 hjkl 导航（推荐）
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	-- Leader + [ 进入复制模式（带滚动）
	{
		key = "[",
		mods = "LEADER",
		--action = act.Multiple({
		--	act.CopyMode("ClearSelectionMode"),
		--	act.CopyMode("ClearPattern"),
		--	act.ActivateCopyMode,
		--	act.CopyMode("ClearPattern"),
		--	act.CopyMode("ClearSelectionMode"),
		--}),
		action = wezterm.action_callback(function(window, pane)
			window:perform_action(act.ActivateCopyMode, pane)
			window:perform_action(
				act.Multiple({
					act.CopyMode("AcceptPattern"),
					act.CopyMode("ClearPattern"),
					act.CopyMode("ClearSelectionMode"),
				}),
				pane
			)
		end),
	},
	{
		key = "f",
		mods = "LEADER",
		action = act.Search("CurrentSelectionOrEmptyString"),
	},
}

-- 复制模式配置（类似 tmux 的 copy-mode）
local key_tables = {
	copy_mode = {
		-- 退出复制模式
		{
			key = "Escape",
			action = act.Multiple({
				act.CopyMode("ClearSelectionMode"),
			}),
		},
		{
			key = "q",
			action = act.Multiple({
				act.CopyMode("ClearPattern"),
				act.CopyMode("ClearSelectionMode"),
				act.CopyMode("Close"),
			}),
		},
		{
			key = "c",
			mods = "CTRL",
			action = act.Multiple({
				act.CopyMode("ClearPattern"),
				act.CopyMode("ClearSelectionMode"),
				act.CopyMode("Close"),
			}),
		},

		-- ********** 页面滚动 **********
		{ key = "PageUp", action = act.CopyMode("PageUp") },
		{ key = "PageDown", action = act.CopyMode("PageDown") },
		{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
		{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },

		-- ********** 行滚动 **********
		{ key = "UpArrow", action = act.CopyMode("MoveUp") },
		{ key = "DownArrow", action = act.CopyMode("MoveDown") },
		{ key = "k", action = act.CopyMode("MoveUp") },
		{ key = "j", action = act.CopyMode("MoveDown") },

		-- ********** 字符滚动 **********
		{ key = "LeftArrow", action = act.CopyMode("MoveLeft") },
		{ key = "RightArrow", action = act.CopyMode("MoveRight") },
		{ key = "h", action = act.CopyMode("MoveLeft") },
		{ key = "l", action = act.CopyMode("MoveRight") },

		-- ********** 单词滚动 **********
		{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
		{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },

		-- ********** 快速跳转 **********
		{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
		{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },

		-- ********** 搜索和跳转 **********
		--{ key = "/", mods = "NONE", action = act.CopyMode("ClearPattern") },
		{ key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
		{
			key = "n",
			mods = "NONE",
			action = act.Multiple({
				act.CopyMode("NextMatch"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
		{
			key = "N",
			mods = "SHIFT",
			action = act.Multiple({
				act.CopyMode("PriorMatch"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},

		-- ********** 选择文本 **********
		{ key = " ", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },

		-- 复制选择内容
		{
			key = "y",
			mods = "NONE",
			action = act.Multiple({
				act.CopyTo("ClipboardAndPrimarySelection"),
				act.CopyTo("Clipboard"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
		{
			key = "Enter",
			action = act.Multiple({
				act.CopyTo("ClipboardAndPrimarySelection"),
				act.CopyTo("Clipboard"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},

		{ key = "e", mods = "CTRL", action = act.CopyMode("EditPattern") },
	},

	search_mode = {
		{
			key = "Escape",
			action = act.Multiple({
				act.CopyMode("AcceptPattern"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
		{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
		{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },

		{
			key = "Enter",
			action = act.Multiple({
				act.CopyMode("AcceptPattern"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
		{ key = "e", mods = "CTRL", action = act.CopyMode("EditPattern") },
	},
}

return {
	default_prog = is_windows and { "pwsh.exe" } or { "bash" },

	-- 设置 PowerShell 配置文件路径
	set_environment_variables = {
		POWERSHELL_TELEMETRY_OPTOUT = "1",
	},

	-- 解决 PowerShell 编码问题
	front_end = "WebGpu",
	warn_about_missing_glyphs = false,

	-- 将标签栏放在窗口底部
	tab_bar_at_bottom = true,

	-- 配置 PowerShell 主题
	-- color_scheme = "PowerShell",

	-- 设置 Leader 键（类似 tmux 的 Ctrl+b）
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 5000 },
	keys = keys,
	key_tables = key_tables,

	disable_default_key_bindings = false,
}
