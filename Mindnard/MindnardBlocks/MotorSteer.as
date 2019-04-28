package MindnardBlocks
{
	public class MotorSteer extends Block_mc
	{
		var Mindnard;
		
		public function MotorSteer(_Mindnard)
		{
			Mindnard = _Mindnard;
			
			super(Mindnard);
			super.setHeaderTitle("Motor Steering");
			
			var powerParameter = new Parameter_mc("Power");
			var degreeParameter = new Parameter_mc("Degree");
			
			super.addParameter(powerParameter);
			super.addParameter(degreeParameter);
		}
	}
}
