package com.feng.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
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

		protected var _button:Sprite;

		protected var _label:TextField;

		protected var _labelText:String = "";

		protected var _selected:Boolean = false;

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
			_skin.buttonMode = true;
			_skin.useHandCursor = true;
			_skin.mouseChildren = false;
		}

		/**
		 * Creates the children for this component
		 */
		override protected function addChildren():void
		{
			_back = _skin.back;

			_button = _skin.button;
			_button.visible = false;

			_label = _skin.label;
			draw();

			_skin.addEventListener(MouseEvent.CLICK, onClick);
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

			_label.text = _labelText;
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
			_labelText = str;
			invalidate();
		}

		public function get label():String
		{
			return _labelText;
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
			_skin.mouseChildren = false;
		}

	}
}
