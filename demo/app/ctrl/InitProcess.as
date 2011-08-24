package app.ctrl
{
	import gaia.lib.robotlegs.process.ProcessStack;

	public class InitProcess extends ProcessStack
	{
		public function InitProcess()
		{
			add(InitModelProcess);
			add(InitViewProcess);
		}
	}
}
