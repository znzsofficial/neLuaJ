import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "com.androlua.*"
import "github.znzsofficial.luaj.R"
import "androidx.core.view.GravityCompat"
import "com.google.android.material.snackbar.Snackbar"
import "androidx.coordinatorlayout.widget.CoordinatorLayout"
import "androidx.drawerlayout.widget.DrawerLayout"
import "androidx.appcompat.app.ActionBarDrawerToggle"
import "com.google.android.material.navigation.NavigationView"
import "com.google.android.material.floatingactionbutton.FloatingActionButton"
import "com.bumptech.glide.Glide"
import "res"

--添加BackHome按钮用来当Drawer的Menu按钮
actionBar=activity.getSupportActionBar()
actionBar.setDisplayHomeAsUpEnabled(true)
activity.setContentView(res.layout.main)

--侧滑设置
toggle = ActionBarDrawerToggle(activity,drawer,R.string.drawer_open, R.string.drawer_close)
drawer.setDrawerListener(toggle);
toggle.syncState();
navigation.addHeaderView(loadlayout(res.layout.head))
navigation.inflateMenu(R.menu.activity_main_drawer)

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

--MaterialButton点击事件
mBtn.onClick = function(view)
  Snackbar.make(view,"Hello Word~",Snackbar.LENGTH_SHORT).show()
end

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

Glide.with(this).asDrawable().load(R.drawable.ic_material).into(heard_image);