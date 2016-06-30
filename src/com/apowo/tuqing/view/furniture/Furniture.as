package com.apowo.tuqing.view.furniture
{
	import com.apowo.tuqing.BitmapDataPool;
	import com.apowo.tuqing.events.BmdEvent;
	import com.apowo.tuqing.model.data.FurnitureData;
	import com.apowo.tuqing.model.data.IDisplayData;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	
	import org.libra.displayObject.JSprite;
	import org.libra.utils.displayObject.Display45Util;
	
	public final class Furniture extends UIComponent
	{
		
		private var _bitmap:Bitmap;
		
		private var _data:FurnitureData;
		
		private var _row:int;
		
		private var _col:int;
		
		public function Furniture()
		{
			super();
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
		
		public function setRowAndCol(row:int, col:int):void{
			_row = row;
			_col = col;
			var p:Point = Display45Util.getItemPos(row, col);
			this.x = p.x;
			this.y = p.y;
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