package com.apowo.tuqing.view.furniture
{
	import com.apowo.tuqing.BitmapDataPool;
	import com.apowo.tuqing.model.data.FurnitureData;
	
	import flash.display.Bitmap;
	
	import mx.core.UIComponent;
	
	public final class Furniture extends UIComponent
	{
		
		private var _bitmap:Bitmap;
		
		private var _data:FurnitureData;
		
		public function Furniture()
		{
			super();
			_bitmap = new Bitmap();
			this.addChild(_bitmap);
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

	}
}