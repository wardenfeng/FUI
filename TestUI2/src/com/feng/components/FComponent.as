package com.feng.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	[Event(name = "draw", type = "flash.events.Event")]
	public class FComponent extends Sprite
	{
		public static const DRAW:String = "draw";

		protected var _skin:MovieClip;
		
		protected var _enabled:Boolean = true;

		public function FComponent(componentMc:MovieClip)
		{
			_skin = componentMc;
			
			init();
		}

		/**
		 * Initilizes the component.
		 */
		protected function init():void
		{
			addChildren();
			invalidate();
		}

		/**
		 * Overriden in subclasses to create child display objects.
		 */
		protected function addChildren():void
		{

		}

		/**
		 * Marks the component to be redrawn on the next frame.
		 */
		protected function invalidate():void
		{
//			draw();
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}




		///////////////////////////////////
		// public methods
		///////////////////////////////////

		/**
		 * Utility method to set up usual stage align and scaling.
		 */
		public static function initStage(stage:Stage):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}

		/**
		 * Moves the component to the specified position.
		 * @param xpos the x position to move the component
		 * @param ypos the y position to move the component
		 */
		public function move(xpos:Number, ypos:Number):void
		{
			x = Math.round(xpos);
			y = Math.round(ypos);
		}

		/**
		 * Abstract draw function.
		 */
		public function draw():void
		{
			dispatchEvent(new Event(FComponent.DRAW));
		}




		///////////////////////////////////
		// event handlers
		///////////////////////////////////

		/**
		 * Called one frame after invalidate is called.
		 */
		protected function onInvalidate(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
		}




		///////////////////////////////////
		// getter/setters
		///////////////////////////////////

		/**
		 * Overrides the setter for x to always place the component on a whole pixel.
		 */
		override public function set x(value:Number):void
		{
			super.x = Math.round(value);
		}

		/**
		 * Overrides the setter for y to always place the component on a whole pixel.
		 */
		override public function set y(value:Number):void
		{
			super.y = Math.round(value);
		}

		/**
		 * Sets/gets whether this component is enabled or not.
		 */
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			mouseEnabled = mouseChildren = _enabled;
			tabEnabled = value;
		}

		public function get enabled():Boolean
		{
			return _enabled;
		}
	}
}
