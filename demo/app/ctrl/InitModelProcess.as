package app.ctrl
{
	import app.model.TextModel;
	import app.service.TextService;

	import gaia.lib.robotlegs.process.Process;

	import org.osflash.signals.Signal;

	public class InitModelProcess extends Process
	{
		[Inject]
		public var model:TextModel;
		
		[Inject]
		public var service:TextService;
				
		override public function execute():void
		{
			var response:Signal = new Signal();
			response.addOnce(onResponse);
			service.getText(response);
		}

		private function onResponse(lines:Vector.<String>):void
		{
			model.text = lines;
			complete();
		}
		
	}
}
