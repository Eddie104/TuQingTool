package com.apowo.tuqing.model.data.project
{
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;

	public final class ConfigCollection
	{
		public var children:ArrayCollection = new ArrayCollection();
		
		public function ConfigCollection(projectPath:String){
			var path:String = projectPath + File.separator + "config";
			var fileArr:Array = new File(path).getDirectoryListing();
			for each(var f:File in fileArr){
				children.addItem(new FileNode(f));			
			}
		}
		
		public function toString():String{
			return "config";
		}
	}
}