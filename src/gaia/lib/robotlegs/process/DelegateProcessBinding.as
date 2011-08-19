package gaia.lib.robotlegs.process
{
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IReflector;

	import flash.utils.Dictionary;
	
	final internal class DelegateProcessBinding
	{
		private var _injector:IInjector;
		private var _reflector:IReflector;
		private var _delegate:ProcessDelegate;
		private var _processClass:Class;
		
		private var _tokenMap:Dictionary;

		public function DelegateProcessBinding(injector:IInjector, reflector:IReflector, delegate:ProcessDelegate, processClass:Class)
		{
			_injector = injector;
			_reflector = reflector;
			_delegate = delegate;
			_processClass = processClass;
			
			_tokenMap = new Dictionary(false);
			
			_delegate.executed.add(fn);
		}
		
		public function dispose():void
		{
			_delegate.executed.remove(fn);
		}
		
		private function fn(token:ProcessToken, ...values):void
		{
			new ProcessWrapper(_injector, _reflector, _processClass, token, values);
		}

		public function get processClass():Class
		{
			return _processClass;
		}
		
	}
	
}