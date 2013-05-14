package com.feng
{
	import com.feng.components.FButton;
	import com.feng.components.FHScrollBar;
	import com.feng.components.FHSlider;
	import com.feng.components.FList;
	import com.feng.components.FVScrollBar;
	import com.feng.components.FVSlider;

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;

	public class FUI
	{
		public function FUI()
		{
		}

		private static const BUTTON_SIGN:String = "Btn";

		private static const HSlider_SIGN:String = "HSlider";

		private static const VSlider_SIGN:String = "VSlider";

		private static const HScrollBar_SIGN:String = "HScrollBar";

		private static const VScrollBar_SIGN:String = "VScrollBar";

		private static const List_SIGN:String = "List";

		public static function init(stage:Stage):void
		{
			stage.addEventListener(Event.ADDED, onAdded);
		}

		protected static function onAdded(event:Event):void
		{
			var mc:DisplayObjectContainer = event.target as DisplayObjectContainer;
			mc && make(mc);
		}

		/** 检查mc中使用的组件 （未完待续） */
		private static function make(mc:DisplayObjectContainer):void
		{
			var childMc:MovieClip;
			var container:DisplayObjectContainer;
			for (var i:int = 0; i < mc.numChildren; i++)
			{
				childMc = mc.getChildAt(i) as MovieClip;
				container = mc.getChildAt(i) as DisplayObjectContainer;
				if (childMc)
				{
					if (childMc.name.substr(-BUTTON_SIGN.length) == BUTTON_SIGN)
					{
						FButton.getInstance(childMc);
					}
					else if (childMc.name.substr(-HSlider_SIGN.length) == HSlider_SIGN)
					{
						FHSlider.getInstance(childMc);
					}
					else if (childMc.name.substr(-VSlider_SIGN.length) == VSlider_SIGN)
					{
						FVSlider.getInstance(childMc);
					}
					else if (childMc.name.substr(-HScrollBar_SIGN.length) == HScrollBar_SIGN)
					{
						FHScrollBar.getInstance(childMc);
					}
					else if (childMc.name.substr(-VScrollBar_SIGN.length) == VScrollBar_SIGN)
					{
						FVScrollBar.getInstance(childMc);
					}
					else if (childMc.name.substr(-List_SIGN.length) == List_SIGN)
					{
						FList.getInstance(childMc);
					}
					else
					{
						make(container);
					}
				}
				else if (container)
				{
					make(container);
				}
			}

		}
	}
}
