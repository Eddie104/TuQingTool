package com.apowo.tuqing.model.data
{
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;

	public final class ProjectData
	{
		
		private var _name:String;
		
		private var _path:String;
		
		private var _cellWidth:int;
		
		public var children:ArrayCollection = new ArrayCollection();
		
		private var _configCollection:ConfigCollection;
		
		private var _assetCollection:AssetCollection;
		
		private var _mapDataCollection:MapDataCollection;
		
		public function ProjectData(name:String, path:String, cellWidth:int)
		{
			_name = name;
			_path = path;
			_cellWidth = cellWidth;
			
			_configCollection = new ConfigCollection(path);
			children.addItem(_configCollection);
			
			_assetCollection = new AssetCollection(path);
			children.addItem(_assetCollection);
			
			_mapDataCollection = new MapDataCollection(path);
			children.addItem(_mapDataCollection);
		}

		public function get cellWidth():int
		{
			return _cellWidth;
		}

		public function set cellWidth(value:int):void
		{
			_cellWidth = value;
		}

		public function get path():String
		{
			return _path;
		}

		public function set path(value:String):void
		{
			_path = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function toString():String{
			return _name;
		}
		
	}
}
import flash.filesystem.File;

import mx.collections.ArrayCollection;

final class ConfigCollection {
	
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

final class AssetCollection {
	
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

final class MapDataCollection {
	
	public var children:ArrayCollection = new ArrayCollection();
	
	public function MapDataCollection(projectPath:String){
		var path:String = projectPath + File.separator + "mapDatas";
		var fileArr:Array = new File(path).getDirectoryListing();
		for each(var f:File in fileArr){
			children.addItem(new FileNode(f));			
		}
	}
	
	public function toString():String{
		return "mapDatas";
	}
}

final class DirectoryNode {
	
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

final class FileNode {
	
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