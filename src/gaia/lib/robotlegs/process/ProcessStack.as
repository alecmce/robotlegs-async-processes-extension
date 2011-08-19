package gaia.lib.robotlegs.process
{
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	
	public class ProcessStack extends Process
	{
		[Inject]
		public var injector:IInjector;
		
		private var _stack:Vector.<Class>;
		private var _tokens:Vector.<Signal>;
		private var _count:uint;
		private var _index:uint;
		
		private var _process:Process;

		public function ProcessStack()
		{
			_stack = new Vector.<Class>();
			_tokens = new Vector.<Signal>();
			_count = 0;
			_index = 0;
		}

		final public function add(processClass:Class):Signal
		{
			var token:Signal = new Signal();
			
			_stack.push(processClass);
			_tokens.push(token);
			++_count;
			
			return token;
		}
		
		final override public function execute():void
		{
			if (_count == 0)
				complete();
			
			var processClass:Class = _stack[_index];
			_process = injector.instantiate(processClass);
			_process.completed.addOnce(onProcessComplete);
			_process.execute();
		}

		private function onProcessComplete(...arguments):void
		{
			var token:Signal = _tokens[_index];
			token.dispatch.apply(null, arguments);
			
			if (++_index == _count)
			{
				complete();
			}
			else
			{
				onProgress(_index, _count);
				execute();
			}
		}

		protected function onProgress(index:uint, count:uint):void
		{
			// to be overridden
		}
		
	}
	
}
