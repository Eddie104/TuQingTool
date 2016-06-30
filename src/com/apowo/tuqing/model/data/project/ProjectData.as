package com.apowo.tuqing.model.data.project
{
	import com.apowo.tuqing.model.FurnitureManager;
	import com.apowo.tuqing.model.MapDataManager;
	import com.apowo.tuqing.model.data.FurnitureData;
	import com.apowo.tuqing.model.data.MapData;
	import com.apowo.tuqing.view.furniture.Furniture;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
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
			
			MapDataManager.instance.updateMapDataArr();
			
			var configDir:String = _egretPath + File.separator + "src" + File.separator + "com" + File.separator + "apowo" + File.separator + "sim" + File.separator + "config"; 
			var f:File = new File(configDir);
			f.createDirectory();
			
			f = new File(configDir + File.separator + "FurnitureConfig.ts");
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.WRITE);
			fs.writeUTFBytes(createEgretFurnitureConfig());
			fs.close();
			
			f = new File(configDir + File.separator + "MapConfig.ts");
			fs = new FileStream();
			fs.open(f, FileMode.WRITE);
			fs.writeUTFBytes(createEgretMapConfig());
			fs.close();
			
			return true;
		}
		
		private function createEgretFurnitureConfig():String{
			var manager:FurnitureManager = FurnitureManager.instance;
			var f:FurnitureData;
			var l:int = manager.furnitureDataList.length;
			var s:String = "module sim.config {\n\n\texport const FURNITURE: Array<Object> = [\n";
			for(var i:int = 0; i < l; i++){
				f = manager.furnitureDataList[i];
				s += '\t\t{Type: ' + f.type + ',　Name: "' + f.name + '", Description: "' + f.des + '", Asset: "' + f.asset + '", Subface: ' + f.getSubfaceArrStr() + ', OffsetX: ' + f.offsetX + ', OffsetY: ' + f.offsetY + '}';
				if(i != l - 1){
					s += ",\n";
				}
			}
			s += "\n\t];\n}"
			return s;
		}
		
		private function createEgretMapConfig():String{
			var manager:MapDataManager = MapDataManager.instance;
			var m:MapData;
			var l:int = manager.mapDataList.length;
			var s:String = "module sim.config {\n\n\texport const MAP: Array<Object> = [\n";
			for(var i:int = 0; i < l; i++){
				m = manager.mapDataList[i];
				s += '\t\t{Type: ' + m.type + ',　Name: "' + m.name + '", Description: "' + m.des + '", MapArr: ' + m.gfetMapDataArrStr() + '}';
				if(i != l - 1){
					s += ",\n";
				}
			}
			s += "\n\t];\n}"
			return s;
		}
	}
}