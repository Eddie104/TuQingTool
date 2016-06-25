package com.apowo.tuqing.view.furniture
{
	import com.apowo.tuqing.BitmapDataPool;
	import com.apowo.tuqing.events.BmdEvent;
	import com.apowo.tuqing.model.data.FurnitureData;
	import com.apowo.tuqing.model.data.IDisplayData;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import org.libra.displayObject.JSprite;
	
	public final class Furniture extends UIComponent
	{
		
		private var _bitmap:Bitmap;
		
		private var _data:FurnitureData;
		
		public function Furniture()
		{
			super();
			this.alpha = .5;
			_bitmap = new Bitmap();
			this.addChild(_bitmap);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}

		public function get data():FurnitureData
		{
			return _data;
		}

		public function set data(value:FurnitureData):void
		{
			_data = value;
			_bitmap.bitmapData = BitmapDataPool.instance.getBmd(_data.getUrl());
		}
		
		/**
		 * 加入到舞台上的事件
		 * @private
		 * @param	e
		 */
		protected function onAddToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			BitmapDataPool.instance.addEventListener(BmdEvent.LOAD_COMPLETED, onLoadBmdCompleted);
		}
		
		protected function onRemoveFromStage(e:Event):void{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			BitmapDataPool.instance.removeEventListener(BmdEvent.LOAD_COMPLETED, onLoadBmdCompleted);
		}
		
		private function onLoadBmdCompleted(evt:BmdEvent):void{
			if(_data is IDisplayData){
				var displayData:IDisplayData = _data as IDisplayData;
				if(evt.url == displayData.getUrl()){
					_bitmap.bitmapData = evt.bmd;
				}
			}
		}

	}
}