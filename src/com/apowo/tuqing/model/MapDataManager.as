package com.apowo.tuqing.model
{
	
	import com.adobe.serialization.json.JSONDecoder;
	import com.adobe.serialization.json.JSONEncoder;
	import com.apowo.tuqing.model.data.MapData;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;

	public final class MapDataManager
	{
		
		private static var _instance:MapDataManager;
		
		private var _mapDataList:ArrayCollection = new ArrayCollection();
		
		private var _curMapData:MapData;
		
		public function MapDataManager()
		{
			readMapDataFromLocal();
		}
		
		private function readMapDataFromLocal():void{
			var file:File = new File(ProjectManager.instance.curProjectData.path + File.separator + "mapDatas");
			for each(var f:File in file.getDirectoryListing()){
				var fs:FileStream = new FileStream();
				fs.open(f, FileMode.READ);
				var arrStr:String = fs.readUTFBytes(f.size);
				fs.close();
				
				var jsonVal:Object = new JSONDecoder(arrStr).getValue();
				var mapData:MapData = new MapData(jsonVal.name, jsonVal.cellWidth, jsonVal.cellRows, jsonVal.cellCols, jsonVal.mapArr);
				_mapDataList.addItem(mapData);
			}
		}
		
		public function saveMapDataToLocal():void{
			for each(var map:MapData in _mapDataList){
				map.saveToLocal();
			}
		}
		
		public function createNewMapData(name:String, cellWidth:int, cellRows:int, cellCols:int):void{
			var mapData:MapData = new MapData(name, cellWidth, cellRows, cellCols);
			mapData.saveToLocal();
			_mapDataList.addItem(mapData);
			ProjectManager.instance.curProjectData.refreshFiles();
		}
		
		public function deleteMapData(mapData:MapData):void{
			for each(var m:MapData in _mapDataList){
				if(m == mapData){
					_mapDataList.removeItemAt(_mapDataList.getItemIndex(m));
					return;
				}
			}
		}
		
		public function setCurMapData(name:String):MapData{
			for each(var mapData:MapData in _mapDataList){
				if(mapData.name == name){
					_curMapData = mapData;
					return _curMapData;
				}
			}
			return null;
		}
		
		public static function get instance():MapDataManager{
			if(!_instance){
				_instance = new MapDataManager();
			}
			return _instance;
		}
	}
}