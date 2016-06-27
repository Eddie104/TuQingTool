package com.apowo.tuqing.model.data.project
{
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public final class ProjectData
	{
		
		private var _name:String;
		
		private var _egretPath:String = "";
		
		private var _path:String;
		
		private var _cellWidth:int;
		
		public var children:ArrayCollection = new ArrayCollection();
		
		private var _configCollection:ConfigCollection;
		
		private var _assetCollection:AssetCollection;
		
		private var _mapDataCollection:MapDataCollection;
		
		public function ProjectData(name:String, path:String, egretPath:String, cellWidth:int)
		{
			_name = name;
			_path = path;
			_egretPath = egretPath;
			_cellWidth = cellWidth;
			
			_configCollection = new ConfigCollection(path);
			children.addItem(_configCollection);
			
			_assetCollection = new AssetCollection(path);
			children.addItem(_assetCollection);
			
			_mapDataCollection = new MapDataCollection(path);
			children.addItem(_mapDataCollection);
		}

		public function get egretPath():String
		{
			return _egretPath;
		}

		public function set egretPath(value:String):void
		{
			_egretPath = value;
		}

		public function get cellWidth():int
		{
			return _cellWidth;
		}

		public function set cellWidth(value:int):void
		{
			_cellWidth = value;
		}

		public function get path():String
		{
			return _path;
		}

		public function set path(value:String):void
		{
			_path = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function toString():String{
			return _name;
		}
		
		public function refreshFiles():void{
			this._mapDataCollection.refresh();
		}
		
		// 导出egret项目
		public function exportEgret():Boolean{
			
			return true;
		}
	}
}