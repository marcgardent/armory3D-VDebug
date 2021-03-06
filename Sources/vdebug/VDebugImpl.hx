package vdebug;

#if arm_debug
import iron.math.Vec2;
import iron.App;
import kha.Color;
import kha.System;
import iron.math.Vec4;

using kha.graphics2.GraphicsExtension;

import kha.Assets;

class VDebugImpl extends iron.Trait implements IVDebug {
	private var lines:Array<LineVDebug> = new Array<LineVDebug>();
	private var points:Array<PointVDebug> = new Array<PointVDebug>();
	private var trails:Map<String, Array<PointVDebug>> = new Map<String, Array<PointVDebug>>();
	private var stopwatches:Map<String, StopwatchVDebug> = new Map<String, StopwatchVDebug>();
	private var costs:Map<String, Float> = new Map<String, Float>();
	private var messages:Array<String> = new Array<String>();
	private var drawTextCall:(g:kha.graphics2.Graphics) -> Void;

	public static var x(default, null):Int;

	public function new() {
		super();
		this.drawTextCall = function(g:kha.graphics2.Graphics) {};
		this.notifyOnRender2D(this.onRender);
		Assets.loadEverything(loadingFinished);
		App.notifyOnRender2D(this.onRender);
	}

	public function loadingFinished() {
		// OMG
		trace("Asset loaded");
		this.drawTextCall = this.drawText;
	}

	public function line(a:Vec4, b:Vec4, color:Color, strength:Float) {
		var line = new LineVDebug();
		line.a = a.clone();
		line.b = b.clone();
		line.color = color;
		line.strength = strength;
		this.lines.push(line);
	}

	public function trail(a:Vec4, color:Color, strength:Float, id:String, buffersize:Int) {
		var d:Array<PointVDebug>;
		if (this.trails.exists(id)) {
			d = this.trails.get(id);
		} else {
			d = new Array<PointVDebug>();
			this.trails.set(id, d);
		}

		if (d.length > buffersize) {
			d.shift();
		}

		var point = new PointVDebug();
		point.a = a.clone();
		point.color = color;
		point.strength = strength;
		d.push(point);
	}

	public function point(a:Vec4, color:Color, strength:Float) {
		var point = new PointVDebug();
		point.a = a.clone();
		point.color = color;
		point.strength = strength;
		this.points.push(point);
	}

	public function variable(key:String, value:Dynamic):Void {
		this.messages.push(key + ": " + value);
	}

	public function message(message:String):Void {
		this.messages.push(message);
	}

	public function time(id:String):Void {
		stopwatches.set(id, new StopwatchVDebug());
	}

	public function timeEnd(id:String):Void {
		if (stopwatches.exists(id)) {
			this.variable(id, stopwatches.get(id).elapsedMillisecond() + "ms");
			stopwatches.remove(id);
		} else {
			trace("[Warning, VDebug] call .time(id) before timeEnd(id)");
		}
	}

	public function cost(id:String) {
		if (stopwatches.exists(id)) {
			var total =stopwatches.get(id).elapsedMillisecond();
			if (costs.exists(id)) {
				total += costs.get(id);	
			}
			costs.set(id, total);
			stopwatches.remove(id);
		} else {
			trace("[Warning, VDebug] call .time(id) before cost(id)");
		}
	}

	public function onRender(g:kha.graphics2.Graphics) {
		for (i in this.trails.keys()) {
			for (point in this.trails[i]) {
				var aScreen = WorldToScreen(point.a);
				g.color = point.color;
				GraphicsExtension.fillCircle(g, aScreen.x, aScreen.y, point.strength);
			}
		}

		while (this.lines.length > 0) {
			var line = this.lines.pop();
			if (line.a != null && line.b != null) {
				var aScreen = WorldToScreen(line.a);
				var bScreen = WorldToScreen(line.b);
				g.color = line.color;
				g.drawLine(aScreen.x, aScreen.y, bScreen.x, bScreen.y, line.strength);
			} else {
				trace("Warn addLine ignored!");
			}
		}

		while (this.points.length > 0) {
			var point = this.points.pop();
			var aScreen = WorldToScreen(point.a);
			g.color = point.color;
			GraphicsExtension.fillCircle(g, aScreen.x, aScreen.y, point.strength);
		}

		for (k in this.costs.keys()) {
			var v = this.costs.get(k);
			this.variable(k, Math.round(v*1000) + "ms/frame " + Math.round(1/v) + "Hz"); // todo trace calls
		}
		 this.costs = new Map<String, Float>();

		this.drawTextCall(g);
	}

	private function drawText(g:kha.graphics2.Graphics) {
		g.font = kha.Assets.fonts.font_default;
		g.fontSize = 20;
		g.color = Color.Red;
		var position = 0;
		while (this.messages.length > 0) {
			var message = this.messages.shift();
			g.drawString(message, 10, 10 + position * 20);
			position++;
		}
	}

	private function WorldToScreen(loc:Vec4):Vec2 {
		var v = new Vec4();
		var cam = iron.Scene.active.camera;
		if (cam != null) {
			v.setFrom(loc);
			v.applyproj(cam.V);
			v.applyproj(cam.P);
		}

		var w = System.windowWidth();
		var h = System.windowHeight();
		return new Vec2((v.x + 1) * 0.5 * w, (-v.y + 1) * 0.5 * h);
	}
}
#end
