package com.apowo.tuqing.model.data
{
	public final class MapData extends BaseData
	{
		
		private var _mapData:String;
		
		private var _mapDataArr:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
		
		public function MapData()
		{
			super();
		}

		public function get mapData():String
		{
			return _mapData;
		}

		public function set mapData(value:String):void
		{
			_mapData = value;
			
			_mapDataArr.length = 0;
			if(_mapData == ""){
				_mapDataArr[0] = new Vector.<int>();				
			}else{
				var rows:Array = _mapData.split("|");
				var cols:Array = null;
				for(var r:int = 0; r < rows.length; r++){
					_mapDataArr[r] = new Vector.<int>();
					cols = rows[r].split("&");
					for(var c:int = 0; c < cols.length; c++){
						_mapDataArr[r][c] = int(cols[c]);	
					}
				}
			}
		}
		
		public function setMapDataArr(arr:Array):void{
			if(arr){
				var a:Array = [];
				for(var r:int = 0; r < arr.length; r++){
					a[r] = arr[r].join("&");
				}
				mapData = a.join("|");	
			}else{
				mapData = '';
			}
		}
		
		public function updateMapDataArr(mapData:LocalMapData):void{
			setMapDataArr(mapData ? mapData.mapArr : null);
		}
		
		public function gfetMapDataArrStr():String{
			var s:String = "[";
			for(var i:int = 0; i < _mapDataArr.length; i++){
				s += '[' + _mapDataArr[i].join(",") + ']';
				if(i < _mapDataArr.length - 1){
					s += ',';
				}
			}
			s += ']';
			return s;
		}

	}
}