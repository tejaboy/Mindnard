package MindnardPackage
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.geom.Point;
	
	public class Flow_Connector extends MovieClip
	{
		var Connector;
		var Block_mc;
		var Mindnard;
		var Flows_mc;
		
		var Connected;
		
		var line;
		var mouseDownState = false;
		
		public function Flow_Connector()
		{
		}
		
		public function setupFlow(_Connector, _Block_mc, _Mindnard, _Flows_mc)
		{
			Connector = _Connector;
			Block_mc = _Block_mc;
			Mindnard = _Mindnard;
			Flows_mc = _Flows_mc;
			
			line = new Shape();
			
			Flows_mc.addChild(line);
			
			// Set origin position
			resetFlowOrigin();
			
			// Drawing of line
			this.addEventListener(MouseEvent.MOUSE_DOWN, onSelfMouseDown);
			Mindnard.stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			this.addEventListener(Event.ENTER_FRAME, onSelfEnterFrame);
		}
		
		public function resetFlowOrigin()
		{
			var global = Block_mc.localToGlobal(new Point(Connector.x + (Connector.width / 2), Connector.y));
			
			line.x = global.x;
			line.y = global.y;
			
			// Reset end point
			if (Connector.Connected != undefined)
			{
				global = Connector.Connected.localToGlobal(new Point());
				var local = this.globalToLocal(global);
				
				line.graphics.clear();
				line.graphics.lineStyle(2, 0x000000);
				line.graphics.moveTo(0, 15);
				line.graphics.lineTo(local.x, local.y + (Connector.Connected.height / 2));
			}
		}
		
		// Drawing of line
		private function onSelfMouseDown(evt)
		{
			mouseDownState = true;
			Mindnard.draggedFlow = this;
		}
		
		private function onStageMouseUp(evt)
		{
			mouseDownState = false;
		}
		
		public function onSelfEnterFrame(evt)
		{
			resetFlowOrigin();
			
			if (mouseDownState)
			{
				var local = this.globalToLocal(new Point(stage.mouseX, stage.mouseY));
				
				line.graphics.clear();
				line.graphics.lineStyle(2, 0x000000);
				line.graphics.moveTo(0, 15);
				line.graphics.lineTo(local.x, local.y);
			}
		}
		
		// Delete line
		public function deleteFlow()
		{
			line.graphics.clear();
		}
	}
}