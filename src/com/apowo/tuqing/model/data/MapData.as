package com.apowo.tuqing.model.data
{
	public final class MapData
	{
		
		private var _name:String;
		
		private var _cellWidth:int;
		
		private var _cellRows:int;
		
		private var _cellCols:int;
		
		public function MapData(name:String, cellWidth:int, cellRows:int, cellCols:int)
		{
			_name = name;
			_cellWidth = cellWidth;
			_cellRows = cellRows;
			_cellCols = cellCols;
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

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function toString():String{
			return this._name;
		}

	}
}