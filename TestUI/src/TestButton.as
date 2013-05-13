package
{
	import com.bit101.components.PushButton;
	import com.feng.components.FButton;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import fla.ui.ButtonTest;

	public class TestButton extends Sprite
	{
		public function TestButton()
		{
			var testBtn:PushButton = new PushButton(this, 0, 0, "test");

			var bTest:ButtonTest = new ButtonTest()
			addChild(bTest);

			var tBtn:FButton = FButton.getInstance(bTest.tBtn);

			tBtn.label = "test";

			tBtn.enabled = true;

			tBtn.addEventListener(MouseEvent.CLICK, function(e:Event):void
			{
				tBtn.selected = !tBtn.selected;
			});
		}
	}
}
