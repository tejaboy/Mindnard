package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import fl.motion.Color;
	import flash.utils.getQualifiedClassName;
	
	import MindnardPackage.Flow_Connector;
	
	public class Block_Connector_mc extends Flow_Connector
	{
		var Block_mc;
		var Mindnard;
		var Flows_mc;
		
		public var Connected;
		
		var colour:Color = new Color();
		
		public function Block_Connector_mc(_Block_mc)
		{
			Block_mc = _Block_mc;
			Mindnard = Block_mc.Mindnard;
			Flows_mc = Mindnard.Editor_mc.Flows_mc;
			
			// On Flow Mouseup
			this.addEventListener(MouseEvent.MOUSE_UP, onSelfMouseUp);
			
			// Mouse over handler
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
		}
		
		public function setupFlowConnector()
		{
			super.setupFlow(this, Block_mc, Mindnard, Flows_mc);
		}
		
		// On Flow Mouseup
		private function onSelfMouseUp(evt)
		{
		}
		
		// Mouse over
		private function mouseOverHandler(evt)
		{
			colour.setTint(0xF0F0F0, 0.8);
			this.transform.colorTransform = colour;
		}
		
		private function mouseOutHandler(evt)
		{
			colour.setTint(0xFFAAFF, 0);
			this.transform.colorTransform = colour;
		}
		
		// Reset
		public override function resetFlowOrigin()
		{
			super.resetFlowOrigin();
		}
		
		// Delte flow
		public override function deleteFlow()
		{
			super.deleteFlow();
			
			// Delete connected input reference
			if (Connected != undefined)
			{
				Connected.Input = undefined;
				Connected = undefined;
			}
		}
		
		// Set Connected
		public function setConnected(_Connected)
		{
			Connected = _Connected;
			
			super.resetFlowOrigin();
		}
		
		// Check if is input type
		public function isInput()
		{
			return flash.utils.getQualifiedClassName(Block_mc) == "MindnardPackage::Input_Block";
		}
		
		// Get input if is built-in type
		public function getInputValue()
		{
			return Block_mc.getInputValue();
		}
	}
}