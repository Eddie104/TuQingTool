package com.apowo.tuqing.model.data
{
	public class BaseData
	{
		
		protected var _type:int;
		
		protected var _name:String;
		
		protected var _des:String;
		
		public function BaseData()
		{
		}

		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get des():String
		{
			return _des;
		}

		public function set des(value:String):void
		{
			_des = value;
		}
		
		public function toString():String{
			return _name;
		}

	}
}