
# VDebug

Library to debug in `Armory3D` / `Iron`. You can draw your debug infos on the screen like a `logger`.

## Installation

- Locate the `.blend` file you are working with
- Create `Libraries` folder alongside your `.blend` file
- Clone this repository using `git clone https://github.com/armory3d/armory3D-VDebug` into `Libraries` folder
- Restart Blender and load your `.blend`

## Usage

* enable `arm_debug` flag
* call `vdebug.VDebug.*`

```haxe
package arm;

import kha.Color;
import iron.math.Vec4;

#if arm_debug
import vdebug.VDebug;
#end

class DebugTrait extends iron.Trait {
	public function new() {
		super();

		notifyOnUpdate(function() {
			var source = new Vec4(0,0,0);
			var dest = new Vec4(0,0,10);
			var level = 10;
			#if arm_debug
			VDebug.line(source, dest, Color.Red, 1);
			VDebug.point(source, Color.Blue, 5);
			VDebug.message("my message");
			VDebug.variable("level", level);
			#end
		});
	}
}
```
 
 
