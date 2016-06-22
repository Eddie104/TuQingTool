package com.apowo.tuqing.events
{
	import org.libra.events.BaseEvent;
	
	public final class MapEvent extends BaseEvent
	{
		
		public static const MAP_EVENT:String = "mapEvent";
		
		public static const NEW_FILE:String = "newFile";
		
		public static const OPEN_FILE:String = "openFile";
		
		public static const DELETE_FILE:String = "deleteFile";
		
		public static const EDIT_FILE:String = "editFile";
		
//		public static const MAP_CHANGED:String = "mapChanged";
		
		public function MapEvent(subType:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(MAP_EVENT, subType, data, bubbles, cancelable);
		}
	}
}