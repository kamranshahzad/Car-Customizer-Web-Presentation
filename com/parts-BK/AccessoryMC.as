package com.parts{
	
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	
	
	public class AccessoryMC extends MovieClip{
		public var pictureValue:Number;
		public function AccessoryMC( )
		{
			var _container:MovieClip = new MovieClip();
			//_container.graphics.lineStyle(1, 0x0060ff);
			//_container.graphics.beginFill(0x20a107);
			//_container.graphics.drawRect(0,0,50,50);
			//_container.graphics.endFill();
			addChild(_container);
		}
		
	} //$class
} //$package