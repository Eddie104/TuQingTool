package com.apowo.tuqing.view.furniture
{
	import org.libra.events.BaseEvent;
	
	public final class ToolBarEvent extends BaseEvent
	{
		
		public static const TOOL_BAR_EVENT:String = "toolBarEvent";
		
		public static const MOVE:String = "move";
		
		public static const SUB_FACE:String = "subFace";
		
		public function ToolBarEvent(subType:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(TOOL_BAR_EVENT, subType, data, bubbles, cancelable);
		}
	}
}