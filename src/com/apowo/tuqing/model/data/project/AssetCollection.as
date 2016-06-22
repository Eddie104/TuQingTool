package com.apowo.tuqing.model.data.project
{
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;

	public final class AssetCollection
	{
		public var children:ArrayCollection = new ArrayCollection();
		
		public function AssetCollection(projectPath:String){
			var path:String = projectPath + File.separator + "assets";
			var fileArr:Array = new File(path).getDirectoryListing();
			for each(var f:File in fileArr){
				if(f.isDirectory){
					children.addItem(new DirectoryNode(f));	
				}
			}
		}
		
		public function toString():String{
			return "assets";
		}
	}
}