# 主程序源代码

```java
/////////////////////////////Pedemetor.java////////////////////////////
package xu.pedemeter;

import android.app.Activity;
import android.app.AlertDialog;
//import org.openintents.sensorsimulator.hardware.SensorManagerSimulator;
import android.app.Activity;
import android.hardware.SensorListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;
import android.os.Bundle;
import java.lang.Math.*;
import java.text.DecimalFormat;
import java.util.Calendar;
import android.app.*;
import android.content.*;
import android.view.Menu;
import android.view.MenuItem;
import android.content.Intent;
import android.view.View.OnClickListener;

public class pedemeter extends Activity implements SensorListener{
    private SensorManagerSimulator mSensorManager;//用于模拟机测试
	//private SensorManager mSensorManager;//用于真机测试
    private int stepvalue=0;
    private double curvalue;
    private double lastvalue;
    private long lasttime=System.currentTimeMillis();
    private long starttime=System.currentTimeMillis();
    private long curtime;
    static float step_distance_setting = (float)0.5;//50cm
    static float body_weight_setting = (float)50;//50kg
    static int select_gender=0;
    static int select_move_mode=0;
    static int select_sensitivity=2;
    private int i,j;
    private int deltstep=0;
    private int pacevalue;
    private float speedvalue;
    private float caloriesvalue=0;
    float abstractvalue;
    DecimalFormat formatnum = new DecimalFormat("##0.00");
    TextView mStepValue;
    TextView mDistanceValue;
    TextView mPaceValue;
    TextView mSpeedValue;
    TextView mCaloriesValue;
    public static final int SETTINGS = Menu.FIRST;
	public static final int APPABOUT = Menu.FIRST + 1;
	public static final int QUIT = Menu.FIRST + 2;
	public static final int HELP = Menu.FIRST + 3;
    Calendar mCalendar = Calendar.getInstance();
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        //time = System.nanoTime();
        mStepValue = (TextView) findViewById(R.id.step_value);
        mDistanceValue = (TextView) findViewById(R.id.distance_value);
        mPaceValue =(TextView)findViewById(R.id.pace_value);
        mSpeedValue = (TextView) findViewById(R.id.speed_value);
        mCaloriesValue = (TextView) findViewById(R.id.calories_value);
        mSensorManager=SensorManagerSimulator.getSystemService(this, SENSOR_SERVICE);   
        mSensorManager.connectSimulator(); 
//以上用于模拟机测试
//mSensorManager=(SensorManager)getSystemService(SENSOR_SERVICE);
        //用于真机
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu){
    	super.onCreateOptionsMenu(menu);
    	//添加设置窗口
    	menu.add(0,SETTINGS,0,"设置")
    	.setIcon(android.R.drawable.ic_menu_preferences)
        .setShortcut('2', 'r');
    	//添加“关于”菜单
    	menu.add(0,APPABOUT,1,"关于")
    	.setIcon(android.R.drawable.ic_menu_info_details)
        .setShortcut('2', 'r');
    	//添加帮助菜单
    	menu.add(0,HELP,1,"帮助")
    	.setIcon(android.R.drawable.ic_menu_help)
    	.setShortcut('2', 'r');
    	//添加退出菜单
    	menu.add(0,QUIT,1,"退出")
    	.setIcon(android.R.drawable.ic_lock_power_off)
        .setShortcut('2', 'r');
    	
    	return true;
    }
    
    public boolean onOptionsItemSelected(MenuItem item){
    	super.onOptionsItemSelected(item);
    	//Intent intent = new Intent();
    	switch(item.getItemId()){
    	case SETTINGS:
    		finish();
    		Intent intent=new Intent(pedemeter.this,settings.class);//跳转至设置界面
    		startActivity(intent);   
       		break;
       	case QUIT:
    		actionClickMenuItemQuit();
    		break;
    	case APPABOUT:
    		actionClickMenuItemAppAbout();
    		break;
    	case HELP:
    		actionClickMenuItemHelp();
    		break;
    	}
    	return super.onOptionsItemSelected(item);
    }

    private void actionClickMenuItemHelp() {
		// TODO Auto-generated method stub
		openOptionDialogHelp();
	}
	private void openOptionDialogHelp() {
		// TODO Auto-generated method stub		
		new AlertDialog.Builder(this)
		.setTitle(R.string.help)
		.setIcon(android.R.drawable.ic_menu_help)
		.setMessage(R.string.help_msg)
		.setPositiveButton(R.string.str_ok,
				new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
						// TODO Auto-generated method stub
					}
				}).show();
	}
	private void actionClickMenuItemAppAbout() {
		// TODO Auto-generated method stub
		openOptionDialogAppAbout();
	}
	private void openOptionDialogAppAbout() {
		// TODO Auto-generated method stub
		new AlertDialog.Builder(this)
		.setTitle(R.string.app_about)
		.setMessage(R.string.app_about_msg)
		.setPositiveButton(R.string.str_ok,
				new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
						// TODO Auto-generated method stub
					}
				}).show();
	}
	private void actionClickMenuItem1() {
		// TODO Auto-generated method stub
    	setTitle("设置用户参数");
	}
	private void actionClickMenuItemQuit() {
		// TODO Auto-generated method stub
		reallyWantToQuit();
	}
	private void reallyWantToQuit() {
		// TODO Auto-generated method stub
		new AlertDialog.Builder(this)
		.setTitle(" 友情提示!")
		.setIcon(R.drawable.warning)
		.setMessage("确定要退出吗?")
		.setPositiveButton(R.string.str_ok, 
				new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int which) {
						// TODO Auto-generated method stub
						finish();
						System.exit(0);
					}
				})
				.setNegativeButton(R.string.str_cancel, 
						new DialogInterface.OnClickListener() {
							@Override
							public void onClick(DialogInterface dialog, int which) {
								// TODO Auto-generated method stub
							}
						}).show();
	}
	@Override
	protected void onResume() {
		super.onResume();
		mSensorManager.registerListener(this, SensorManager.SENSOR_ACCELEROMETER
				| SensorManager.SENSOR_MAGNETIC_FIELD
				| SensorManager.SENSOR_ORIENTATION,
				SensorManager.SENSOR_DELAY_FASTEST);
	}//注册传感器
	@Override
	protected void onStop() {
		mSensorManager.unregisterListener(this);
		super.onStop();
	}//注销传感器
	public void onAccuracyChanged(int sensor, int accuracy) {
	}//当灵敏度调整时
	public void onSensorChanged(int sensor, float[] values) {
		j=i;
		switch(sensor){
		case SensorManager.SENSOR_ACCELEROMETER:
			//以下程序计步
			abstractvalue=values[0]*values[0]+values[1]*values[1]+values[2]*values[2];
			abstractvalue=(float)Math.sqrt(abstractvalue);
			if(select_move_mode==0){
				if(abstractvalue>10){i=1;}
				else{i=0;}
			}
			if(select_move_mode==1|select_move_mode==2){
				if(abstractvalue>10.4){i=1;}
				else{i=0;}
			}
			if(j-i==1){stepvalue++;deltstep++;}
			mStepValue.setText(""+stepvalue);
			CalDistance(stepvalue);
			CalStepSpeed();
			CalDistanceSpeed();
			CalCalories();
			break;
			
		}
	}
	private void CalCalories() {
		// TODO Auto-generated method stub
		caloriesvalue=(float)(body_weight_setting*stepvalue*step_distance_setting*1.036);
		mCaloriesValue.setText(""+caloriesvalue);
	}
	private void CalDistanceSpeed() {
		// TODO Auto-generated method stub
		speedvalue=pacevalue*step_distance_setting;
		mSpeedValue.setText(""+speedvalue);
	}
	private void CalStepSpeed() {
		// TODO Auto-generated method stub
		curtime=System.currentTimeMillis();
		if(curtime-lasttime>1500){
			pacevalue=(int)(deltstep*60000/(curtime-lasttime));
			mPaceValue.setText(""+pacevalue);
			lasttime=System.currentTimeMillis();
			deltstep=0;
		}
		
	}
	private void CalDistance(int stepvalue) {
		// TODO Auto-generated method stub
		float distance=stepvalue*step_distance_setting;
		mDistanceValue.setText(""+formatnum.format(distance));
	}
}
``` 
