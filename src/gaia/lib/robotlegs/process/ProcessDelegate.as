package gaia.lib.robotlegs.process
{
	import org.osflash.signals.Signal;
	
	public class ProcessDelegate
	{
		private var _executed:Signal;
		
		public function execute(...params):ProcessToken
		{
			if (!_executed)
				return null;

			var token:ProcessToken = new ProcessToken();
			params.unshift(token);
			_executed.dispatch.apply(null, params);
			
			return token;
		}
		
		internal function get executed():Signal
		{
			return _executed ||= new Signal();
		}
		
	}
}
