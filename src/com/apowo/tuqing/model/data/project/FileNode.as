package com.apowo.tuqing.model.data.project {
	
	import flash.filesystem.File;

	public final class FileNode
	{
		
		private var _file:File;
		
		[Embed(source="assets/csv.png")]
		private var _csvIcon:Class;
		
		[Embed(source="assets/png.png")]  
		private var _pngIcon:Class;
		
		[Embed(source="assets/default.png")]  
		private var _defaultIcon:Class;
		
		public function FileNode(f:File){
			_file = f;
		}
		
		public function get file():File
		{
			return _file;
		}
		
		public function get name():String{
			return _file.name.replace("." + _file.extension, "");
		}
		
		public function get icon():Object{
			if(_file.extension == "csv"){
				return _csvIcon;
			} else if(_file.extension == "png"){
				return _pngIcon;
			}
			return _defaultIcon;
		}
		
		
		public function toString():String{
			return _file.name;
		}
	}
}