package vdebug;




#if arm_debug
import iron.math.Vec4;
import kha.Color;

interface IVDebug {
	public function line(a:Vec4, b:Vec4, color:Color, strength:Float):Void;
	public function point(a:Vec4, color:Color, strength:Float):Void;
	public function variable(key:String, value:Dynamic):Void;
	public function message(message:String):Void;
	public function trail(a:Vec4, color:Color, strength:Float, id:String, buffersize:Int):Void;
	public function time(id:String):Void;
	public function timeEnd(id:String):Void;
	public function cost(id:String):Void;
}

#end