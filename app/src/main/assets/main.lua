--require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "com.androlua.*"
import "com.eurya.luaj.R"
import "androidx.core.view.GravityCompat"
import "com.google.android.material.snackbar.Snackbar"
import "androidx.coordinatorlayout.widget.CoordinatorLayout"
import "androidx.drawerlayout.widget.DrawerLayout"
import "androidx.appcompat.app.ActionBarDrawerToggle"
import "com.google.android.material.navigation.NavigationView"
import "com.google.android.material.floatingactionbutton.FloatingActionButton"
import "res"

do
  local _ENV={activity=this,style=luajava.bindClass'com.google.android.material.R$style'}
  activity.theme=style.Theme_Material3_DayNight
end

--添加BackHome按钮用来当Drawer的Menu按钮
actionBar=activity.getSupportActionBar()
actionBar.setDisplayHomeAsUpEnabled(true)
activity.setContentView(res.layout.main)

--侧滑设置
toggle = ActionBarDrawerToggle(activity,drawer,R.string.drawer_open, R.string.drawer_close)
drawer.setDrawerListener(toggle);
toggle.syncState();
head=LuaLayout(this)
navigation.addHeaderView(head.load(res.layout.head))
navigation.inflateMenu(R.menu.activity_main_drawer)
head.getView("heard_image").setBackgroundResource(R.drawable.ic_launcher)

--navigation的点击事件
navigation.setNavigationItemSelectedListener(NavigationView.OnNavigationItemSelectedListener {
  onNavigationItemSelected = function(item)
    if id == R.id.nav_camera then
     elseif id == R.id.nav_gallery then
     elseif id == R.id.nav_slideshow then
     elseif id == R.id.nav_manage then
     elseif id == R.id.nav_share then
     elseif id == R.id.nav_send then
    end
    drawer.closeDrawer(GravityCompat.START)
    print(item)
    return true
  end
});

--FloatingActionButton的点击事件
floatingaction.onClick = function(view)
  Snackbar.make(view,"Hello Word~",Snackbar.LENGTH_SHORT)
  .setAction("OK",{onClick=function()
      print("OK")
  end})
  .show()
end
--使用home来添加menu按钮
function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    if not drawer.isDrawerOpen(GravityCompat.START) then
      drawer.openDrawer(GravityCompat.START);
     else
      drawer.closeDrawer(GravityCompat.START);
    end
  end
end
--ActionBar栏Menu
function onCreateOptionsMenu(menu)
  menu.add("Setting").onMenuItemClick=function(a)
    print "Setting"
  end
end
i=1
switch i
 case 1
  print("true")
 case 2
  print("false")
end