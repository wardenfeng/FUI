package
{
	import com.feng.components.FHScrollSlider;
	import com.feng.components.FScrollSlider;
	import com.feng.components.FSlider;
	import com.feng.components.FVScrollSlider;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import fla.ui.ScrollSliderTest;
	import fla.ui.SliderTest;

	public class TestScrollSlider extends Sprite
	{
		public function TestScrollSlider()
		{
			var sliderTest:SliderTest = new SliderTest();

			addChild(sliderTest);

			var tHSlider:FSlider = FSlider.getInstance(sliderTest.tHSlider, FSlider.HORIZONTAL);
			tHSlider.backClick = true;

			sliderTest.tHSlider.x = 40;

			var scrollSliderTest:ScrollSliderTest = new ScrollSliderTest();
			addChild(scrollSliderTest);
			var vScrollSlider:FVScrollSlider = FVScrollSlider.getInstance(scrollSliderTest.vScrollSlider);
			vScrollSlider.backClick = true;

			var hScrollSlider:FHScrollSlider = FHScrollSlider.getInstance(scrollSliderTest.hScrollSlider);
			vScrollSlider.backClick = true;

			tHSlider.addEventListener(Event.CHANGE, function(event:Event):void
			{
				vScrollSlider.setThumbPercent(tHSlider.value / 100);
				hScrollSlider.setThumbPercent(tHSlider.value / 100);
				trace(vScrollSlider.value, vScrollSlider.minimum, vScrollSlider.maximum);
			});

			vScrollSlider.addEventListener(Event.CHANGE, function(event:Event):void
			{
				trace(vScrollSlider.value);
			});

			hScrollSlider.addEventListener(Event.CHANGE, function(event:Event):void
			{
				trace(hScrollSlider.value);
			});



		}
	}
}
