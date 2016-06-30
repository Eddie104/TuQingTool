package com.apowo.tuqing.view.map
{
	import com.apowo.tuqing.model.ProjectManager;
	import com.apowo.tuqing.model.data.LocalMapData;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	import org.libra.utils.MathUtil;
	import org.libra.utils.displayObject.GraphicsUtil;
	
	public final class FloorLayer extends UIComponent
	{
		
		private var _startRow:int;
		
		private var _startCol:int;
		
		private var _floorList:Vector.<Vector.<FloorTile>> = new Vector.<Vector.<FloorTile>>();
		
		private var _mapData:LocalMapData;
		
		private var _tileContainer:Sprite;
		
		private var _netLayer:Shape;
		
		public function FloorLayer()
		{
			super();
			mouseEnabled = false;
			mouseChildren = false;
			
			_tileContainer = new Sprite();
			this.addChild(_tileContainer);
			
			_netLayer = new Shape();
			this.addChild(_netLayer);
		}
		
		public function set startRow(value:int):void
		{
			_startRow = value;
		}

		public function set startCol(value:int):void
		{
			_startCol = value;
		}
		
		public function reset(mapData:LocalMapData):void{
			_mapData = mapData;
			this._tileContainer.removeChildren();
			this._floorList.length = 0;
			for(var row:int = 0; row < mapData.cellRows; row++){
				_floorList[row] = new Vector.<FloorTile>();
				for(var col:int = 0; col < mapData.cellCols; col++){
					if(mapData.mapArr[row][col] == 1){
						var f:FloorTile = new FloorTile(row, col);
						_tileContainer.addChild(f);
						_floorList[row][col] = f;
					}else{
						_floorList[row][col] = null;
					}
				}
			}
		}
		
		public function fillFloorTile(row:int, col:int):void{
			if(col >= 0 && row >= 0 && col < _mapData.cellCols && row < _mapData.cellRows){
				if(_mapData.mapArr[row][col] < 1){
					var f:FloorTile = new FloorTile(row, col);
					_tileContainer.addChild(f);
					_floorList[row][col] = f;
					_mapData.mapArr[row][col] = 1;
				}
			}
		}
		
		public function clearFloorTile(row:int, col:int):void{
			if(col >= 0 && row >= 0 && col < _mapData.cellCols && row < _mapData.cellRows){
				if(_mapData.mapArr[row][col] > 0){
					var f:FloorTile = _floorList[row][col];
					_tileContainer.removeChild(f);
					_floorList[row][col] = null;
					_mapData.mapArr[row][col] = 0;
				}
			}
		}
		
		public function drawNet(endRow:int, endCol:int):void{
			var startRow:int = MathUtil.min(_startRow, endRow);
			var startCol:int = MathUtil.min(_startCol, endCol);
			
			endRow = MathUtil.max(_startRow, endRow);
			endCol = MathUtil.max(_startCol, endCol);
			
			GraphicsUtil.drawDiamondNet(this._netLayer.graphics, new Point(), startRow, startCol, endRow - startRow + 1, endCol - startCol + 1, ProjectManager.instance.curProjectData.cellWidth, 0xff00ff);
		}
		
		public function getNetRectangle(endRow:int, endCol:int):Rectangle{
			this._netLayer.graphics.clear();
			
			var startRow:int = MathUtil.min(_startRow, endRow);
			var startCol:int = MathUtil.min(_startCol, endCol);
			
			endRow = MathUtil.max(_startRow, endRow);
			endCol = MathUtil.max(_startCol, endCol);
			
			return new Rectangle(startRow, startCol, endRow - startRow + 1, endCol - startCol + 1);
		}
	}
}