package
{
	import com.feng.FUI;
	import com.feng.components.FButton;
	import com.feng.components.FHScrollBar;
	import com.feng.components.FHSlider;
	import com.feng.components.FList;
	import com.feng.components.FVScrollBar;
	import com.feng.components.FVSlider;
	import com.test.MyListItem;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import fla.ui.UITest;

	[SWF(width = "1000", height = "580", frameRate = "30"]
	public class TestUI extends Sprite
	{
		public function TestUI()
		{
			FUI.init(stage);
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
			var tHSlider:FHSlider = FHSlider.getInstance(uiTest.tHSlider);
			tHSlider.backClick = true;

			tHSlider.addEventListener(Event.CHANGE, function(event:Event):void
			{
				tScrollBar.setThumbPercent(tHSlider.value / tHSlider.maximum);
				hScrollBar.setThumbPercent(tHSlider.value / tHSlider.maximum);
				trace(tScrollBar.value, tScrollBar.minimum, tScrollBar.maximum);
			});

			//VSlider
			var tVSlider:FVSlider = FVSlider.getInstance(uiTest.tVSlider);
			tVSlider.backClick = true;

			tVSlider.addEventListener(Event.CHANGE, function(event:Event):void
			{
				trace(tVSlider.value)
			});

			//ScrollBar
			var tScrollBar:FVScrollBar = FVScrollBar.getInstance(uiTest.tVScrollBar);
			var hScrollBar:FHScrollBar = FHScrollBar.getInstance(uiTest.tHScrollBar);

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
