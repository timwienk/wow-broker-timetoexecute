local name, addon = ...
local options = addon:NewModule('Options')

-- Localise global variables
local gsub, lower = string.gsub, string.lower

local defaultOptions = {
	core = {
		refreshTime = 0.2,
		executePercentage = 35,
		useFocus = true
	},
	estimate = {
		historyCount = 120,
		historyTime = 20
	}
}

function options:OnInitialize()
	self.db = LibStub('AceDB-3.0'):New(name .. 'DB', {profile = defaultOptions}, true).profile

	self:InitializeConfig()
end

function options:MakeGetter(group)
	local function get(key)
		return self.db[group][key.arg]
	end

	return get
end

function options:MakeSetter(group)
	local function set(key, value)
		self.db[group][key.arg] = value
		addon:Publish('UPDATE_OPTIONS', group, key.arg, value)
	end

	return set
end

function options:InitializeConfig()
	local L = addon.L

	local config = {
		type = 'group',
		name = name,
		args = {
			config = {
				order = 1,
				type = 'execute',
				guiHidden = true,
				name = L['Open configuration interface'],
				func = self.Open
			},

			core = {
				order = 2,
				type = 'group',
				inline = true,
				name = L['Core options'],
				get = options:MakeGetter('core'),
				set = options:MakeSetter('core'),
				args = {
					refresh = {order=1, type='range', name=L['Refresh time (seconds)'], arg='refreshTime', min=0.1, max=2, step=0.01, bigStep=0.1},
					execute = {order=2, type='range', name=L['Execute percentage'], arg='executePercentage', min=5, max=95, step=0.1, bigStep=5},
					focus = {order=3, type='toggle', name=L['Use focus target'], arg='useFocus'}
				}
			},

			estimate = {
				order = 3,
				type = 'group',
				inline = true,
				name = L['Estimation options'],
				get = options:MakeGetter('estimate'),
				set = options:MakeSetter('estimate'),
				args = {
					historytime = {order=1, type='range', name=L['History time (seconds)'], arg='historyTime', min=5, max=120, step=1, bigStep=5},
					historycount = {order=2, type='range', name=L['Max history count'], arg='historyCount', min=20, max=500, step=1, bigStep=10}
				}
			}
		}
	}

	LibStub('AceConfig-3.0'):RegisterOptionsTable(name, config, gsub(lower(name), '^broker_', ''))
	LibStub('AceConfigDialog-3.0'):AddToBlizOptions(name)
end

function options.Open()
	LibStub('AceConfigDialog-3.0'):Open(name)
end
