package gaia.lib.robotlegs
{
	import gaia.lib.robotlegs.process.ProcessMap;

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
		
		public function get processMap():ProcessMap
		{
			_controllerInjector ||= createChildInjector();
			return _processMap ||= new ProcessMap(_controllerInjector, _reflector);
		}

				
	}
}
