package com.apowo.tuqing.model
{
	
	import com.adobe.serialization.json.JSONDecoder;
	import com.adobe.serialization.json.JSONEncoder;
	import com.apowo.tuqing.model.data.LocalMapData;
	import com.apowo.tuqing.model.data.MapData;
	import com.apowo.tuqing.model.data.project.ProjectData;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	
	import org.libra.utils.CSV;

	public final class MapDataManager
	{
		
		private static var _instance:MapDataManager;
		
		private var _localMapDataList:ArrayCollection = new ArrayCollection();
		
		private var _curLocalMapData:LocalMapData;
		
		[Bindable]
		public var mapDataList:ArrayCollection = new ArrayCollection();
		
		private var _inited:Boolean = false;
		
		public function MapDataManager()
		{
			
		}
		
		public function get localMapDataList():ArrayCollection
		{
			return _localMapDataList;
		}

		public function get curLocalMapData():LocalMapData
		{
			return _curLocalMapData;
		}

		private function init():void{
			if(!_inited){
				if(ProjectManager.instance.curProjectData){
					var file:File = new File(ProjectManager.instance.curProjectData.path + File.separator + "mapDatas");
					for each(var f:File in file.getDirectoryListing()){
						var fs:FileStream = new FileStream();
						fs.open(f, FileMode.READ);
						var arrStr:String = fs.readUTFBytes(f.size);
						fs.close();
						
						var jsonVal:Object = new JSONDecoder(arrStr).getValue();
						var mapData:LocalMapData = new LocalMapData(jsonVal.type, jsonVal.name, jsonVal.cellWidth, jsonVal.cellRows, jsonVal.cellCols, jsonVal.mapArr);
						_localMapDataList.addItem(mapData);
					}
					_inited = true;
				}	
			}
		}
		
		public function saveMapDataToLocal():void{
			for each(var map:LocalMapData in _localMapDataList){
				map.saveToLocal();
			}
		}
		
		public function saveMapData():void{
			var p:ProjectData = ProjectManager.instance.curProjectData;
			if(p){
				var configPath:String = p.path + File.separator + "config" + File.separator + "map.csv";
				
				var f:File = new File(configPath);
				var fs:FileStream = new FileStream();
				fs.open(f, FileMode.READ);
				var csvStr:String = fs.readMultiByte(fs.bytesAvailable, "GBK");
				fs.close();
				var csv:CSV = new CSV(csvStr);
				
				var mapDataIndex:int = 0;
				for(var i:int = 0;i < csv.header.length; i++){
					if(csv.header[i] == "MapData"){
						mapDataIndex = i;
					}
				}
				
				function updateCSV(mapData:MapData):void{
					for(var j:int = 3; j < csv.data.length; j++){
						if(csv.data[j][0] == mapData.type){
							csv.data[j][mapDataIndex] = mapData.mapData;
							return;
						}
					}				
				}
				
				for(i = 0; i < mapDataList.length; i++){
					updateCSV(mapDataList[i]);
				}
				csv.encode();
				
				fs = new FileStream();
				fs.open(f, FileMode.WRITE);
				fs.writeMultiByte(csv.csvString, "GBK");
				fs.close();					
			}
		}
		
		public function reset():void{
			var p:ProjectData = ProjectManager.instance.curProjectData;
			if(p){
				var configPath:String = p.path + File.separator + "config" + File.separator + "map.csv";
				var f:File = new File(configPath);
				if(f.exists){
					var fs:FileStream = new FileStream();
					fs.open(f, FileMode.READ);
					var csvStr:String = fs.readMultiByte(fs.bytesAvailable, "GBK");
					fs.close();
					
					var csv:CSV = new CSV(csvStr);
					mapDataList.removeAll();
					
					var mapData:MapData;
					for(var i:int = 3; i < csv.data.length; i++){
						mapData = new MapData();
						for(var j:int = 0; j < csv.header.length; j++){
							switch(csv.header[j]){
								case "Type":
									mapData.type = csv.data[i][j];
									break;
								case "Name":
									mapData.name = csv.data[i][j]; 
									break;
								case "Description":
									mapData.des = csv.data[i][j];
									break;
								case "MapData":
									mapData.mapData = csv.data[i][j];
									break;
							}
						}
						mapDataList.addItem(mapData);
					}
				}
			}
		}
		
		public function createNewLocalMapData(name:String, cellWidth:int, cellRows:int, cellCols:int):void{
			var mapData:LocalMapData = new LocalMapData(0, name, cellWidth, cellRows, cellCols);
			mapData.saveToLocal();
			_localMapDataList.addItem(mapData);
			ProjectManager.instance.curProjectData.refreshFiles();
		}
		
		public function deleteLocalMapData(mapData:LocalMapData):void{
			for each(var m:LocalMapData in _localMapDataList){
				if(m == mapData){
					_localMapDataList.removeItemAt(_localMapDataList.getItemIndex(m));
					return;
				}
			}
		}
		
		public function setCurLocalMapData(name:String):LocalMapData{
			for each(var mapData:LocalMapData in _localMapDataList){
				if(mapData.name == name){
					_curLocalMapData = mapData;
					return _curLocalMapData;
				}
			}
			return null;
		}
		
		public function updateMapDataArr():void{
			for each(var mapData:MapData in mapDataList){
				mapData.updateMapDataArr(getLocalMapData(mapData.type));
			}
		}
		
		private function getLocalMapData(type:int):LocalMapData{
			for each(var mapData:LocalMapData in _localMapDataList){
				if(mapData.type == type) return mapData;
			}
			return null;
		}
		
		public static function get instance():MapDataManager{
			if(!_instance){
				_instance = new MapDataManager();
			}
			_instance.init();
			return _instance;
		}
	}
}