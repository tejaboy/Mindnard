package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.filters.*;
	
	public class Toolbar_Button_mc extends MovieClip
	{
		var Mindnard;
		
		public function Toolbar_Button_mc(_buttonName:String, _Mindnard)
		{
			Mindnard = _Mindnard;
			this.buttonMode = true;
			
			button_txt.text = _buttonName;
			
			// Mouse over effect
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		// Mouse over effect
		private function onMouseOver(evt)
		{
			var glowFilter = new GlowFilter();
			glowFilter.blurX = 15;
			glowFilter.blurY = 15;
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
