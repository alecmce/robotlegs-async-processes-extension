package gaia.lib.robotlegs.process
{
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IReflector;

	import flash.utils.Dictionary;
	
	final public class ProcessMap
	{
		private var _injector:IInjector;
		private var _reflector:IReflector;
		
		private var _delegateMap:Dictionary;
		private var _delegateClassMap:Dictionary;
		
		public function ProcessMap(injector:IInjector, reflector:IReflector)
		{
			_injector = injector;
			_reflector = reflector;
			
			_delegateMap = new Dictionary(false);
			_delegateClassMap = new Dictionary(false);
		}
		
		public function execute(processClass:Class, ...values):Signal
		{
			return new ProcessWrapper(_injector, _reflector, processClass, new ProcessToken(), values).token;
		}

		public function mapDelegate(delegate:ProcessDelegate, processClass:Class):void
		{
			if (hasProcess(delegate, processClass))
				return;
			
			_delegateMap[delegate] = new DelegateProcessBinding(_injector, _reflector, delegate, processClass);
		}
		
		public function mapDelegateClass(delegateClass:Class, processClass:Class, delegateIsSingleton:Boolean = false):void
		{
			var instance:ProcessDelegate = getDelegateClassInstance(delegateClass);
			mapDelegate(instance, processClass);
		}

		public function unmapProcess(delegate:ProcessDelegate, processClass:Class):void
		{
			var binding:DelegateProcessBinding = _delegateMap[delegate];
			if (!binding)
				return;
				
			binding.dispose();
			delete _delegateMap[delegate];
		}
		
		public function unmapDelegateClass(delegateClass:Class, processClass:Class):void
		{
			var instance:ProcessDelegate = getDelegateClassInstance(delegateClass);
			unmapProcess(instance, processClass);
		}

		public function hasProcess(delegate:ProcessDelegate, processClass:Class):Boolean
		{
			var binding:DelegateProcessBinding = _delegateMap[delegate];
			return binding && binding.processClass == processClass;
		}
		
		private function getDelegateClassInstance(notice:Class):ProcessDelegate
		{
			return _delegateClassMap[notice] ||= _injector.getInstance(notice);
		}
		
	}
}
