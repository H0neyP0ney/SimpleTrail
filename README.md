# SimpleTrail API Docs

# Overview

# Project Configuration

Corona Store Activation
In order to use this plugin, you must activate the plugin at the Corona Store.

SDK
When you build using the Corona Simulator, the server automatically takes care of integrating the plugin into your project.

All you need to do is add an entry into a plugins table of your build.settings. The following is an example of a minimal build.settings file:

settings =
{
	plugins =
	{
		-- key is the name passed to Lua's 'require()'
		["plugin.terrain"] =
		{
			-- required
			publisherId = "net.oxonline",
		},
	},
}
