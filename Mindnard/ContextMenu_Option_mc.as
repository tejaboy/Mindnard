package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.*;
	
	public class ContextMenu_Option_mc extends MovieClip
	{
		var callbackFunction;
		var callbackArgs;
		
		public function ContextMenu_Option_mc(optionName, _callbackFunction, _callbackArgs)
		{
			callbackFunction = _callbackFunction;
			callbackArgs = _callbackArgs;
			
			Option_txt.text = optionName;
			
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			// Mouse over effect
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function onMouseClick(evt)
		{
			if (callbackArgs == null)
				callbackFunction();
			else
			{
				callbackFunction(callbackArgs);
			}
		}
		
		// Mouse over effect
		private function onMouseOver(evt)
		{
			var glowFilter = new GlowFilter();
			glowFilter.blurX = 12;
			glowFilter.blurY = 12;
			glowFilter.quality = 2;
			glowFilter.strength = 2;
			glowFilter.color = 0xFFFF00;
			
			this.filters = [glowFilter];
		}
		
		private function onMouseOut(evt)
		{
			this.filters = [];
		}
	}
}
