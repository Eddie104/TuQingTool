package com.apowo.tuqing.model
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	import com.apowo.tuqing.model.data.ProjectData;

	public final class ProjectManager
	{
		
		private static var _instance:ProjectManager;
		
		[Bindable]
		public var projectDataList:ArrayCollection = new ArrayCollection();
		
		private var _curProjectData:ProjectData;
		
		public function ProjectManager()
		{
			readProjectDataFromLocal();
		}
		
		public function get curProjectData():ProjectData
		{
			return _curProjectData;
		}

		public function set curProjectData(value:ProjectData):void
		{
			_curProjectData = value;
			FurnitureManager.instance.reset();
		}

		private function readProjectDataFromLocal():void{
			var file:File = new File(File.applicationStorageDirectory.nativePath + File.separator + "projects.json");
			if(file.exists){
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.READ);
				var jsonStr:String = fs.readUTF();
				fs.close();
				
				var projectDataJsonArray:Array = JSON.parse(jsonStr) as Array;
				var projectDataJson:Object = null;
				for(var i:int = 0; i < projectDataJsonArray.length; i++){
					projectDataJson = projectDataJsonArray[i];
					createNewProject(projectDataJson.name, projectDataJson.path.replace(/\//g, '\\'), projectDataJson.cellWidth);
				}
			}
		}
		
		public function saveProjectDataToLocal():void{
			var projectData:ProjectData;
			var jsonStr:String = '[';
			for(var i:int = 0; i < projectDataList.length; i++){
				projectData = projectDataList[i];
				jsonStr += '{"name":"' +  projectData.name + '","path":"' + projectData.path.replace(/\\/g, '/') + '","cellWidth":' + projectData.cellWidth + '}' + (i == projectDataList.length - 1 ? "" : ",");
			}
			jsonStr += "]";
			
			var file:File = new File(File.applicationStorageDirectory.nativePath + File.separator + "projects.json");
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeUTF(jsonStr);
			fs.close();
		}
		
		public function createNewProject(name:String, path:String, cellWidth:int):ProjectData{
			// 创建配置文件的路径
			var configDirPath:String = path + File.separator + "config";
			var f:File = new File(configDirPath);
			if(!f.exists)
				f.createDirectory();
			// 创建家具配置文件
			f = new File(configDirPath + File.separator + "furniture.csv");
			if(!f.exists){
				var fs:FileStream = new FileStream();
				fs.open(f, FileMode.WRITE);
//				fs.writeUTF();
				fs.writeMultiByte("Type,Name,Description,Asset,Subface\n0,0,2,2,0\n主键,名字,描述,资源,底面点\nint,string,string,string,string", "GBK");
				fs.close();	
			}
			
			// 创建家具图片资源目录
			var assetDirPath:String = path + File.separator + "assets" + File.separator + "furniture";
			f = new File(assetDirPath);
			if(!f.exists){
				f.createDirectory();
			}
			
			// 创建地图数据目录
			f = new File(path + File.separator + "mapDatas");
			if(!f.exists){
				f.createDirectory();
			}
			
			var p:ProjectData = new ProjectData(name, path, cellWidth);
			projectDataList.addItem(p);
			return p;
		}
		
		public function deleteProject(projectData:ProjectData):void{
			for each(var p:ProjectData in projectDataList){
				if(p == projectData){
					projectDataList.removeItemAt(projectDataList.getItemIndex(p));
					return;
				}
			}
		}
		
		public static function get instance():ProjectManager{
			if(!_instance){
				_instance = new ProjectManager();
			}
			return _instance;
		}
	}
}