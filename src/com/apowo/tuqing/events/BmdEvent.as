package com.apowo.tuqing.events
{
	import flash.display.BitmapData;
	import flash.events.Event;
	
	public final class BmdEvent extends Event
	{
		
		public static const LOAD_COMPLETED:String = "loadCompleted";
		
		private var _url:String;
		
		private var _bmd:BitmapData;
		
		public function BmdEvent(type:String, url:String = null, bmd:BitmapData = null)
		{
			super(type, bubbles, cancelable);
			_url = url;
			_bmd = bmd;
		}

		public function get url():String
		{
			return _url;
		}

		public function get bmd():BitmapData
		{
			return _bmd;
		}

	}
}