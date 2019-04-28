package
{
	// ev3dev -l robot -pw maker < README.txt "cat > ~/README.txt"
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.filesystem.*;
	import flash.filesystem.FileStream;
	
	public class Mindnard extends MovieClip
	{
		public var draggedFlow;
		
		public function Mindnard()
		{
		}
		
		// Compile the visual scripting to Python
		public function Compile(evt:MouseEvent)
		{
			var pythonCode = addImports();
			var connected;
			
			if (Editor_mc.StartBlock == undefined)
				return;
			
			// Define main function
			pythonCode += "\ndef main():\n";
			
			// First block
			connected = Editor_mc.StartBlock.getConnected();
			pythonCode += "\t" + getFileName(connected.BlockLib) + "." + connected.BlockFunc + "(";
			pythonCode += getParametersString(connected) + ")\n";
			
			// Save the file to local
			SaveFile(pythonCode);
		}
		
		// Python code generation helpers
		private function addImports()
		{
			var importStatements = "#!/usr/bin/env python3\n\nfrom ev3dev.ev3 import *\n";
			
			var folder = File.applicationDirectory.resolvePath("MindnardScripts/");
			var files = folder.getDirectoryListing();
			
			for (var i = 0; i < files.length; i++)
			{
				importStatements += "import MindnardLibs." + getFileName(files[i].name) + "\n";
			}
			
			return importStatements;
		}
		
		public function getFileName(fileName)
		{
			return fileName.substr(0, fileName.length - 3);
		}
		
		public function getParametersString(Block_mc)
		{
			var parametersString = "";
			var parameters = Block_mc.parameters;
			
			for (var i = 1; i < parameters.length; i++)
			{
				parametersString += parameters[i].getParameterName() + " = " + parameters[i].getValue() + ",";
			}
			
			return parametersString;
		}
		
		// Misc helpers
		public function SaveFile(code)
		{
			var nativeLocation = File.applicationDirectory.resolvePath("python/compiled.py");
			nativeLocation = File.desktopDirectory.resolvePath(nativeLocation.nativePath);
			
			var stream = new FileStream();
			stream.open(nativeLocation, FileMode.WRITE);
			stream.writeUTFBytes(code);
			stream.close();
			
			trace(code);
		}
	}
}
