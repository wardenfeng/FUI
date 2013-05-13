package
{
	import com.bit101.components.Slider;
	import com.feng.components.FHSlider;
	import com.feng.components.FSlider;
	import com.feng.components.FVSlider;

	import flash.display.Sprite;
	import flash.events.Event;

	import fla.ui.SliderTest;

	public class TestSlider extends Sprite
	{
		public function TestSlider()
		{
			new Slider(Slider.HORIZONTAL, this);

			var sliderTest:SliderTest = new SliderTest();
			addChild(sliderTest);

			var hSlider:FHSlider = FHSlider.getInstance(sliderTest.tHSlider);
			hSlider.backClick = true;

			hSlider.addEventListener(Event.CHANGE, function(event:Event):void
			{
				trace(hSlider.value)
			});

			var vSlider:FVSlider = FVSlider.getInstance(sliderTest.tVSlider);
			vSlider.backClick = true;

			vSlider.addEventListener(Event.CHANGE, function(event:Event):void
			{
				trace(vSlider.value)
			});


		}
	}
}
