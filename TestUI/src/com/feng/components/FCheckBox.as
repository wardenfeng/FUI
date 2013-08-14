package com.feng.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Dictionary;
	
	public class FCheckBox extends FComponent
	{
		private static var instanceDic:Dictionary = new Dictionary();
		
		public static function getInstance(checkBoxMc:MovieClip):FCheckBox
		{
			if (instanceDic[checkBoxMc] == null)
			{
				instanceDic[checkBoxMc] = new FCheckBox(checkBoxMc);
			}
			return instanceDic[checkBoxMc];
		}
		
		protected var _back:Sprite;
		protected var _button:FButton;
		protected var _label:TextField;
		protected var _selected:Boolean = false;
		
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this CheckBox.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param label String containing the label for this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
		 */
		public function FCheckBox(checkBoxMc:MovieClip)
		{
			super(checkBoxMc);
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			skin.buttonMode = true;
			skin.useHandCursor = true;
			skin.mouseChildren = false;
		}
		
		/**
		 * Creates the children for this component
		 */
		override protected function addChildren():void
		{
			_back = skin.back;
			
			_button = new FButton(skin.button);
			_button.visible = false;
			
			_label = skin.label;
			_label.autoSize = TextFieldAutoSize.LEFT;
			draw();
			
			skin.addEventListener(MouseEvent.CLICK, onClick);
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
		}
		
		
		
		
		///////////////////////////////////
		// event handler
		///////////////////////////////////
		
		/**
		 * Internal click handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onClick(event:MouseEvent):void
		{
			_selected = !_selected;
			_button.visible = _selected;
		}
		
		
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the label text shown on this CheckBox.
		 */
		public function set label(str:String):void
		{
			_label.text = str;
			invalidate();
		}
		public function get label():String
		{
			return _label.text;
		}
		
		/**
		 * Sets / gets the selected state of this CheckBox.
		 */
		public function set selected(s:Boolean):void
		{
			_selected = s;
			_button.visible = _selected;
		}
		public function get selected():Boolean
		{
			return _selected;
		}

		/**
		 * Sets/gets whether this component will be enabled or not.
		 */
		public override function set enabled(value:Boolean):void
		{
			super.enabled = value;
			skin.mouseChildren = false;
		}

	}
}