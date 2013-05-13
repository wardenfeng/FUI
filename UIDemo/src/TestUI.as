package
{
	import com.feng.components.FButton;
	import com.feng.components.FList;
	import com.feng.components.FScrollBar;
	import com.feng.components.FSlider;
	import com.test.MyListItem;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import fla.ui.UITest;

	public class TestUI extends Sprite
	{
		public function TestUI()
		{
			var uiTest:UITest = new UITest();
			addChild(uiTest);

			//button
			var tBtn:FButton = FButton.getInstance(uiTest.tBtn);
			tBtn.label = "test";
			tBtn.enabled = true;

			tBtn.addEventListener(MouseEvent.CLICK, function(e:Event):void
			{
				tBtn.selected = !tBtn.selected;
			});

			//HSlider
			var tHSlider:FSlider = FSlider.getInstance(uiTest.tHSlider, FSlider.HORIZONTAL);
			tHSlider.backClick = true;

			tHSlider.addEventListener(Event.CHANGE, function(event:Event):void
			{
				tScrollBar.setThumbPercent(tHSlider.value / tHSlider.maximum);
				hScrollBar.setThumbPercent(tHSlider.value / tHSlider.maximum);
				trace(tScrollBar.value, tScrollBar.minimum, tScrollBar.maximum);
			});

			//VSlider
			var tVSlider:FSlider = FSlider.getInstance(uiTest.tVSlider, FSlider.VERTICAL);
			tVSlider.backClick = true;

			tVSlider.addEventListener(Event.CHANGE, function(event:Event):void
			{
				trace(tVSlider.value)
			});

			//ScrollBar
			var tScrollBar:FScrollBar = FScrollBar.getInstance(uiTest.vScrollBar, FSlider.VERTICAL);
			var hScrollBar:FScrollBar = FScrollBar.getInstance(uiTest.hScrollBar, FSlider.HORIZONTAL);

			tScrollBar.addEventListener(Event.CHANGE, function(event:Event):void
			{
				trace(tScrollBar.value);
			});

			hScrollBar.addEventListener(Event.CHANGE, function(event:Event):void
			{
				trace(hScrollBar.value);
			});

			//list
			var tList:FList = FList.getInstance(uiTest.tList);
			tList.listItemClass = MyListItem;
			tList.alternateRows = true;
			tList.autoHideScrollBar = true;

			var items:Array = [];
			for (var i:int = 0; i < 80; i++)
			{
				items.push(i.toString());
			}
			tList.items = items;
		}
	}
}
