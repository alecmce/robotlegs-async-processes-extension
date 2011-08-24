package app.ctrl
{
	import app.view.Console;

	import gaia.lib.robotlegs.process.Process;

	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class InitViewProcess extends Process
	{
		[Inject]
		public var container:DisplayObjectContainer;
		
		override public function execute():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader.load(new URLRequest("console.swf"));
		}

		private function onLoaderComplete(event:Event):void
		{
			var info:LoaderInfo = event.currentTarget as LoaderInfo;
			var loader:Loader = info.loader;
			
			var console:Console = new Console(loader.content as MovieClip);
			container.addChild(console);
			
			complete();
		}
		
	}
}
