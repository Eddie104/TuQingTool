package com.apowo.tuqing.model.data
{
	import com.adobe.serialization.json.JSONEncoder;
	import com.apowo.tuqing.model.ProjectManager;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public final class MapData extends BaseData
	{
		
		private var _cellWidth:int;
		
		private var _cellRows:int;
		
		private var _cellCols:int;
		
		/**
		 * 地图数据
		 */
		private var _mapArr:Array;
		
		public function MapData(name:String, cellWidth:int, cellRows:int, cellCols:int, mapArr:Array = null)
		{
			_name = name;
			_cellWidth = cellWidth;
			_cellRows = cellRows;
			_cellCols = cellCols;
			
			if(!mapArr){
				_mapArr = [];
				for(var row:int = 0; row < cellRows; row++){
					_mapArr[row] = [];
					for(var col:int = 0; col < cellCols; col++){
						_mapArr[row][col] = 0;
					}
				}	
			}else{
				_mapArr = mapArr;
			}
		}

		public function get cellCols():int
		{
			return _cellCols;
		}

		public function set cellCols(value:int):void
		{
			_cellCols = value;
		}

		public function get cellRows():int
		{
			return _cellRows;
		}

		public function set cellRows(value:int):void
		{
			_cellRows = value;
		}

		public function get cellWidth():int
		{
			return _cellWidth;
		}

		public function set cellWidth(value:int):void
		{
			_cellWidth = value;
		}
		
		public function get mapArr():Array{
			return _mapArr;
		}
		
		/**
		 * 算出地图的水平宽度
		 */
		public function getWidth():int{
			return (this._cellCols + this._cellRows) * _cellWidth >> 1;
		}
		
		public function getHeight():int{
			return (this._cellCols + this._cellRows) * _cellWidth >> 2;
		}
	
		
		public function toJson():String{
			return new JSONEncoder(this).getString();
		}
		
		public override function saveToLocal():Boolean{
			var result:Boolean = true;
			try{
				var file:File = new File(ProjectManager.instance.curProjectData.path + File.separator + "mapDatas" + File.separator + _name + ".map");
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.WRITE);
				fs.writeUTFBytes(toJson());
				fs.close();	
			} catch(e:Error){
				result = false;
			}
			return result;
		}

	}
}