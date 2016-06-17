package com.apowo.tuqing.events
{
	import org.libra.events.BaseEvent;
	
	public final class ProjectEvent extends BaseEvent
	{
		
		public static const PROJECT_EVENT:String = "projectEvent";
		
		public static const NEW_PROJECT:String = "newProject";
		
		public static const DELETE_PROJECT:String = "deleteProject";
		
		public static const SELECT_PROJECT:String = "selectProject";
		
		public function ProjectEvent(subType:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(PROJECT_EVENT, subType, data, bubbles, cancelable);
		}
	}
}