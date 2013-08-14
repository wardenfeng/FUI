package
{
	import com.bit101.components.ComboBox;
	import com.feng.components.FComboBox;
	import com.feng.components.FList;
	import com.test.MyListItem;
	
	import fla.ui.ComboBoxTest;
	
	
	/**
	 * 
	 * @author warden_feng 2013-8-14
	 */
	public class TestComboBox extends BaseTest
	{
		public function TestComboBox()
		{
			super();
//			new ComboBox(this,0,0,"0",["0","a","b","c","a","b","c","a","b","c","a","b","c","a","b","c"]);
			new ComboBox(this,0,0,"0",["0","a","b"]);
			
			var comboBoxTest:ComboBoxTest = new ComboBoxTest();
			addChild(comboBoxTest);
			comboBoxTest.x = 100;
			
			var tComboBox:FComboBox = FComboBox.getInstance(comboBoxTest.tComboBox);
			tComboBox.items = ["0","a","b","c","a","b","c","a","b","c","a","b","c","a","b","c"];
			tComboBox.items = ["0","a","b","c"];
		}
	}
}