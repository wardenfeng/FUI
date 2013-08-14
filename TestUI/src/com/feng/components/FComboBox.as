package com.feng.components
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	[Event(name="select", type="flash.events.Event")]
	public class FComboBox extends FComponent
	{
		private static var instanceDic:Dictionary = new Dictionary();
		
		public static function getInstance(comboBoxMc:MovieClip):FComboBox
		{
			if (instanceDic[comboBoxMc] == null)
			{
				instanceDic[comboBoxMc] = new FComboBox(comboBoxMc);
			}
			return instanceDic[comboBoxMc];
		}
		
		public static const TOP:String = "top";
		public static const BOTTOM:String = "bottom";
		
		protected var _dropDownButton:FButton;
		protected var _items:Array;
		protected var _labelButton:FButton;
		protected var _list:FList;
		protected var _numVisibleItems:int = 6;
		protected var _open:Boolean = false;
		protected var _openPosition:String = BOTTOM;
		protected var _stage:Stage;
		
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this List.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param defaultLabel The label to show when no item is selected.
		 * @param items An array of items to display in the list. Either strings or objects with label property.
		 */
		public function FComboBox(comboBoxMc:MovieClip)
		{
			_stage = comboBoxMc.stage;
			comboBoxMc.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			comboBoxMc.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			super(comboBoxMc);
		}
		
		/**
		 * Initilizes the component.
		 */
		protected override function init():void
		{
			super.init();
			setLabelButtonLabel();
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		protected override function addChildren():void
		{
			super.addChildren();
			_list = new FList(skin.list);
			_list.autoHideScrollBar = true;
			_list.addEventListener(Event.SELECT, onSelect);
			skin.removeChild(skin.list);
			
			_labelButton = new FButton(skin.labelButton);
			_labelButton.addEventListener(MouseEvent.CLICK, onDropDown);

			_dropDownButton = new FButton(skin.dropDownButton);
			_dropDownButton.addEventListener(MouseEvent.CLICK, onDropDown);
			_dropDownButton.label = "+";
		}
		
		/**
		 * Determines what to use for the main button label and sets it.
		 */
		protected function setLabelButtonLabel():void
		{
			if(selectedItem == null)
			{
				_labelButton.label = "";
			}
			else if(selectedItem is String)
			{
				_labelButton.label = selectedItem as String;
			}
			else if(selectedItem.hasOwnProperty("label") && selectedItem.label is String)
			{
				_labelButton.label = selectedItem.label;
			}
			else
			{
				_labelButton.label = selectedItem.toString();
			}
		}
		
		/**
		 * Removes the list from the stage.
		 */
		protected function removeList():void
		{
			if(_stage.contains(_list.skin)) _stage.removeChild(_list.skin);
			_stage.removeEventListener(MouseEvent.CLICK, onStageClick);
			_dropDownButton.label = "+";			
		}
		

		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public override function draw():void
		{
			super.draw();
		}
		
		
		/**
		 * Adds an item to the list.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 */
		public function addItem(item:Object):void
		{
			_list.addItem(item);
		}
		
		/**
		 * Adds an item to the list at the specified index.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 * @param index The index at which to add the item.
		 */
		public function addItemAt(item:Object, index:int):void
		{
			_list.addItemAt(item, index);
		}
		
		/**
		 * Removes the referenced item from the list.
		 * @param item The item to remove. If a string, must match the item containing that string. If an object, must be a reference to the exact same object.
		 */
		public function removeItem(item:Object):void
		{
			_list.removeItem(item);
		}
		
		/**
		 * Removes the item from the list at the specified index
		 * @param index The index of the item to remove.
		 */
		public function removeItemAt(index:int):void
		{
			_list.removeItemAt(index);
		}
		
		/**
		 * Removes all items from the list.
		 */
		public function removeAll():void
		{
			_list.removeAll();
		}
	
		
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Called when one of the top buttons is pressed. Either opens or closes the list.
		 */
		protected function onDropDown(event:MouseEvent):void
		{
			_open = !_open;
			if(_open)
			{
				var point:Point = new Point();
				if(_openPosition == BOTTOM)
				{
					point.y = height;
				}
				else
				{
					point.y = -_numVisibleItems * _list.listItemHeight;
				}
				point = skin.localToGlobal(point);
				_list.move(point.x, point.y);
				_stage.addChild(_list.skin);
				_stage.addEventListener(MouseEvent.CLICK, onStageClick);
				_dropDownButton.label = "-";
			}
			else
			{
				removeList();
			}
		}
		
		/**
		 * Called when the mouse is clicked somewhere outside of the combo box when the list is open. Closes the list.
		 */
		protected function onStageClick(event:MouseEvent):void
		{
			// ignore clicks within buttons or list
			if(event.target == _dropDownButton.skin || event.target == _labelButton.skin) return;
			if(new Rectangle(_list.x, _list.y, _list.width, _list.height).contains(event.stageX, event.stageY)) return;
			
			_open = false;
			removeList();
		}
		
		/**
		 * Called when an item in the list is selected. Displays that item in the label button.
		 */
		protected function onSelect(event:Event):void
		{
			_open = false;
			_dropDownButton.label = "+";
			if(skin.stage != null && skin.stage.contains(_list.skin))
			{
				skin.stage.removeChild(_list.skin);
			}
			setLabelButtonLabel();
			dispatchEvent(event);
		}
		
		/**
		 * Called when the component is added to the stage.
		 */
		protected function onAddedToStage(event:Event):void
		{
			_stage = skin.stage;
		}
		
		/**
		 * Called when the component is removed from the stage.
		 */
		protected function onRemovedFromStage(event:Event):void
		{
			removeList();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the index of the selected list item.
		 */
		public function set selectedIndex(value:int):void
		{
			_list.selectedIndex = value;
			setLabelButtonLabel();
		}
		public function get selectedIndex():int
		{
			return _list.selectedIndex;
		}
		
		/**
		 * Sets / gets the item in the list, if it exists.
		 */
		public function set selectedItem(item:Object):void
		{
			_list.selectedItem = item;
			setLabelButtonLabel();
		}
		public function get selectedItem():Object
		{
			return _list.selectedItem;
		}
		
		/**
		 * Sets / gets the position the list will open on: top or bottom.
		 */
		public function set openPosition(value:String):void
		{
			_openPosition = value;
		}
		public function get openPosition():String
		{
			return _openPosition;
		}

		/**
		 * Sets / gets the number of visible items in the drop down list. i.e. the height of the list.
		 */
		public function set numVisibleItems(value:int):void
		{
			_numVisibleItems = value;
			invalidate();
		}
		public function get numVisibleItems():int
		{
			return _numVisibleItems;
		}

		/**
		 * Sets / gets the list of items to be shown.
		 */
		public function set items(value:Array):void
		{
			_list.items = value;
		}
		public function get items():Array
		{
			return _list.items;
		}
		
		/**
		 * Sets / gets the class used to render list items. Must extend ListItem.
		 */
		public function set listItemClass(value:Class):void
		{
			_list.listItemClass = value;
		}
		public function get listItemClass():Class
		{
			return _list.listItemClass;
		}
		
		/**
		 * Sets / gets whether or not every other row will be colored with the alternate color.
		 */
		public function set alternateRows(value:Boolean):void
		{
			_list.alternateRows = value;
		}
		public function get alternateRows():Boolean
		{
			return _list.alternateRows;
		}

        /**
         * Sets / gets whether the scrollbar will auto hide when there is nothing to scroll.
         */
        public function set autoHideScrollBar(value:Boolean):void
        {
            _list.autoHideScrollBar = value;
            invalidate();
        }
        public function get autoHideScrollBar():Boolean
        {
            return _list.autoHideScrollBar;
        }
		
		/**
		 * Gets whether or not the combo box is currently open.
		 */
		public function get isOpen():Boolean
		{
			return _open;
		}
	}
}