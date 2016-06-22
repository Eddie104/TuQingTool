package com.apowo.tuqing.model.data.project
{
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;

	public final class MapDataCollection
	{
		public var children:ArrayCollection = new ArrayCollection();
		
		private var _projectPath:String;
		
		public function MapDataCollection(projectPath:String){
			_projectPath = projectPath;
			this.refresh();		
		}
		
		public function refresh():void{
			children.removeAll();
			var path:String = _projectPath + File.separator + "mapDatas";
			var fileArr:Array = new File(path).getDirectoryListing();
			for each(var f:File in fileArr){
				children.addItem(new FileNode(f));			
			}
		}
		
		public function toString():String{
			return "mapDatas";
		}
	}
}