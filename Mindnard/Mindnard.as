package
{
	// ev3dev -l robot -pw maker < README.txt "cat > ~/README.txt"
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import MindnardPackage.Compiler;
	import MindnardPackage.FileSystem;
	
	public class Mindnard extends MovieClip
	{
		private var FileSystem;
		private var Compiler;
		public var draggedFlow;
		
		public function Mindnard()
		{
			FileSystem = new MindnardPackage.FileSystem(this);
			Compiler = new MindnardPackage.Compiler(this);
		}
		
		// Compile the visual scripting to Python
		public function Compile(evt:MouseEvent)
		{
			FileSystem.SaveFile(Compiler.Compile());
		}
		
		// Misc helpers
		public function getFileName(fileName)
		{
			return fileName.substr(0, fileName.length - 3);
		}
	}
}
