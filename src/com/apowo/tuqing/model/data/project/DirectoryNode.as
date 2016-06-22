package com.apowo.tuqing.model.data.project
{
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;

	public final class DirectoryNode
	{
		private var _dir:File;
		
		public var children:ArrayCollection = new ArrayCollection();
		
		public function DirectoryNode(dir:File){
			_dir = dir;
			var fileArr:Array = _dir.getDirectoryListing();
			for each(var f:File in fileArr){
				children.addItem(new FileNode(f));			
			}
		}
		
		public function toString():String{
			return _dir.name;
		}
	}
}