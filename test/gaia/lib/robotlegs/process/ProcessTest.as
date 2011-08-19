package gaia.lib.robotlegs.process
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertNull;
	import asunit.asserts.assertTrue;
	import asunit.framework.Async;

	import gaia.lib.robotlegs.process.eg.TestNoPropertiesProcess;
	import gaia.lib.robotlegs.process.eg.TestOnePropertyProcess;
	import gaia.lib.robotlegs.process.eg.TestProcessDelegate;
	import gaia.lib.robotlegs.process.eg.TestProcessProperty;
	import gaia.lib.robotlegs.process.eg.TestProcessProperty2;
	import gaia.lib.robotlegs.process.eg.TestTwoPropertyProcess;

	import org.osflash.signals.Signal;
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.adapters.SwiftSuspendersReflector;
	import org.robotlegs.core.IInjector;

	import flash.events.EventDispatcher;

	public class ProcessTest
	{
		[Inject]
		public var async:Async;
		
		private var eventDispatcher:EventDispatcher;
		private var injector:SwiftSuspendersInjector;
		private var reflector:SwiftSuspendersReflector;
		private var processMap:ProcessMap;
		
		[Before]
		public function before():void
		{
			injector = new SwiftSuspendersInjector();
			injector.mapValue(IInjector, injector);
			
			eventDispatcher = new EventDispatcher();
			reflector = new SwiftSuspendersReflector();
			processMap = new ProcessMap(injector, reflector);
		}
		
		[After]
		public function after():void
		{
			injector = null;
			processMap = null;
		}
		
		[Test]
		public function mapping_delegate_creates_process_mapping():void
		{
			var delegate:ProcessDelegate = new TestProcessDelegate();
			processMap.mapDelegate(delegate, TestNoPropertiesProcess);
			assertTrue(processMap.hasProcess(delegate, TestNoPropertiesProcess));
		}
		
		[Test]
		public function unmapping_delegate_removes_process_mapping():void
		{
			var delegate:ProcessDelegate = new TestProcessDelegate();
			processMap.mapDelegate(delegate, TestNoPropertiesProcess);
			processMap.unmapProcess(delegate, TestNoPropertiesProcess);
			assertFalse(processMap.hasProcess(delegate, TestNoPropertiesProcess));
		}
		
		[Test]
		public function triggering_delegate_executes_process():void
		{
			var property:TestProcessProperty = new TestProcessProperty();
			var delegate:ProcessDelegate = new TestProcessDelegate();
			processMap.mapDelegate(delegate, TestOnePropertyProcess);
			
			delegate.execute(property);
			assertTrue(property.wasExecuted);
		}
		
		[Test]
		public function triggering_unmapped_delegate_returns_null():void
		{
			var delegate:ProcessDelegate = new TestProcessDelegate();
			assertNull(delegate.execute());
		}
		
		[Test]
		public function triggering_mapped_delegate_returns_signal():void
		{
			var property:TestProcessProperty = new TestProcessProperty();
			var delegate:ProcessDelegate = new TestProcessDelegate();
			processMap.mapDelegate(delegate, TestOnePropertyProcess);
			
			assertTrue(delegate.execute(property) is Signal);
		}
		
		[Test]
		public function when_process_completes_notice_is_informed():void
		{
			var property:TestProcessProperty = new TestProcessProperty();
			var delegate:ProcessDelegate = new TestProcessDelegate();
			processMap.mapDelegate(delegate, TestOnePropertyProcess);
			
			delegate.execute(property).addOnce(async.add(notice_is_informed_on_process_complete, 200));
		}
		private function notice_is_informed_on_process_complete(property:TestProcessProperty):void
		{
			assertTrue(property.wasExecuted);
		}
		
		[Test]
		public function multiple_properties_are_injected_when_process_is_executed():void
		{
			var property:TestProcessProperty = new TestProcessProperty();
			var property2:TestProcessProperty2 = new TestProcessProperty2();
			var delegate:ProcessDelegate = new TestProcessDelegate();
			processMap.mapDelegate(delegate, TestTwoPropertyProcess);
			
			delegate.execute(property, property2);
			assertTrue(property.wasExecuted && property2.wasExecuted);
		}
		
	}
}
