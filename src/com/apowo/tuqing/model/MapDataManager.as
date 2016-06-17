package com.apowo.tuqing.model
{
	
	import com.adobe.serialization.json.JSONEncoder;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	import com.apowo.tuqing.model.data.MapData;

	public final class MapDataManager
	{
		
		private static var _instance:MapDataManager;
		
		[Bindable]
		public var mapDataList:ArrayCollection = new ArrayCollection();
		
		public function MapDataManager()
		{
			readMapDataFromLocal();
		}
		
		private function readMapDataFromLocal():void{
			var file:File = new File(File.desktopDirectory.nativePath + File.separator + "test.json");
			if(file.exists){
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.READ);
				var jsonStr:String = fs.readUTF();
				fs.close();
				
				var mapDataJsonArray:Array = JSON.parse(jsonStr) as Array;
				var mapDataJson:Object = null;
				for(var i:int = 0; i < mapDataJsonArray.length; i++){
					mapDataJson = mapDataJsonArray[i];
					createNewMapData(mapDataJson.name, mapDataJson.cellWidth, mapDataJson.cellRows, mapDataJson.cellCols);
				}
			}
		}
		
		public function saveMapDataToLocal():void{
			var jsonStr:String = '[\n';
			for(var i:int = 0; i < mapDataList.length; i++){
				jsonStr += "\t" +  new JSONEncoder(mapDataList[i]).getString() + (i == mapDataList.length - 1 ? "" : ",") +  "\n";
			}
			jsonStr += "]";
			
			var file:File = new File(File.desktopDirectory.nativePath + File.separator + "test.json");
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeUTF(jsonStr);
			fs.close();
		}
		
		public function createNewMapData(name:String, cellWidth:int, cellRows:int, cellCols:int):void{
			var mapData:MapData = new MapData(name, cellWidth, cellRows, cellCols);
			mapDataList.addItem(mapData);
		}
		
		public function deleteMapData(mapData:MapData):void{
			for each(var m:MapData in mapDataList){
				if(m == mapData){
					mapDataList.removeItemAt(mapDataList.getItemIndex(m));
					return;
				}
			}
		}
		
		public static function get instance():MapDataManager{
			if(!_instance){
				_instance = new MapDataManager();
			}
			return _instance;
		}
	}
}