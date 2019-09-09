
package vdebug;

#if arm_debug
import iron.math.Vec4;

class LineVDebug {
	public var a:Vec4 = null;
	public var b:Vec4 = null;
	public var color:kha.Color = 0xffff0000;
	public var strength:Float = 1;

	public function new() {}
}

#end