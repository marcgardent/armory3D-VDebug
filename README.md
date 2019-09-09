
# VDebug

Library to debug in `Armory3D` / `Iron`. You can draw your debug infos on the screen like a `logger`.

## Installation

- Locate the `.blend` file you are working with
- Create `Libraries` folder alongside your `.blend` file
- Clone this repository using `git clone https://github.com/armory3d/armory3D-VDebug` into `Libraries` folder
- Restart Blender and load your `.blend`

## Usage

* enable `arm_debug` flag and `import vdebug.VDebug`
* call `vdebug.VDebug.*` in the main loop  `Update`, `LateUpdate`

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
			VDebug.addLine(source, dest, Color.Red, 1);
			VDebug.addPoint(source, Color.Blue, 5);
			VDebug.addMessage("my message");
			VDebug.addVariable("level", level);
			#end
		});
	}
}
```
 
 
