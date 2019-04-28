package MindnardPackage
{
	import flash.filesystem.*;
	import flash.filesystem.FileStream;
	
	public class FileSystem
	{
		private var Mindnard;
		
		public function FileSystem(_Mindnard)
		{
			Mindnard = _Mindnard;
		}
		
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
