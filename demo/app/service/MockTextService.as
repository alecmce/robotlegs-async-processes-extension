package app.service
{

	import org.osflash.signals.Signal;

	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class MockTextService implements TextService
	{
		private var _map:Dictionary;
		
		public function MockTextService()
		{
			_map = new Dictionary();
		}
		
		public function getText(response:Signal):void
		{
			var timer:Timer = new Timer(1000, 1);
			_map[timer] = response;
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTextResponse);
			timer.start();
		}

		private function onTextResponse(event:TimerEvent):void
		{
			var timer:Timer = event.currentTarget as Timer;
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTextResponse);
			
			var response:Signal = _map[timer];
			delete _map[timer];
			
			var lines:Vector.<String> = new Vector.<String>(2, true);
			lines[0] = "Hello Robotlegs!";
			lines[1] = "This is a demo";
			
			response.dispatch(lines);
		}

	}
}
