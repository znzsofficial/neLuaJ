import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "com.androlua.*"
import "github.znzsofficial.luaj.R"
import "androidx.core.view.GravityCompat"
import "androidx.coordinatorlayout.widget.CoordinatorLayout"
import "androidx.drawerlayout.widget.DrawerLayout"
import "androidx.appcompat.app.ActionBarDrawerToggle"
import "com.google.android.material.dialog.MaterialAlertDialogBuilder"
import "com.google.android.material.snackbar.Snackbar"
import "com.google.android.material.navigation.NavigationView"
import "com.google.android.material.floatingactionbutton.FloatingActionButton"
import "androidx.recyclerview.widget.LinearLayoutManager"
import "github.znzsofficial.LuaCustRecyclerHolder"
import "github.znzsofficial.LuaCustRecyclerAdapter"
import "github.znzsofficial.AdapterCreator"
import "com.bumptech.glide.Glide"
import "com.bumptech.glide.request.RequestOptions"
import "com.bumptech.glide.load.engine.DiskCacheStrategy"
import "com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions"
import "util.ResUtil"
import "res"

--添加BackHome按钮用来当Drawer的Menu按钮
actionBar=activity.getSupportActionBar()
actionBar.setDisplayHomeAsUpEnabled(true)
activity.setContentView(res.layout.mainlayout)

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

--[[MaterialButton点击事件
mBtn.onClick = function(view)
  Snackbar.make(view,"Hello Word~",Snackbar.LENGTH_SHORT)
  .setAction("OK",{onClick=function()
      print("OK")
    end})
  .show()
end]]

--FloatingActionButton的点击事件
floatingaction.onClick = function(view)
  MaterialAlertDialogBuilder(this)
  .setTitle("主要依赖")
  .setMessage([[
androidx.appcompat 1.7.0-alpha02
com.google.android.material 1.9.0-alpha02
com.github.bumptech.glide 4.15.0
net.lingala.zip4j 2.11.5
kotlin-stdlib 1.8.20-Beta]])
  .setNegativeButton("消极",nil)
  .setNeutralButton("中立",function()
  print(android.res.color.attr.colorTertiary)
  end)
  .setPositiveButton("积极",nil)
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
  menu.add("Exit").onMenuItemClick=function(a)
    activity.finish()
  end
end

Glide.with(this).asDrawable().load(R.drawable.ic_material).into(heard_image);


options = RequestOptions()
.skipMemoryCache(true)
.diskCacheStrategy(DiskCacheStrategy.NONE);
AppList={}
adapter_app=LuaCustRecyclerAdapter(AdapterCreator({
  getItemCount=function()
    return #AppList
  end,
  onCreateViewHolder=function(parent,viewType)
    local views={}
    holder=LuaCustRecyclerHolder(loadlayout(res.layout.item_app,views))
    holder.view.setTag(views)
    return holder
  end,
  onBindViewHolder=function(holder,position)
    view=holder.view.getTag()
    view.name.Text=AppList[position+1].app_name
    view.packname.Text=AppList[position+1].packageName
    Glide.with(activity).asDrawable().transition(DrawableTransitionOptions.withCrossFade(256)).load(AppList[position+1].app_icon).apply(options).into(view.icon)
    view.contents.onClick=function()
      Snackbar.make(coordinatorLayout,AppList[position+1].app_name,Snackbar.LENGTH_SHORT).setAnchorView(floatingaction).show();
    end
  end,
}))
recycler_app.setAdapter(adapter_app).setLayoutManager(LinearLayoutManager(this))

function CreateAdapter(list)
  AppList=list()
  adapter_app.notifyDataSetChanged()
end

thread(function()
  import "android.content.pm.ApplicationInfo"
  local packageMgr = activity.PackageManager
  local packages = packageMgr.getInstalledPackages(0)
  local data = {}
  local count = 0

  while count~= #packages do
    local packageInfo = packages[count]
    local appInfo = packageInfo.applicationInfo
    local packageName = packageInfo.packageName
    local appInfo = packageInfo.applicationInfo

    -- 排除列表中的系统应用
    if (appInfo.flags & ApplicationInfo.FLAG_SYSTEM) <= 0 then
      local label = appInfo.loadLabel(packageMgr)
      local icon = appInfo.loadIcon(packageMgr)
      table.insert(data, #data + 1,
      {app_icon = icon,
        app_name = label,
        packageName = packageName,
      })
    end
    count=count+1
  end

  function returnTable()
    return data
  end

  call("CreateAdapter",returnTable)
end)