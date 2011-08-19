package gaia.lib.robotlegs.process.eg
{
	import gaia.lib.robotlegs.process.ProcessStack;
	
	public class TestProcessStack extends ProcessStack
	{
		
		public function TestProcessStack()
		{
			add(TestOnePropertyProcess);
			add(TestOnePropertyProcess2);
		}
		
	}
}
