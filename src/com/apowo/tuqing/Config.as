package com.apowo.tuqing
{
	import com.apowo.tuqing.model.data.MapData;
	
	import flash.filesystem.File;

	public final class Config
	{
		
		private static var _instance:Config;
		
		public function Config()
		{
				
		}
		
		public static function get instance():Config{
			if(!_instance){
				_instance = new Config();
			}
			return _instance;
		}
	}
}