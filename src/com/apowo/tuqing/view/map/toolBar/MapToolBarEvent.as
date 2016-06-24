package com.apowo.tuqing.view.map.toolBar
{
	import org.libra.events.BaseEvent;
	
	public final class MapToolBarEvent extends BaseEvent
	{
		
		public static const MAP_TOOL_BAR_EVENT:String = "mapToolBarEvent";
		
		public static const MAP_OPERATOR:String = "mapOperator";
		
		public static const MAP_CAN_MOVE:String = "mapCanMove";
		
		public static const MAP_CAN_NOT_MOVE:String = "mapCanNotMove";
		
		public static const FURNITURE_OPERATOR:String = "furnitureOperator";
		
		public function MapToolBarEvent(subType:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(MAP_TOOL_BAR_EVENT, subType, data, bubbles, cancelable);
		}
	}
}