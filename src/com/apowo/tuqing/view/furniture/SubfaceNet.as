package com.apowo.tuqing.view.furniture
{
	import com.apowo.tuqing.model.ProjectManager;
	
	import flash.display.Shape;
	import flash.geom.Point;
	
	import org.libra.URI;
	import org.libra.utils.displayObject.Display45Util;
	import org.libra.utils.displayObject.GraphicsUtil;
	
	/**
	 * 占位的小网格
	 */
	public final class SubfaceNet extends Shape
	{
		public function SubfaceNet(row:int, col:int)
		{
			super();
			
			var cellWidth:int = ProjectManager.instance.curProjectData.cellWidth;
			var topPoint:Point = Display45Util.getTopPoint();
			this.graphics.lineStyle(1, 0x000000);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(0, cellWidth >> 1);
			this.graphics.moveTo(-cellWidth >> 1, cellWidth >> 2);
			this.graphics.lineTo(cellWidth >> 1, cellWidth >> 2);
			
			GraphicsUtil.drawDiamondNet(this.graphics, new Point(0 - topPoint.x, 0 - topPoint.y), 0, 0, 1, 1, cellWidth, 0x000000, false);
			var p:Point = Display45Util.getItemPos(row, col);
			this.x = p.x;
			this.y = p.y;
		}
	}
}