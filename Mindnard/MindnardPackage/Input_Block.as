package MindnardPackage
{
	public class Input_Block extends Block_mc
	{
		public var ParameterField;
		public var parameterFieldCount = 0;
		
		public function Input_Block(_Mindnard, _Editor_screen)
		{
			super(_Mindnard, _Editor_screen);
			
			super.nextConnector.y = 45;
		}
		
		public function addParameterField(_ParameterField:ParameterField_mc)
		{
			ParameterField = _ParameterField;
			
			_ParameterField.x = 0;
			_ParameterField.y = _ParameterField.height * parameterFieldCount;
			
			super.ParameterLoader_mc.addChild(_ParameterField);
			
			parameterFieldCount += 1;
		}
		
		public function getInputValue()
		{
			return ParameterField.getInputValue();
		}
	}
}
