package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import flash.display.DisplayObject;
	import flash.filesystem.*;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class Editor_screen extends MovieClip
	{
		var Mindnard;
		public var StartBlock;
		
		public function Editor_screen()
		{
			Mindnard = MovieClip(this.parent);
			
			// Add Toolbar.
			toolbar_loader_mc.addChild(new Toolbar_mc(Mindnard));
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			Mindnard.Stage_mc.addEventListener(MouseEvent.RIGHT_CLICK, onMouseRightClick);
		}
		
		private function onKeyboardDown(evt)
		{
			// Blocks_mc movement
			if (evt.keyCode == Keyboard.LEFT)
			{
				Blocks_mc.x += 10;
			}
			
			if (evt.keyCode == Keyboard.RIGHT)
			{
				Blocks_mc.x -= 10;
			}
			
			if (evt.keyCode == Keyboard.UP)
			{
				Blocks_mc.y += 10;
			}
			
			if (evt.keyCode == Keyboard.DOWN)
			{
				Blocks_mc.y -= 10;
			}
			
			if (evt.keyCode == 187 && evt.ctrlKey)
			{
				Blocks_mc.scaleX += 0.2;
				Blocks_mc.scaleY += 0.2;
			}
			
			if (evt.keyCode == 189 && evt.ctrlKey)
			{
				Blocks_mc.scaleX -= 0.2;
				Blocks_mc.scaleY -= 0.2;
			}
		}
		
		private function onStageMouseUp(evt)
		{
			if (Mindnard.draggedFlow != undefined)
			{
				Mindnard.draggedFlow.deleteFlow();
				Mindnard.draggedFlow = undefined;
			}
		}
		
		private function onMouseRightClick(evt)
		{
			// Right-click Menu
			Mindnard.ContextMenu_mc.clearOption();
			
			Mindnard.ContextMenu_mc.addOption("Start Block", addStart);
			Mindnard.ContextMenu_mc.addOption("New Input", addInput);
			
			var folder = File.applicationDirectory.resolvePath("MindnardScripts/");
			var files = folder.getDirectoryListing();
			
			for (var i = 0; i < files.length; i++)
			{
				Mindnard.ContextMenu_mc.addOption(Mindnard.getFileName(files[i].name), readFile, [files[i].name]);
			}
			
			Mindnard.ContextMenu_mc.showMenu();
		}
		
		// Built-in Start
		private function addStart()
		{
			// TODO: Disallow multiple StartBlock - currentely only the latest added one will be used by Mindnard.Compile,
			Mindnard.ContextMenu_mc.hideMenu();
			
			var local = globalToLocal(new Point(stage.mouseX, stage.mouseY));
			
			StartBlock = new Block_mc(Mindnard, this);
			StartBlock.setHeaderTitle("Start");
			StartBlock.x = local.x;
			StartBlock.y = local.y;
			
			// Insert block
			Blocks_mc.addChild(StartBlock);
		}
		
		// Built-in Input
		public function addInput()
		{
			Mindnard.ContextMenu_mc.hideMenu();
			
			var local = globalToLocal(new Point(stage.mouseX, stage.mouseY));
			
			var block = new Block_mc(Mindnard, this);
			block.setHeaderTitle("Input");
			block.x = local.x;
			block.y = local.y;
			
			// Insert block
			Blocks_mc.addChild(block);
			
			block.addParameterField(new ParameterField_mc("Input", block, Mindnard));
			block.setInput();
		}
		
		// External
		public function readFile(fileName)
		{
			var function_name;
			
			Mindnard.ContextMenu_mc.hideMenu();
			Mindnard.ContextMenu_mc.clearOption();
			
			// Read file content
			var fileLoader = new URLLoader();
			
			fileLoader.addEventListener(Event.COMPLETE, onFileLoaded);
			
			fileLoader.load(new URLRequest("MindnardScripts/" + fileName));
			
			function onFileLoaded(evt)
			{
				var lines = evt.target.data.split(/\n/);
				
				for (var i = 0; i < lines.length; i++)
				{
					if (lines[i].substr(0, 3) == "def")
					{
						function_name = lines[i].split("(");
						function_name = function_name[0].split(" ")[1];
						
						Mindnard.ContextMenu_mc.addOption(function_name, addFunction, [function_name, lines[i], fileName]);
					}
				}
				
				Mindnard.ContextMenu_mc.showMenu();
			}
		}
		
		public function addFunction(_params)
		{
			var func_name = _params[0];
			var func_def = _params[1];
			var lib_name = _params[2];
			
			Mindnard.ContextMenu_mc.hideMenu();
			
			// Read block content
			var parameters = func_def.split(/\n/);
			
			parameters = parameters[0].split("(");
			parameters = parameters[1].split(")");
			parameters = parameters[0].split(",");
			
			// Set up block location and title
			var local = globalToLocal(new Point(stage.mouseX, stage.mouseY));
			
			var block = new Block_mc(Mindnard, this, lib_name, func_name);
			block.setHeaderTitle(func_name);
			block.x = local.x;
			block.y = local.y;
			
			// Set up block parameters
			for (var i = 0; i < parameters.length; i++)
			{
				block.addParameter(new Parameter_mc(parameters[i], block, Mindnard));
			}
			
			// Insert block
			Blocks_mc.addChild(block);
		}
	}
}
