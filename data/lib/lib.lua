-- Core API functions implemented in Lua
dofile('data/lib/core/core.lua')

-- Compatibility library for our old Lua API
dofile('data/lib/compat/compat.lua')

-- Compatibility library for old Lua scripts
dofile('data/lib/old/avatar.lua')
dofile('data/lib/old/function.lua')
dofile('data/lib/old/spells_exausted.lua')
dofile('data/lib/old/spells_functions.lua')
dofile('data/lib/old/spells_level_system.lua')
dofile('data/lib/old/spells_library.lua')
dofile('data/lib/old/exaustion.lua')
dofile('data/lib/old/extra.lua')
dofile('data/lib/old/server_communication.lua')
dofile('data/lib/old/serialize.lua')
dofile('data/lib/old/bend_upgrade.lua')
dofile('data/lib/old/shortcut.lua')
dofile('data/lib/old/translator.lua')
dofile('data/lib/old/position.lua')
dofile('data/lib/old/string.lua')
dofile('data/lib/old/folds.lua')
dofile('data/lib/old/resetquest.lua')
dofile('data/lib/old/forge_system.lua')
dofile('data/lib/old/npc_system.lua')
dofile('data/lib/old/npc_task_system.lua')
dofile('data/lib/old/castle_war.lua')
dofile('data/lib/old/quests_chest.lua')

-- Debugging helper function for Lua developers
dofile('data/lib/debugging/dump.lua')
dofile('data/lib/debugging/lua_version.lua')
