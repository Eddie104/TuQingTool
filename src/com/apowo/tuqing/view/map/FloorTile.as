package com.apowo.tuqing.view.map
{
	import com.apowo.tuqing.model.ProjectManager;
	
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	
	import org.libra.utils.displayObject.Display45Util;
	import org.libra.utils.displayObject.GraphicsUtil;
	
	public final class FloorTile extends UIComponent
	{
		public function FloorTile(row:int, col:int)
		{
			super();
			GraphicsUtil.fillDiamond(this.graphics, ProjectManager.instance.curProjectData.cellWidth, 0x00ff00);
			var p:Point = Display45Util.getItemPos(row, col);
			this.x = p.x - (ProjectManager.instance.curProjectData.cellWidth >> 1);
			this.y = p.y;
		}
	}
}