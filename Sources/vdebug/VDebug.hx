
package vdebug;


import kha.Color;
#if arm_debug
import iron.math.Vec4;
import vdebug.VDebugImpl;
import vdebug.IVDebug;
import iron.App;

class VDebug {

	private static var _instance:VDebugImpl;
	
	public static function getInstance():IVDebug{
		if(_instance==null){
			_instance = new VDebugImpl();
			App.notifyOnRender2D(_instance.onRender);
		}
		
		return _instance;
	};

	public static function addLine(a:Vec4, b:Vec4, color:Color, strength:Float):Void {
		getInstance().addLine(a,b,color,strength);
	}
	
	public static function addPoint(a:Vec4, color:Color, strength:Float):Void {
		getInstance().addPoint(a,color,strength);
	}

	public static function addVariable(key:String, value:String):Void{
		getInstance().addVariable(key,value);
	}

	public static function addMessage(message:String):Void{
		getInstance().addMessage(message);
	}
}

#end
