package com.feng.components
{
	import com.bit101.components.Label;
	import com.bit101.components.Style;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class FButton extends FComponent
	{
		private static const up_frame:int = 1;
		
		private static const over_frame:int = 2;
		
		private static const down_frame:int = 3;
		
		private static const selected_up_frame:int = 4;
		
		private static const selected_over_frame:int = 5;
		
		private static const selected_down_frame:int = 6;
		
		private static const unEnabled_frame:int = 7;
		
		protected var _back:Sprite;
		protected var _face:Sprite;
		protected var _label:TextField;
		protected var _labelText:String = "";
		protected var _over:Boolean = false;
		protected var _down:Boolean = false;
		protected var _selected:Boolean = false;
		protected var _toggle:Boolean = false;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this PushButton.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param label The string to use for the initial label of this component.
 		 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
		 */
		public function FButton(buttonMc:MovieClip)
		{
			super(buttonMc);
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			buttonMode = true;
			useHandCursor = true;
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			
			
			_back = new Sprite();
			_back.filters = [getShadow(2, true)];
			_back.mouseEnabled = false;
			addChild(_back);
			
			_face = new Sprite();
			_face.mouseEnabled = false;
			_face.filters = [getShadow(1)];
			_face.x = 1;
			_face.y = 1;
			addChild(_face);
			
			_label = new Label();
			addChild(_label);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		}
		
		
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			_back.graphics.clear();
			_back.graphics.beginFill(Style.BACKGROUND);
			_back.graphics.drawRect(0, 0, _width, _height);
			_back.graphics.endFill();
			
			_face.graphics.clear();
			_face.graphics.beginFill(Style.BUTTON_FACE);
			_face.graphics.drawRect(0, 0, _width - 2, _height - 2);
			_face.graphics.endFill();
			
			_label.text = _labelText;
			_label.autoSize = true;
			_label.draw();
			if(_label.width > _width - 4)
			{
				_label.autoSize = false;
				_label.width = _width - 4;
			}
			else
			{
				_label.autoSize = true;
			}
			_label.draw();
			_label.move(_width / 2 - _label.width / 2, _height / 2 - _label.height / 2);
			
		}
		
		
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Internal mouseOver handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseOver(event:MouseEvent):void
		{
			_over = true;
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseOut(event:MouseEvent):void
		{
			_over = false;
			if(!_down)
			{
				_face.filters = [getShadow(1)];
			}
			removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseGoDown(event:MouseEvent):void
		{
			_down = true;
			_face.filters = [getShadow(1, true)];
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		/**
		 * Internal mouseUp handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseGoUp(event:MouseEvent):void
		{
			if(_toggle  && _over)
			{
				_selected = !_selected;
			}
			_down = _selected;
			_face.filters = [getShadow(1, _selected)];
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the label text shown on this Pushbutton.
		 */
		public function set label(str:String):void
		{
			_labelText = str;
			draw();
		}
		public function get label():String
		{
			return _labelText;
		}
		
		public function set selected(value:Boolean):void
		{
			if(!_toggle)
			{
				value = false;
			}
			
			_selected = value;
			_down = _selected;
			_face.filters = [getShadow(1, _selected)];
		}
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set toggle(value:Boolean):void
		{
			_toggle = value;
		}
		public function get toggle():Boolean
		{
			return _toggle;
		}
		
		
	}
}