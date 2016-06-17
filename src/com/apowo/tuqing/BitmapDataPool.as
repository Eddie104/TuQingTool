package com.apowo.tuqing
{
	import com.apowo.tuqing.events.BmdEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	import mx.events.Request;
	
	import org.libra.utils.HashMap;

	public final class BitmapDataPool extends EventDispatcher
	{
		
		private static var _instance:BitmapDataPool;
		
		private var _bmdPool:HashMap = new HashMap();
		
		private var _isLoading:Boolean = false;
		
		private var _curUrl:String;
		
		private var _urlQueue:Vector.<String> = new Vector.<String>();
		
		public function BitmapDataPool()
		{
		}
		
		public function getBmd(url:String):BitmapData{
			var bmd:BitmapData = _bmdPool.get(url);
			if(!bmd){
				startLoad(url);
			}
			return bmd;
		}
		
		private function startLoad(url:String):void{
			if(!_isLoading){
				_curUrl = url;
				_isLoading = true;
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadCompleted);
				loader.load(new URLRequest(url));	
			}else{
				_urlQueue.push(url);					
			}
		}
		
		private function onLoadCompleted(evt:Event):void{
			var loaderInfo:LoaderInfo = evt.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, onLoadCompleted);
			_isLoading = false;
			
			var bmd:BitmapData = (loaderInfo.content as Bitmap).bitmapData;
			_bmdPool.put(_curUrl, bmd);
			
			this.dispatchEvent(new BmdEvent(BmdEvent.LOAD_COMPLETED, _curUrl, bmd));
			
			if(_urlQueue.length > 0){
				startLoad(_urlQueue.shift());
			}
		}
		
		public static function get instance():BitmapDataPool{
			if(!_instance){
				_instance = new BitmapDataPool();
			}
			return _instance;
		}
	}
}