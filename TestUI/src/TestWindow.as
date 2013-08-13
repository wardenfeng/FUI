package
{
	import com.bit101.components.Window;
	import com.feng.components.FWindow;
	
	import flash.display.Sprite;
	
	import fla.ui.WindowTest;
	
	/**
	 * 
	 * @author warden_feng 2013-8-13
	 */
	public class TestWindow extends Sprite
	{
		public function TestWindow()
		{
			MyCC.initFlashConsole(this);
			
			var win:Window = new Window(this);
			win.hasMinimizeButton = true;
			
			var windowTest:WindowTest = new WindowTest()
			addChild(windowTest);
			
			var tBtn:FWindow = FWindow.getInstance(windowTest.tWindow);
		}
	}
}