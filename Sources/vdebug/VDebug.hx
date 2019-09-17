package vdebug;

import kha.Color;
#if arm_debug
import iron.math.Vec4;
import vdebug.VDebugImpl;
import vdebug.IVDebug;
import iron.App;

class VDebug {
	public static var instance:IVDebug = new VDebugImpl(); //# <-- you could inject your implementation

	public static function line(a:Vec4, b:Vec4, color:Color, strength:Float):Void {
		instance.line(a, b, color, strength);
	}

	public static function point(a:Vec4, color:Color, strength:Float):Void {
		instance.point(a, color, strength);
	}

	public static function variable(key:String, value:Dynamic):Void {
		instance.variable(key,  value);
	}

	public static function message(message:String):Void {
		instance.message(message);
	}

	public static function trail(a:Vec4, color:Color, strength:Float, id:String, buffersize:Int) {
		instance.trail(a, color, strength, id, buffersize);
	}

	public static function time(id:String){
		instance.time(id);
	}

	public static function timeEnd(id:String){
		instance.timeEnd(id);
	}

	public static function cost(id:String){
		instance.cost(id);
	}
}
#end
