package com.apowo.tuqing.events
{
	import org.libra.events.BaseEvent;
	
	public final class FurnitureEvent extends BaseEvent
	{
		
		public static const FURNITURE_EVENT:String = "furnitureEvent";
		
		public static const EDIT_FURNITURE:String = "editFurniture";
		
		public static const SELECT_FURNITURE:String = "selectFurniture";
		
		public function FurnitureEvent(subType:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(FURNITURE_EVENT, subType, data, bubbles, cancelable);
		}
	}
}