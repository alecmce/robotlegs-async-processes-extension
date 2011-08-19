package gaia.lib.robotlegs.process
{
	import asunit.asserts.assertTrue;
	import asunit.framework.Async;

	import gaia.lib.robotlegs.process.eg.TestProcessProperty;
	import gaia.lib.robotlegs.process.eg.TestProcessProperty2;
	import gaia.lib.robotlegs.process.eg.TestProcessStack;

	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.adapters.SwiftSuspendersReflector;
	import org.robotlegs.core.IInjector;
	
	public class ProcessStackTest
	{
		
		[Inject]
		public var async:Async;
		
		private var injector:SwiftSuspendersInjector;
		private var reflector:SwiftSuspendersReflector;
		private var processMap:ProcessMap;
		
		private var property:TestProcessProperty;
		private var property2:TestProcessProperty2;
		
		[Before]
		public function before():void
		{
			injector = new SwiftSuspendersInjector();
			injector.mapValue(IInjector, injector);
			
			reflector = new SwiftSuspendersReflector();
			processMap = new ProcessMap(injector, reflector);
		}
		
		[After]
		public function after():void
		{
			injector = null;
			reflector = null;
			processMap = null;
			
			property = null;
			property2 = null;
		}
		
		[Test]
		public function stacked_processes_are_executed():void
		{
			var delegateC:ProcessDelegate = new ProcessDelegate();
			
			property = new TestProcessProperty();
			property2 = new TestProcessProperty2();
			
			processMap.mapDelegate(delegateC, TestProcessStack);
			delegateC.execute(property, property2).addOnce(async.add(stacked_processes_are_executed_result, 1000));
		}
		private function stacked_processes_are_executed_result(... params):void
		{
			assertTrue(property.wasExecuted && property2.wasExecuted);
		}
		
		[Test]
		public function stacked_processes_execute_in_turn():void
		{
			var delegateC:ProcessDelegate = new ProcessDelegate();
			
			property = new TestProcessProperty();
			property2 = new TestProcessProperty2();
			
			processMap.mapDelegate(delegateC, TestProcessStack);
			delegateC.execute(property, property2).addOnce(async.add(stacked_processes_execute_in_turn_result, 1000));
		}
		private function stacked_processes_execute_in_turn_result(... params):void
		{
			assertTrue(property.executeTime < property2.executeTime);
		}
		
		
		
	}
}
