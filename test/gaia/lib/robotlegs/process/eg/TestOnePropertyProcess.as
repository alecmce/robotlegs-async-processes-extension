package gaia.lib.robotlegs.process.eg
{
	import gaia.lib.robotlegs.process.Process;

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	public class TestOnePropertyProcess extends Process
	{
		
		[Inject]
		public var property:TestProcessProperty;

		private var _timer:Timer;
		
		override public function execute():void
		{
			property.wasExecuted = true;
			property.executeTime = getTimer();

			_timer = new Timer(50, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_timer.start();
		}

		private function onTimerComplete(event:TimerEvent):void
		{
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			complete(property);
		}
		
	}
}
