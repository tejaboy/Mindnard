package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.filters.*;
	
	// Greensock
	import com.greensock.*;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.display.*;
	
	public class Block_mc extends MovieClip
	{
		public var Mindnard;
		public var Editor_screen;
		public var nextConnector;
		
		public var builtIn = false;
		
		public function Block_mc(_Mindnard, _Editor_screen)
		{
			Mindnard = _Mindnard;
			Editor_screen = _Editor_screen
			
			// Create output connector
			nextConnector = new Block_Connector_mc(this);
			nextConnector.x = this.width / 2 - (nextConnector.width / 2);
			nextConnector.y = 14;
			
			Block_Connector_Loader_mc.addChild(nextConnector);
			
			nextConnector.setupFlowConnector();
			
			// Dragging
			Block_Header_mc.DragOverlay_mc.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
			Block_Header_mc.DragOverlay_mc.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			Block_Header_mc.DragOverlay_mc.buttonMode = true;
			
			// Right click
			Block_Header_mc.addEventListener(MouseEvent.RIGHT_CLICK, onBlockHeaderRightClick);
			
			// Mouse over effect
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			// Animation
			this.rotationX = 100;
			this.rotationY = 90;
			this.alpha = 0;
			
			TweenLite.to(this, 0.42, {rotationX: 0, rotationY: 0, alpha: 1});
		}
		
		// Dragging
		private function startDragging(evt)
		{
			this.startDrag();
		}
		
		private function stopDragging(evt)
		{
			this.stopDrag();
			nextConnector.resetFlowOrigin();
		}
		
		// Public methods - accessing connected properties
		public function getConnected()
		{
			return nextConnector.Connected.Block_mc;
		}
		
		public function getConnectedParameter()
		{
			return nextConnector.Connected;
		}
		
		// Public methods - configuration
		public function setHeaderTitle(_title)
		{
			Block_Header_mc.Title_txt.text = _title;
		}
		
		// Right click context menu
		private function onBlockHeaderRightClick(evt)
		{
			Mindnard.ContextMenu_mc.clearOption();
			Mindnard.ContextMenu_mc.addOption("Remove Block", removeBlockAnimation);
			Mindnard.ContextMenu_mc.showMenu();
		}
		
		// Removing block
		public function removeBlockAnimation()
		{
			Mindnard.ContextMenu_mc.hideMenu();
			
			TweenLite.to(this, 0.42, {x: 0, y: 720, rotationX: 100, rotationY: 90, alpha: 0, onComplete: removeBlock})
		}
		
		public function removeBlock()
		{
			// Remove Input and Connected reference
			nextConnector.deleteFlow();
			
			// Remove child and this.
			Block_Connector_Loader_mc.removeChild(nextConnector);
			MovieClip(this.parent.removeChild(this));
		}
		
		// Mouse over effect
		private function onMouseOver(evt)
		{
			var glowFilter = new GlowFilter();
			glowFilter.blurX = 12;
			glowFilter.blurY = 12;
			glowFilter.quality = 2;
			glowFilter.strength = 2;
			glowFilter.color = 0x2E99FF;
			
			this.filters = [glowFilter];
		}
		
		private function onMouseOut(evt)
		{
			this.filters = [];
		}
	}
}
