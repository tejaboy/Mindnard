package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.filters.*;
	
	public class Toolbar_mc extends MovieClip
	{
		var Mindnard;
		var SaveButton;
		var CompileButton;
		
		public function Toolbar_mc(_Mindnard)
		{
			Mindnard = _Mindnard;
			
			// Mouse over effect
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			setupSave();
			setupCompile();
		}
		
		private function setupSave()
		{
			SaveButton = new Toolbar_Button_mc("Save", Mindnard);
			
			addButton(SaveButton);
		}
		
		private function setupCompile()
		{
			CompileButton = new Toolbar_Button_mc("Compile", Mindnard);
			
			addButton(CompileButton);
			
			// Add event listeners
			CompileButton.addEventListener(MouseEvent.CLICK, Mindnard.Compile);
		}
		
		// Add button
		private function addButton(button)
		{
			tool_loader_mc.addChild(button);
			
			button.x = button.width * (tool_loader_mc.numChildren - 1);
		}
		
		// Mouse over effect
		private function onMouseOver(evt)
		{
			var glowFilter = new GlowFilter();
			glowFilter.blurX = 12;
			glowFilter.blurY = 12;
			glowFilter.quality = 2;
			glowFilter.strength = 2;
			glowFilter.color = 0x000000;
			
			this.filters = [glowFilter];
		}
		
		private function onMouseOut(evt)
		{
			this.filters = [];
		}
	}
}
