package com.test
{
	import com.feng.components.FListItem;

	import flash.display.MovieClip;
	import flash.utils.Dictionary;

	public class MyListItem extends FListItem
	{
		private static var myListItemDic:Dictionary = new Dictionary();

		public static function getInstance(listItemMc:MovieClip):MyListItem
		{
			if (myListItemDic[listItemMc] == null)
			{
				myListItemDic[listItemMc] = new MyListItem(listItemMc);
			}
			return myListItemDic[listItemMc];
		}

		public function MyListItem(listItemMc:MovieClip, data:Object = null)
		{
			super(listItemMc, data);
		}

		override public function updateView():void
		{
			if (_data == null)
			{
				_skin.label.text = "";
			}
			else if (_data is String)
			{
				_skin.label.text = _data as String;
			}
			else if (_data.hasOwnProperty("label") && _data.label is String)
			{
				_skin.label.text = _data.label;
			}
			else
			{
				_skin.label.text = _data.toString();
			}
		}
	}
}
