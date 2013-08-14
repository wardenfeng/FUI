package
{
	import com.bit101.components.List;
	import com.feng.components.FList;
	import com.test.MyListItem;
	
	import flash.display.Sprite;
	
	import fla.ui.ListTest;

	public class TestList extends Sprite
	{
		public function TestList()
		{
			var list:List = new List(this, 0, 0, ["1", "a", "b", "c", "1", "a", "b", "1", "a", "b"]);

			var listTest:ListTest = new ListTest();
			addChild(listTest);
			listTest.x = 100;
			var tList:FList = FList.getInstance(listTest.tList);
			tList.listItemClass = MyListItem;
			tList.alternateRows = true;
			tList.autoHideScrollBar = true;
			
			var items:Array = [];
			for (var i:int = 0; i < 80; i++) 
			{
				items.push(i.toString());
			}

			tList.items = items;
		}
	}
}
