package vdebug;

#if arm_debug

class StopwatchVDebug {
	public final startTime:Float;

	public function new() {
		this.startTime = kha.Scheduler.realTime();
	}
	
	public function elapsedMillisecond():Float{
		return kha.Scheduler.realTime() - this.startTime;
	}

}
#end