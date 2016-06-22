package com.apowo.tuqing.events
{
	import org.libra.events.BaseEvent;
	
	public final class ProjectTreeEvent extends BaseEvent
	{
		
		public static const PROJECT_TREE_EVENT:String = "projectTreeEvent";
		
		public static const SELECTED_ITEM_CHANGED:String = "selectedItemChanged";
		
		public function ProjectTreeEvent(subType:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(PROJECT_TREE_EVENT, subType, data, bubbles, cancelable);
		}
	}
}