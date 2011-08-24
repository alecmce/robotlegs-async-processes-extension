package gaia.lib.robotlegs
{
	import gaia.lib.robotlegs.process.ProcessMap;

	import org.robotlegs.base.CommandMap;
	import org.robotlegs.core.ICommandMap;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	
	public class ProcessContext extends Context
	{
		private var _processMap:ProcessMap;
		
		private var _controllerInjector:IInjector;
		
		public function ProcessContext(container:DisplayObjectContainer, autoStartup:Boolean = true)
		{
			super(container, autoStartup);
		}
		
		override protected function get commandMap():ICommandMap
		{
			_controllerInjector ||= createChildInjector();
			return _commandMap ||= new CommandMap(eventDispatcher, _controllerInjector, reflector);
		}
		
		protected function get processMap():ProcessMap
		{
			_controllerInjector ||= createChildInjector();
			return _processMap ||= new ProcessMap(_controllerInjector, _reflector);
		}

				
	}
}
