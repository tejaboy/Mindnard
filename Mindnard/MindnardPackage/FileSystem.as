package MindnardPackage
{
	import flash.filesystem.*;
	import flash.filesystem.FileStream;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.ProgressEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.IOErrorEvent;
	
	public class FileSystem
	{
		private var Mindnard;
		private var process;
		
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
			
			SaveToEV3();
		}
		
		public function SaveToEV3()
		{
			var plink = File.applicationDirectory.resolvePath("PuTTY/plink.exe");
			plink = File.desktopDirectory.resolvePath(plink.nativePath);
			
			var processArgs:Vector.<String> = new Vector.<String>();
			processArgs.push("ev3dev");
			processArgs.push(" -l");
			processArgs.push(" robot");
			processArgs.push(" -pw");
			processArgs.push(" maker");
			
			var nativeProcessStartupInfo = new NativeProcessStartupInfo();
			nativeProcessStartupInfo.arguments = processArgs;
			nativeProcessStartupInfo.executable = plink;
			
			process = new NativeProcess();
			
			process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputDataHandler);
			process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorDataHandler);
			process.addEventListener(NativeProcessExitEvent.EXIT, onExitHandler);
			process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOErrorHandler);
			process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOErrorHandler);
			
			process.start(nativeProcessStartupInfo);
		}
		
		function onOutputDataHandler(evt)
		{
			e("onOutputDataHandler: ", process.standardOutput.readUTFBytes(process.standardOutput.bytesAvailable)); 
		}
		
		function onErrorDataHandler(evt)
		{
			trace("onErrorDataHandler: ", process.standardError.readUTFBytes(process.standardError.bytesAvailable)); 
		}
		
		function onExitHandler(evt)
		{
			trace("onExitHandler: Process exited with ", evt.exitCode);
		}
		
		function onIOErrorHandler(evt)
		{
			trace("onIOErrorHandler: " + evt.toString());
		}
	}
}
