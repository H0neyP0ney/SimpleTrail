# SimpleTrail API Docs

# Overview
The SimpleTrail plugin can be used in your Corona project. It allows you to attach a trail to a display object.

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

### newTrail( [optionnalTable] )
```
local trail = SimpleTrail.newTrail()
```
This is how a basic trail is created.
Some parameters can be added with an optionnal table to create a more complexe trail like this:

```
local trailTouch = SimpleTrail.newTrail({tex = "trail_touch.png", numPoints = 20, width = 18, widthFinal = 0, sharp = true})
```

#### Parameters
`numPoints` (**Number**) : this is the keyframes 

`tex` (**String**) : filename of the trail texture

`width` (**Number**) : width of the trail

`widthFinal` (**Number**) : final width of the trail (if ommited, `widthFinal` = `width`)

`offsetX` (**Number**) : width of the trail

`offsetY` (**Number**) : width of the trail

`alpha` (**Number**) : width of the trail

`scrollSpeed` (**Number**) : width of the trail

`blendMode` (**String**) : width of the trail

`isVisible` (**Boolean**) : width of the trail

`sharp` (**Number**) : width of the trail

All of these parameters can be changed dynamically but might requires another call of `trail:update()` to be effective.

# Methods

### trail:update(object, parent)
```
trail:update(object, parent)
```
#### Parameters
`object` (**GroupObject**) : the object you want the trail to follow

`parent` (**GroupObject**) : the display group where you want your trail to be rendered. You can use the default corona display object display.getCurrentStage() or object.parent

### trail:setTexture(filePath)
```
trail:setTexture(filePath)
```
#### Parameters
`filePath` (**String**) : filename of the new texture

### trail:setFillColor(...)
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

### trail:toFront()
```
trail:toFront()
```
Put the trail to the front of it's parent display group.

### trail:toBack()
```
trail:toBack()
```
Put the trail to the back of it's parent display group.

### trail:clear()
```
trail:clear()
```
Remove the trail from it's parent display group.
