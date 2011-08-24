package
{
	import app.ctrl.InitProcess;
	import app.model.TextModel;
	import app.service.MockTextService;
	import app.service.TextService;
	import app.view.Console;
	import app.view.ConsoleMediator;

	import gaia.lib.robotlegs.ProcessContext;

	import flash.display.DisplayObjectContainer;

	public class AppContext extends ProcessContext
	{
		
		public function AppContext(container:DisplayObjectContainer)
		{
			super(container, true);
		}

		override public function startup():void
		{
			injector.mapSingleton(TextModel);
			injector.mapSingletonOf(TextService, MockTextService);
			
			mediatorMap.mapView(Console, ConsoleMediator);
			
			processMap.execute(InitProcess);
		}
		
	}
}
