package MindnardPackage
{
	import flash.filesystem.*;
	
	public class Compiler
	{
		private var Mindnard;
		private var Editor_mc;
		
		public function Compiler(_Mindnard)
		{
			Mindnard = _Mindnard;
			Editor_mc = Mindnard.Editor_mc;
		}
		
		// Compile the visual scripting to Python
		public function Compile()
		{
			var pythonCode = addImports();
			var connected;
			
			if (Editor_mc.StartBlock == undefined)
				return;
			
			// Define main function
			pythonCode += "\ndef main():\n";
			
			// First block
			connected = Editor_mc.StartBlock.getConnected();
			pythonCode += "\t" + Mindnard.getFileName(connected.BlockLib) + "." + connected.BlockFunc + "(";
			pythonCode += getParametersString(connected) + ")\n";
			
			return pythonCode;
		}
		
		// Python code generation helpers
		private function addImports()
		{
			var importStatements = "#!/usr/bin/env python3\n\nfrom ev3dev.ev3 import *\n";
			
			var folder = File.applicationDirectory.resolvePath("MindnardScripts/");
			var files = folder.getDirectoryListing();
			
			for (var i = 0; i < files.length; i++)
			{
				importStatements += "import MindnardLibs." + Mindnard.getFileName(files[i].name) + "\n";
			}
			
			return importStatements;
		}
		
		public function getParametersString(Block_mc)
		{
			var parametersString = "";
			var parameters = Block_mc.parameters;
			var parameterName;
			var parameterValue;
			
			for (var i = 1; i < parameters.length; i++)
			{
				// Parameters[i] is Parameter_mc
				parameterName = parameters[i].getParameterName();
				parameterValue = parameters[i].getValue();
				
				if (parameterValue == undefined)
				{
					if (parameters[i].hasDefaultValue())
					{
						parameterValue = parameters[i].getDefaultValue();
					}
				}
				
				parametersString += parameterName + " = " + parameterValue + ", ";
			}
			
			return parametersString;
		}
	}
}
