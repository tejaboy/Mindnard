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
		var parameters = [];
		var parameterFieldCount = 0;
		var Mindnard;
		var Editor_screen;
		public var BlockLib:String;
		public var BlockFunc;
		public var nextConnector;
		public var prevConnector;
		
		public var builtIn = false;
		public var ParameterField;
		
		public function Block_mc(_Mindnard, _Editor_screen, _BlockLib = undefined, _BlockFunc = undefined)
		{
			Mindnard = _Mindnard;
			Editor_screen = _Editor_screen
			BlockLib = _BlockLib;
			BlockFunc = _BlockFunc;
			
			// Create output connector
			nextConnector = new Block_Connector_mc(this);
			nextConnector.x = this.width / 2 - (nextConnector.width / 2);
			nextConnector.y = 14;
			
			Block_Connector_Loader_mc.addChild(nextConnector);
			
			nextConnector.setupFlowConnector();
			
			// Create input connector
			prevConnector = new Parameter_mc("_Next", this, Mindnard);
			addParameter(prevConnector);
			
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
		
		// Public methods - accessing property
		public function getConnected()
		{
			return nextConnector.Connected.Block_mc;
		}
		
		public function getConnectedParameter()
		{
			return nextConnector.Connected;
		}
		
		public function getInputValue()
		{
			return ParameterField.getInputValue();
		}
		
		// Public methods - configuration
		public function setHeaderTitle(_title)
		{
			Block_Header_mc.Title_txt.text = _title;
		}
		
		public function addParameter(_Parameter:Parameter_mc)
		{
			parameters.push(_Parameter);
			
			_Parameter.x = 10 + (10 + _Parameter.width) * (parameters.length - 1);
			_Parameter.y = -(_Parameter.height) * 2.2;
			
			ParameterLoader_mc.addChild(_Parameter);
		}
		
		public function setInput()
		{
			nextConnector.y += (parameterFieldCount * 30);
			ParameterLoader_mc.removeChildAt(0);
			
			builtIn = true;
		}
		
		public function addParameterField(_ParameterField:ParameterField_mc)
		{
			ParameterField = _ParameterField;
			
			_ParameterField.x = 0;
			_ParameterField.y = _ParameterField.height * parameterFieldCount;
			
			ParameterLoader_mc.addChild(_ParameterField);
			
			parameterFieldCount += 1;
		}
		
		// Menu
		private function onBlockHeaderRightClick(evt)
		{
			Mindnard.ContextMenu_mc.clearOption();
			Mindnard.ContextMenu_mc.addOption("Remove Block", removeBlockAnimation);
			Mindnard.ContextMenu_mc.showMenu();
		}
		
		public function removeBlockAnimation()
		{
			Mindnard.ContextMenu_mc.hideMenu();
			
			TweenLite.to(this, 0.42, {x: 0, y: 720, rotationX: 100, rotationY: 90, alpha: 0, onComplete: removeBlock})
		}
		
		public function removeBlock()
		{
			// Remove Input and Connected reference
			nextConnector.deleteFlow();
			
			for (var i = 0; i < parameters.length; i++)
			{
				parameters[i].deleteFlow();
			}
			
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
