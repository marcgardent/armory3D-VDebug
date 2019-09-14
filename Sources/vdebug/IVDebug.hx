package vdebug;




#if arm_debug
import iron.math.Vec4;
import kha.Color;

interface IVDebug {
	public function addLine(a:Vec4, b:Vec4, color:Color, strength:Float):Void;
	public function addPoint(a:Vec4, color:Color, strength:Float):Void;
	public function addVariable(key:String, value:String):Void;
	public function addMessage(message:String):Void;
	public function addDrag(a:Vec4, color:Color, strength:Float, id:String, buffersize:Int):Void;
}

#end