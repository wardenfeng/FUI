
package com.feng.components
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;

	[Event(name="select", type="flash.events.Event")]
	[Event(name="close", type="flash.events.Event")]
	[Event(name="resize", type="flash.events.Event")]
	public class FWindow extends FComponent
	{
		private static var instanceDic:Dictionary = new Dictionary();
		
		public static function getInstance(windowMc:MovieClip):FWindow
		{
			if (instanceDic[windowMc] == null)
			{
				instanceDic[windowMc] = new FWindow(windowMc);
			}
			return instanceDic[windowMc];
		}
		
		protected var _title:String;
		protected var _titleBar:FPanel;
		protected var _titleLabel:TextField;
		protected var _panel:FPanel;
		protected var _shadow:Boolean = true;
		protected var _draggable:Boolean = true;
		protected var _minimizeButton:FButton;
		protected var _hasMinimizeButton:Boolean = false;
		protected var _minimized:Boolean = false;
		protected var _hasCloseButton:Boolean;
		protected var _closeButton:FButton;
		
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this Panel.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param title The string to display in the title bar.
		 */
		public function FWindow(windowMc:MovieClip, title:String="Window")
		{
			_title = title;
			super(windowMc);
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_titleBar = new FPanel(skin.titleBar);
			_titleBar.skin.filters = [];
			_titleBar.skin.buttonMode = true;
			_titleBar.skin.useHandCursor = true;
			_titleBar.skin.addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
			_titleBar.height = 20;
			_titleLabel = _titleBar.content.titleTxt;
			_titleLabel.mouseEnabled = false;
			
			_panel = new FPanel(skin.panel);
			_panel.visible = !_minimized;
			
			_minimizeButton = new FButton(skin.minimizeBtn);
			_minimizeButton.skin.useHandCursor = true;
			_minimizeButton.skin.buttonMode = true;
			_minimizeButton.addEventListener(MouseEvent.CLICK, onMinimize);
			
			_closeButton = new FButton(skin.titleBar.content.closeBtn);
			_closeButton.addEventListener(MouseEvent.CLICK,onClose);
			
			skin.filters = [getShadow(4, false)];
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
			_titleBar.draw();
			_panel.draw();
		}


		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Internal mouseDown handler. Starts a drag.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseGoDown(event:MouseEvent):void
		{
			if(_draggable)
			{
				skin.startDrag();
				skin.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
				skin.parent.addChild(skin); // move to top
			}
			dispatchEvent(new Event(Event.SELECT));
		}
		
		/**
		 * Internal mouseUp handler. Stops the drag.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseGoUp(event:MouseEvent):void
		{
			skin.stopDrag();
			skin.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		protected function onMinimize(event:MouseEvent):void
		{
			minimized = !minimized;
		}
		
		protected function onClose(event:MouseEvent):void
		{
			dispatchEvent(new Event(Event.CLOSE));
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Gets / sets whether or not this Window will have a drop shadow.
		 */
		public function set shadow(b:Boolean):void
		{
			_shadow = b;
			if(_shadow)
			{
				skin.filters = [getShadow(4, false)];
			}
			else
			{
				skin.filters = [];
			}
		}
		public function get shadow():Boolean
		{
			return _shadow;
		}
		
		/**
		 * Gets / sets the title shown in the title bar.
		 */
		public function set title(t:String):void
		{
			_title = t;
			_titleLabel.text = _title;
		}
		public function get title():String
		{
			return _title;
		}
		
		/**
		 * Container for content added to this panel. This is just a reference to the content of the internal Panel, which is masked, so best to add children to content, rather than directly to the window.
		 */
		public function get content():DisplayObjectContainer
		{
			return _panel.content;
		}
		
		/**
		 * Sets / gets whether or not the window will be draggable by the title bar.
		 */
		public function set draggable(b:Boolean):void
		{
			_draggable = b;
			_titleBar.skin.buttonMode = _draggable;
			_titleBar.skin.useHandCursor = _draggable;
		}
		public function get draggable():Boolean
		{
			return _draggable;
		}
		
		/**
		 * Gets / sets whether or not the window will show a minimize button that will toggle the window open and closed. A closed window will only show the title bar.
		 */
		public function set hasMinimizeButton(b:Boolean):void
		{
			_hasMinimizeButton = b;
			if(_hasMinimizeButton)
			{
				skin.addChild(_minimizeButton.skin);
			}
			else if(skin.contains(_minimizeButton.skin))
			{
				skin.removeChild(_minimizeButton.skin);
			}
			invalidate();
		}
		public function get hasMinimizeButton():Boolean
		{
			return _hasMinimizeButton;
		}
		
		/**
		 * Gets / sets whether the window is closed. A closed window will only show its title bar.
		 */
		public function set minimized(value:Boolean):void
		{
			_minimized = value;
//			_panel.visible = !_minimized;
			if(_minimized)
			{
				if(skin.contains(_panel.skin)) skin.removeChild(_panel.skin);
				_minimizeButton.skin.rotation = -90;
			}
			else
			{
				if(!skin.contains(_panel.skin)) skin.addChild(_panel.skin);
				_minimizeButton.skin.rotation = 0;
			}
			dispatchEvent(new Event(Event.RESIZE));
		}
		public function get minimized():Boolean
		{
			return _minimized;
		}
		
		/**
		 * Gets the height of the component. A minimized window's height will only be that of its title bar.
		 */
		override public function get height():Number
		{
			if(skin.contains(_panel.skin))
			{
				return super.height;
			}
			else
			{
				return 20;
			}
		}

		/**
		 * Sets / gets whether or not the window will display a close button.
		 * Close button merely dispatches a CLOSE event when clicked. It is up to the developer to handle this event.
		 */
		public function set hasCloseButton(value:Boolean):void
		{
			_hasCloseButton = value;
			if(_hasCloseButton)
			{
				_titleBar.content.addChild(_closeButton.skin);
			}
			else if(_titleBar.content.contains(_closeButton.skin))
			{
				_titleBar.content.removeChild(_closeButton.skin);
			}
			invalidate();
		}
		public function get hasCloseButton():Boolean
		{
			return _hasCloseButton;
		}

		/**
		 * Returns a reference to the title bar for customization.
		 */
		public function get titleBar():FPanel
		{
			return _titleBar;
		}
	}
}