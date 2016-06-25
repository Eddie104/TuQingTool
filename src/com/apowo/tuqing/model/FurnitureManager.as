package com.apowo.tuqing.model
{
	import com.apowo.tuqing.model.data.FurnitureData;
	import com.apowo.tuqing.model.data.project.ProjectData;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	
	import org.libra.utils.CSV;

	public class FurnitureManager
	{
		
		private static var _instance:FurnitureManager;
		
		/**
		 * 给List作为数据源
		 */
		[Bindable]
		public var furnitureShowingList:ArrayCollection = new ArrayCollection();
		
		private var _furnitureDataList:Vector.<FurnitureData> = new Vector.<FurnitureData>();
		
		public function FurnitureManager()
		{
			
		}
		
		public function reset():void{
			var p:ProjectData = ProjectManager.instance.curProjectData;
			if(p){
				var configPath:String = p.path + File.separator + "config" + File.separator + "furniture.csv";
				var f:File = new File(configPath);
				if(f.exists){
					var fs:FileStream = new FileStream();
					fs.open(f, FileMode.READ);
					var csvStr:String = fs.readMultiByte(fs.bytesAvailable, "GBK");
					fs.close();
					
					var csv:CSV = new CSV(csvStr);
					_furnitureDataList.length = 0;
					
					var furni:FurnitureData;
					for(var i:int = 3; i < csv.data.length; i++){
						furni = new FurnitureData();
						for(var j:int = 0; j < csv.header.length; j++){
							switch(csv.header[j]){
								case "Type":
									furni.type = csv.data[i][j];
									break;
								case "Name":
									furni.name = csv.data[i][j]; 
									break;
								case "Description":
									furni.des = csv.data[i][j];
									break;
								case "Asset":
									furni.asset = csv.data[i][j];
									break;
								case "Subface":
									furni.subface = csv.data[i][j];
									break;
								case "OffsetX":
									furni.offsetX = int(csv.data[i][j]);
									break;
								case "OffsetY":
									furni.offsetY = int(csv.data[i][j]);
									break;
							}
						}
						_furnitureDataList.push(furni);
					}
					updateFurnitureShowingList();
				}
			}
		}
		
		public function updateFurnitureShowingList(key:String = null):void{
			furnitureShowingList.removeAll();
			if(key == null){
				for each(var f:FurnitureData in _furnitureDataList){
					furnitureShowingList.addItem(f);
				}
			}else{
				for each(f in _furnitureDataList){
					if(f.name.indexOf(key) != -1){
						furnitureShowingList.addItem(f);
					}
				}	
			}
		}
		
		public function saveMapData():void{
//			for each(var f:FurnitureData in _furnitureDataList){
//				
//			}
			var p:ProjectData = ProjectManager.instance.curProjectData;
			var configPath:String = p.path + File.separator + "config" + File.separator + "furniture.csv";
			
			var f:File = new File(configPath);
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.READ);
			var csvStr:String = fs.readMultiByte(fs.bytesAvailable, "GBK");
			fs.close();
			var csv:CSV = new CSV(csvStr);
			
			var offsetXIndex:int = 0;
			var offsetYIndex:int = 0;
			for(var i:int = 0;i < csv.header.length; i++){
				if(csv.header[i] == "OffsetX"){
					offsetXIndex = i;					
				}else if(csv.header[i] == "OffsetY"){
					offsetYIndex = i;
				}
			}

			function updateCSV(furnitureData:FurnitureData):void{
				for(var j:int = 3; j < csv.data.length; j++){
					if(csv.data[j][0] == furnitureData.type){
						csv.data[j][offsetXIndex] = furnitureData.offsetX;
						csv.data[j][offsetYIndex] = furnitureData.offsetY;
						return;
					}
				}				
			}
			
			for(i = 0; i < _furnitureDataList.length; i++){
				updateCSV(_furnitureDataList[i]);
			}
			csv.encode();
			
			fs = new FileStream();
			fs.open(f, FileMode.WRITE);
			fs.writeMultiByte(csv.csvString, "GBK");
			fs.close();	
		}
		
		public static function get instance():FurnitureManager{
			if(!_instance){
				_instance = new FurnitureManager();
			}
			return _instance;
		}
	}
}