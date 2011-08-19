package gaia.lib.robotlegs.process
{
	import org.osflash.signals.Signal;

	final internal class ProcessToken extends Signal
	{
		
		private var _hasDispatched:Boolean;
		private var _arguments:Array;
		
		public function ProcessToken()
		{
			_hasDispatched = false;
		}

		override public function add(listener:Function):void
		{
			if (_hasDispatched)
				lateDispatch(listener);
			else
				super.add(listener);
		}

		override public function addOnce(listener:Function):void
		{
			if (_hasDispatched)
				lateDispatch(listener);
			else
				super.addOnce(listener);
		}

		override public function dispatch(...arguments):void
		{
			if (_hasDispatched)
				return;
			
			_hasDispatched = true;
			_arguments = arguments;
			super.dispatch.apply(null, arguments);
		}
		
		private function lateDispatch(listener:Function):Boolean
		{
			return listener.apply(null, _arguments);
		}
		
	}
}
