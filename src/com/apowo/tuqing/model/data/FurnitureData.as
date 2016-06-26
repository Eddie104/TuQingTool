package com.apowo.tuqing.model.data
{
	import com.apowo.tuqing.model.ProjectManager;
	
	import flash.filesystem.File;
	
	import org.libra.URI;
	import org.libra.utils.MathUtil;

	public class FurnitureData extends BaseData implements IDisplayData
	{
		
		private var _subface:String;
		
		private var _asset:String;
		
		private var _offsetX:int;
		
		private var _offsetY:int;
		
		private var _subfaceArr:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
		
		public function FurnitureData()
		{
			super();
		}

		public function get offsetY():int
		{
			return _offsetY;
		}

		public function set offsetY(value:int):void
		{
			_offsetY = value;
		}

		public function get offsetX():int
		{
			return _offsetX;
		}

		public function set offsetX(value:int):void
		{
			_offsetX = value;
		}

		public function get subface():String
		{
			return _subface;
		}

		public function set subface(value:String):void
		{
			_subface = value;
			_subfaceArr.length = 0;
			
			if(value == ""){
				_subfaceArr[0] = new Vector.<int>(); 
			}else{
				var a:Array = _subface.split('|');
				var aa:Array = null;
				for(var row:int = 0; row < a.length; row++){
					aa = a[row].split('&');
					_subfaceArr[row] = new Vector.<int>();
					for(var col:int = 0; col < aa.length; col++){
						_subfaceArr[row][col] = int(aa[col]);
					}
				}				
			}
		}

		public function get asset():String
		{
			return _asset;
		}

		public function set asset(value:String):void
		{
			_asset = value;
		}
		
		public function getUrl():String{
			return ProjectManager.instance.curProjectData.path + File.separator + "assets" + File.separator + "furniture" + File.separator + _asset;
		}
		
		public function getSubfaceArr():Vector.<Vector.<int>>{
			return this._subfaceArr;
		}
		
		public function setSubfaceArr(row:int, col:int, has:Boolean):void{
			if(row > -1 && row < _subfaceArr.length && col > -1 && col < _subfaceArr[0].length){
				_subfaceArr[row][col] = has ? 1 : 0;
			}else{
				var newSubfaceArr:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
				var rows:int = MathUtil.max(row + 1, _subfaceArr.length);
				var cols:int = MathUtil.max(col + 1, _subfaceArr.length > 0 ? _subfaceArr[0].length : 0);
				for(var r:int = 0; r < rows; r++){
					newSubfaceArr[r] = new Vector.<int>();
					for(var c:int = 0; c < cols; c++){
						newSubfaceArr[r][c] = r < _subfaceArr.length && c < _subfaceArr[r].length ? _subfaceArr[r][c] : 0; 
					}
				}
				newSubfaceArr[row][col] = has ? 1 : 0;
				_subfaceArr = newSubfaceArr;
			}
			
			// 把全是0的row删掉
			var remove:Boolean;
			for(r = _subfaceArr.length - 1; r > -1; r--){
				remove = true;
				for(var i:int = 0; i < _subfaceArr[r].length; i++){
					if(_subfaceArr[r][i] == 1){
						remove = false;
						break;
					}
				}
				if(remove){
					_subfaceArr.splice(r, 1);
				}
			}
			// 看看最后一列是不是全是0的，有的话也要删掉
			remove = true;
			for(r = 0; r < _subfaceArr.length; r++){
				if(_subfaceArr[r][_subfaceArr[r].length - 1] == 1){
					remove = false;
				}
			}
			if(remove){
				for(r = 0; r < _subfaceArr.length; r++){
					_subfaceArr[r].pop();
				}
			}
			
			var tmpArr:Array = [];
			for(r = 0; r < _subfaceArr.length; r++){
				tmpArr[r] = _subfaceArr[r].join("&");
			}
			_subface = tmpArr.join("|");
			trace(_subface);
		}

	}
}