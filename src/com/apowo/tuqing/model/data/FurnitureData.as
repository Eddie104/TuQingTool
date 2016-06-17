package com.apowo.tuqing.model.data
{
	import com.apowo.tuqing.model.ProjectManager;
	
	import flash.filesystem.File;

	public class FurnitureData extends BaseData implements IDisplayData
	{
		
		private var _subface:String;
		
		private var _asset:String;
		
		private var _offsetX:int;
		
		private var _offsetY:int;
		
		public function FurnitureData()
		{
			super();
		}

		public function get offsetY():int
		{
			return _offsetY;
		}

		public function set offsetY(value:int):void
		{
			_offsetY = value;
		}

		public function get offsetX():int
		{
			return _offsetX;
		}

		public function set offsetX(value:int):void
		{
			_offsetX = value;
		}

		public function get subface():String
		{
			return _subface;
		}

		public function set subface(value:String):void
		{
			_subface = value;
		}

		public function get asset():String
		{
			return _asset;
		}

		public function set asset(value:String):void
		{
			_asset = value;
		}
		
		public function getUrl():String{
			return ProjectManager.instance.curProjectData.path + File.separator + "assets" + File.separator + "furniture" + File.separator + _asset;
		}

	}
}