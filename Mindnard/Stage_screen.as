package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Stage_screen extends MovieClip
	{
		var Mindnard;
		
		public function Stage_screen()
		{
			Mindnard = MovieClip(this.parent);
			
			this.addEventListener(MouseEvent.CLICK, onClickEvent);
		}
		
		private function onClickEvent(evt)
		{
			Mindnard.ContextMenu_mc.hideMenu();
		}
	}
}
