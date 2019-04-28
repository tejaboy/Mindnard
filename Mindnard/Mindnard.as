package
{
	// ev3dev -l robot -pw maker < README.txt "cat > ~/README.txt"
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filesystem.*;
	import flash.filesystem.FileStream;
	
	import MindnardPackage.Compiler;
	
	public class Mindnard extends MovieClip
	{
		public var draggedFlow;
		private var Compiler;
		
		public function Mindnard()
		{
			Compiler = new MindnardPackage.Compiler(this);
		}
		
		// Compile the visual scripting to Python
		public function Compile(evt:MouseEvent)
		{
			SaveFile(Compiler.Compile());
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
		
		public function getFileName(fileName)
		{
			return fileName.substr(0, fileName.length - 3);
		}
	}
}
