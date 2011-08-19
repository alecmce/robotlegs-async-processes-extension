package gaia.lib.robotlegs.process
{
	import org.osflash.signals.Signal;
	
	public class Process
	{
		
		internal var completed:Signal;

		public function Process()
		{
			completed = new Signal();
		}
		
		public function execute():void
		{
			// to be overridden
		}
		
		final protected function complete(...arguments):void
		{
			onComplete();
			completed.dispatch.apply(null, arguments);
		}

		protected function onComplete():void
		{
			// to be overridden
		}
		
	}
}
