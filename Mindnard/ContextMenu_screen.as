package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ContextMenu_screen extends MovieClip
	{
		public function ContextMenu_screen()
		{
			this.visible = false;
		}
		
		public function showMenu()
		{
			this.x = stage.mouseX;
			this.y = stage.mouseY;
			
			this.visible = true;
		}
		
		public function hideMenu()
		{
			this.visible = false;
			
			clearOption();
		}
		
		public function addOption(optionName, _callbackFunction, _callbackArgs = null)
		{
			var option = new ContextMenu_Option_mc(optionName, _callbackFunction, _callbackArgs);
			option.y = ContextMenu_Option_Loader_mc.numChildren * option.height;
			
			ContextMenu_Option_Loader_mc.addChild(option);
		}
		
		public function clearOption()
		{
			while (ContextMenu_Option_Loader_mc.numChildren > 0)
				ContextMenu_Option_Loader_mc.removeChildAt(0);
		}
	}
}
