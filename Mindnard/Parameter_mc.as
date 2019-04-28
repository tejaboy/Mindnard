package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	
	public class Parameter_mc extends MovieClip
	{
		var ParameterName;
		var Block_mc;
		var Mindnard;
		var Flows_mc;
		
		var Input;
		
		public function Parameter_mc(_ParameterName:String, _Block_mc, _Mindnard)
		{
			ParameterName = _ParameterName;
			Block_mc = _Block_mc
			Mindnard = _Mindnard;
			Flows_mc = Mindnard.Editor_mc.Flows_mc;
			
			// On Flow Mouseup
			this.addEventListener(MouseEvent.MOUSE_UP, onSelfMouseUp);
		}
		
		// On Flow Mouseup
		private function onSelfMouseUp(evt)
		{
			var type = flash.utils.getQualifiedClassName(Mindnard.draggedFlow);
			
			if (Mindnard.draggedFlow != this)
			{
				if (ParameterName == "_Next")
				{
					if (!Mindnard.draggedFlow.isBuiltIn())
					{
						setInput(Mindnard.draggedFlow);
					}
				}
				else
				{
					if (Mindnard.draggedFlow.isBuiltIn())
					{
						setInput(Mindnard.draggedFlow);
					}
				}
			}
			
			if (Input == undefined)
			{
				Mindnard.draggedFlow.deleteFlow();
			}
			
			Mindnard.draggedFlow = undefined;
		}
		
		// Misc
		private function setInput(input)
		{
			Input = input;
			Input.setConnected(this);
		}
		
		// Public method
		public function getParameterName()
		{
			return ParameterName;
		}
		
		public function getValue()
		{
			if (Input == undefined)
				return undefined;
			
			return Input.getInputValue();
		}
		
		// On deleted
		public function deleteFlow()
		{
			if (Input != undefined)
				Input.deleteFlow();
		}
	}
}
