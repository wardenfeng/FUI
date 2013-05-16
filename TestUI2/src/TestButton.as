package
{
	import com.bit101.components.PushButton;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import fla.ui.ButtonTest;

	public class TestButton extends Sprite
	{
		public function TestButton()
		{
			var testBtn:PushButton = new PushButton(this, 0, 0, "test");

			var bTest:ButtonTest = new ButtonTest()
			addChild(bTest);

			bTest.tBtn.gotoAndStop(1);
			trace(bTest.tBtn, bTest.tBtn.numChildren);
			var disO:DisplayObject;
			var bm:Bitmap;
			var i:int = 0;
			for (i = 0; i < bTest.tBtn.numChildren; i++)
			{
				disO = bTest.tBtn.getChildAt(i);
				trace(disO, disO.name);
				bm = disO as Bitmap;
				if (bm)
				{
					trace(bm.bitmapData, bm.bitmapData)
				}
			}

			bTest.ttBtn.gotoAndStop(1);
			trace(bTest.ttBtn, bTest.ttBtn.numChildren);
			for (i = 0; i < bTest.ttBtn.numChildren; i++)
			{
				disO = bTest.ttBtn.getChildAt(i);
				trace(disO, disO.name);
				bm = disO as Bitmap;
				if (bm)
				{
					trace(bm.bitmapData, bm.bitmapData)
				}
			}





//			bTest.removeChild(bTest.tBtn);

//			var tBtn:FButton = new FButton(bTest.tBtn);
//			tBtn.x = 50;
//			tBtn.y = 50;
//			addChild(tBtn);

//			var tBtn:FButton = FButton.getInstance(bTest.tBtn);
//			tBtn.label = "test";
//
//			tBtn.enabled = true;
//
//			tBtn.addEventListener(MouseEvent.CLICK, function(e:Event):void
//			{
//				tBtn.selected = !tBtn.selected;
//			});
		}
	}
}
