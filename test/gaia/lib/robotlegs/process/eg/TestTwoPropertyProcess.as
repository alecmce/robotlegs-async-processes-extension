package gaia.lib.robotlegs.process.eg
{
	import gaia.lib.robotlegs.process.Process;

	public class TestTwoPropertyProcess extends Process
	{
		[Inject]
		public var property:TestProcessProperty;
		
		[Inject]
		public var property2:TestProcessProperty2;
		
		override public function execute():void
		{
			property.wasExecuted = true;
			property2.wasExecuted = true;
			complete();
		}
	}
}
