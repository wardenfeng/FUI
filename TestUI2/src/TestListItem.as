package
{
	import com.bit101.components.ListItem;
	import com.feng.components.FListItem;
	
	import flash.display.Sprite;
	
	import fla.ui.ListItemTest;

	public class TestListItem extends Sprite
	{
		public function TestListItem()
		{
			new ListItem(this,0,0,"abcd");
			
			var listItemTest:ListItemTest = new ListItemTest();
			addChild(listItemTest);
			
			var fListItem:FListItem = FListItem.getInstance(listItemTest.tListItem);
			
		}
	}
}