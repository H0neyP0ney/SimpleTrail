# SimpleTrail API Docs

# Overview

# Project Configuration

Corona Store Activation
In order to use this plugin, you must activate the plugin at the Corona Store.

SDK
When you build using the Corona Simulator, the server automatically takes care of integrating the plugin into your project.

All you need to do is add an entry into a plugins table of your build.settings. The following is an example of a minimal build.settings file:

```
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
```

# Functions

### Create a trail
```
local trail = SimpleTrail.newTrail()
```
This is how a basic trail is created.
Some parameters can be added like this:

```
local trailTouch = SimpleTrail.newTrail({tex = "trail_touch.png", numPoints = 20, width = 18, widthFinal = 0, sharp = true})
```

#### Parameters

`numPoints` (number) : this is the keyframes 

`tex` (string) : filename of the trail texture

`width` (string) : width of the trail

`widthFinal` (string) : final width of the trail (if ommited, `widthFinal` = `width`)

### Change trail color
```
SimpleTrail:setFillColor(r,g,b,a)
```
