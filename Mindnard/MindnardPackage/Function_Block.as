package MindnardPackage
{
	public class Function_Block extends Block_mc
	{
		public var parameters = [];
		public var BlockLib:String;
		public var BlockFunc;
		
		public function Function_Block(_Mindnard, _Editor_screen, _BlockLib = undefined, _BlockFunc = undefined)
		{
			super(_Mindnard, _Editor_screen);
			
			BlockLib = _BlockLib;
			BlockFunc = _BlockFunc;
			
			// Create previous connector
			addParameter(new Parameter_mc("_Next", this, Mindnard));
		}
		
		public function addParameter(_Parameter:Parameter_mc)
		{
			parameters.push(_Parameter);
			
			_Parameter.x = 10 + (10 + _Parameter.width) * (parameters.length - 1);
			_Parameter.y = -(_Parameter.height) * 2.2;
			
			ParameterLoader_mc.addChild(_Parameter);
		}
		
		override public function removeBlock()
		{
			super.removeBlock();
			
			for (var i = 0; i < parameters.length; i++)
			{
				parameters[i].deleteFlow();
			}
		}
	}
}
