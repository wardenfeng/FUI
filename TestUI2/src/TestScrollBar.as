package
{
	import com.bit101.components.ScrollBar;
	import com.bit101.components.Slider;
	import com.feng.components.FHScrollBar;
	import com.feng.components.FHSlider;
	import com.feng.components.FScrollBar;
	import com.feng.components.FSlider;
	import com.feng.components.FVScrollBar;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import fla.ui.ScrollBarTest;
	import fla.ui.SliderTest;

	public class TestScrollBar extends Sprite
	{
		public function TestScrollBar()
		{
			new ScrollBar(Slider.VERTICAL, this);

			var sliderTest:SliderTest = new SliderTest();

			addChild(sliderTest);

			var tHSlider:FHSlider = FHSlider.getInstance(sliderTest.tHSlider);
			tHSlider.backClick = true;

			sliderTest.tHSlider.x = 40;

			var scrollSliderTest:ScrollBarTest = new ScrollBarTest();
			addChild(scrollSliderTest);

			var vScrollBar:FVScrollBar = FVScrollBar.getInstance(scrollSliderTest.vScrollBar);
			var hScrollBar:FHScrollBar = FHScrollBar.getInstance(scrollSliderTest.hScrollBar);

			tHSlider.addEventListener(Event.CHANGE, function(event:Event):void
			{
				vScrollBar.setThumbPercent(tHSlider.value / tHSlider.maximum);
				hScrollBar.setThumbPercent(tHSlider.value / tHSlider.maximum);
				trace(vScrollBar.value, vScrollBar.minimum, vScrollBar.maximum);
			});

			vScrollBar.addEventListener(Event.CHANGE, function(event:Event):void
			{
				trace(vScrollBar.value);
			});

			hScrollBar.addEventListener(Event.CHANGE, function(event:Event):void
			{
				trace(hScrollBar.value);
			});
		}
	}
}
