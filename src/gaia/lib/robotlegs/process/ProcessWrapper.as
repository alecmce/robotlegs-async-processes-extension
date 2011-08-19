package gaia.lib.robotlegs.process
{
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IReflector;
	
	final internal class ProcessWrapper
	{
		private var _injector:IInjector;
		private var _reflector:IReflector;
		private var _processClass:Class;
		private var _token:ProcessToken;
		
		private var _values:Array;
		private var _count:uint;
		private var _classes:Vector.<Class>;
		
		private var _process:Process;

		public function ProcessWrapper(injector:IInjector, reflector:IReflector, processClass:Class, token:ProcessToken, values:Array)
		{
			_processClass = processClass;
			_reflector = reflector;
			_injector = injector;
			_token = token;
			
			_values = values;
			_count = values.length;
			_classes = getClasses();
			
			mapValues();
			_process = _injector.instantiate(_processClass);
			_process.completed.addOnce(onProcessComplete);
			_process.execute();
		}

		private function onProcessComplete(...arguments):void
		{
			_token.dispatch.apply(null, arguments);
			unmapValues();
			dispose();
		}

		private function getClasses():Vector.<Class>
		{
			var classes:Vector.<Class> = new Vector.<Class>(_count, true);
			
			var i:uint = _count;
			while (i--)
				classes[i] = _reflector.getClass(_values[i]);
			
			return classes;
		}

		private function mapValues():void
		{
			var i:uint = _count;
			while (i--)
				_injector.mapValue(_classes[i], _values[i]);
		}
		
		private function unmapValues():void
		{
			var i:uint = _count;
			while (i--)
				_injector.unmap(_classes[i]);	
		}
		
		private function dispose():void
		{
			_injector = null;
			_reflector = null;
			_processClass = null;
			_token = null;
			
			_values = null;
			_classes = null;
			
			_process = null;
		}

		public function get token():Signal
		{
			return _token;
		}
		
	}
}
