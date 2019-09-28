# SimpleTrail: Plugin API Docs

# Overview
The SimpleTrail plugin can be used in your Corona project. It allows you to attach a trail to a display object.

This repository contains a Corona project with 5 different examples showing what you can achieve with the plugin. You can preview an HTML5 version here : http://honeyponey.fr/SHARED/SimpleTrail/

# Project Configuration
## Corona Store Activation
In order to use this plugin, you must activate the plugin at the Corona Store.

## SDK
When you build using the Corona Simulator, the server automatically takes care of integrating the plugin into your project.

All you need to do is add an entry into a plugins table of your build.settings. The following is an example of a minimal build.settings file:

```
settings =
{
	plugins =
	{
		-- key is the name passed to Lua's 'require()'
		["plugin.SimpleTrail"] =
		{
			-- required
			publisherId = "com.honeyponeygames",
		},
	},
}
```

# Functions

## newTrail( [optionalTable] )
```
local trail = SimpleTrail.newTrail()
```
This is how a basic trail is created.
Some parameters can be added with an optionnal table to create a more complexe trail like this:

```
local trailTouch = SimpleTrail.newTrail({tex = "trail_touch.png", numPoints = 20, width = 18, widthFinal = 0, sharp = true})
```

### Parameters:
`numPoints` (**Number**) : number of last keyframes positions used to record the trail. The bigger the number, the longer the trail.

`tex` (**String**) : filename of the trail texture (default is `nil`).

`width` (**Number**) : width of the trail (default is `20`).

`widthFinal` (**Number**) : final width of the trail (if ommited, `widthFinal` = `width`)

`offsetX` (**Number**) : X offset component of the trail (default is `0`).

`offsetY` (**Number**) : Y offset component of the trail (default is `0`).

`alpha` (**Number**) : Alpha of the display object trail (default is `1`).

`scrollSpeed` (**Number**) : Use this parameter to scroll the texture of the trail (default is `0`). Requires power of 2 texture file.

`blendMode` (**String**) : Blend mode similar to Corona API (default is `"normal"`).

`isVisible` (**Boolean**) : Use this to hide/show the trail (default is `true`). The trail calculation will be done but not rendered.

`sharp` (**Boolean**) : If true, the start of the trail is a dot and not a segment (default is `false`).

`color` (**Table**) : color table similar to Corona colors. {r,g,b,a} or {r,g,b} or {c} (default is {`1`, `1`, `1`, `1`}).

`color_r` (**Number**) : Red component of trail color (default is `1`).

`color_g` (**Number**) : Green component of trail color (default is `1`).

`color_b` (**Number**) : Blue component of trail color (default is `1`).

`color_a` (**Number**) : Alpha component of trail color (default is `1`).

### NOTES:
* All of these parameters except `numPoints`, `tex` and `color` can be accessed and changed dynamically but might requires another call of `trail:update()` to be effective.
* You can change color dynamically by using `trail:setFillColor(...)` method or by changing `color_r`, `color_g`, `color_b`, `color_a` directly.
* You cannot change `scrollSpeed` if you did not initialized the trail with this parameter specified. Althought, you might want a normal trail to scroll only after a moment, so you just have to initialized with `scrollSpeed` equal to 0 so that the plugin understands this will be a scrolling trail and can initialize texture properly.

# Methods

## trail:update(object, [parent])
```
trail:update(object, parent)
```
This method actually draws the trail according to `object` last positions to the front of `parent` display group. Use this inside an enterFrame event as the render will be refreshed every frame according to the new `object` keyframe position.

### Parameters:
`object` (**GroupObject**) : the display object you want the trail to be attached.

`parent` (**GroupObject**) : the display group where you want your trail to be rendered. If ommited the trail will be added in `object.parent` display group.


## trail:setTexture(filePath)
```
trail:setTexture(filePath)
```
### Parameters:
`filePath` (**String**) : filename of the new texture


## trail:setFillColor(...)
Change the color of the trail. Similar to Corona `:setFillColor()` function.
```
trail:setFillColor(r,g,b,a)
```
or
```
trail:setFillColor(r,g,b)
```
or
```
trail:setFillColor(c)
```


## trail:toFront()
```
trail:toFront()
```
Put the trail to the front of it's parent display group.


## trail:toBack()
```
trail:toBack()
```
Put the trail to the back of it's parent display group.


## trail:clear()
```
trail:clear()
```
Remove the trail from it's parent display group.

# Limitations
* If the approximate center of the trail is outside of the screen, the all trail will be hidden because of the Corona autocull feature.
* You can't use the same texture file for a scrolling trail and a non scrolling trail.

