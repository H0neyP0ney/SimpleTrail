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

### newTrail
```
local trail = SimpleTrail.newTrail()
```
This is how a basic trail is created.
Some parameters can be added with an optionnal table to create a more complexe trail like this:

```
local trailTouch = SimpleTrail.newTrail({tex = "trail_touch.png", numPoints = 20, width = 18, widthFinal = 0, sharp = true})
```

#### Parameters
`numPoints` (**number**) : this is the keyframes 

`tex` (**string**) : filename of the trail texture

`width` (**string**) : width of the trail

`widthFinal` (**string**) : final width of the trail (if ommited, `widthFinal` = `width`)

### update
```
trail:update(object, layer)
```

#### Parameters
`object` (GroupObject) : this is the keyframes

`layer` (GroupObject) : the display group where you want your trail to be rendered. You can use the default corona display object display.getCurrentStage() or object.parent

### setTexture
```
trail:setTexture(filePath)
```

#### Parameters
`filePath` (**String**) : filename of the new texture

### setFillColor
Change the color of the trail. Similar to Corona `:setFillColor()` function.
```
trail:setFillColor(r,g,b,a)
```
or
```
trail:setFillColor(c)
```
or
```
trail:setFillColor(r,g,b)
```

### toFront
```
trail:toFront()
```
Put the trail to the front of it's parent display group.

### toBack
```
trail:toBack()
```
Put the trail to the back of it's parent display group.

