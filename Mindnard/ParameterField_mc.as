package
{
	import flash.display.MovieClip;
	
	public class ParameterField_mc extends MovieClip
	{
		var Block_mc;
		var Mindnard;
		var Flows_mc;
		
		public function ParameterField_mc(ParameterName:String, _Block_mc, _Mindnard)
		{
			Block_mc = _Block_mc
			Mindnard = _Mindnard;
			Flows_mc = Mindnard.Editor_mc.Flows_mc;
		}
		
		public function getInputValue()
		{
			return Input_txt.text;
		}
	}
}
