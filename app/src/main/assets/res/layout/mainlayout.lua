local R = import "R"
local ColorStateList = import "android.content.res.ColorStateList"
local TypedValue = import "android.util.TypedValue"

mainlayout = {
  import "androidx.drawerlayout.widget.DrawerLayout";
  DrawerLayout;
  layout_height="fill";
  id="drawer";
  layout_width="fill";
  {
    import "androidx.coordinatorlayout.widget.CoordinatorLayout";
    CoordinatorLayout;
    layout_height="fill";
    layout_width="fill";
    id="coordinatorLayout";
    {
      import "android.widget.LinearLayout";
      LinearLayout;
      gravity="center";
      layout_height="fill";
      orientation="vertical";
      layout_width="fill";
      {
        import "com.google.android.material.button.MaterialButton";
        MaterialButton;
        id="mBtn";
        layout_gravity="center";
        layout_width="wrap";
        text="Hello World！";
        layout_height="wrap";
      };
      {
        import "com.google.android.material.textview.MaterialTextView";
        MaterialButton;
        id="mTvw";
        layout_gravity="center";
        layout_width="wrap";
        text="NeLuaJ Test";
        textColor=android.res.color.attr.colorPrimary;
        layout_height="wrap";
      };
    };
    {
      import "com.google.android.material.floatingactionbutton.FloatingActionButton";
      FloatingActionButton;
      layout_gravity="bottom|end";
      layout_marginBottom=this.getResources().getDimension(R.dimen.fab_margin);
      layout_marginEnd=this.getResources().getDimension(R.dimen.fab_margin);
      src="res/drawable/add.png";
      layout_height="wrap";
      layout_width="wrap";
      id="floatingaction";
    };
  };
  {
    import "android.widget.LinearLayout";
    LinearLayout;
    layout_gravity="start";
    layout_height="fill";
    orientation="vertical";
    layout_width="fill";
    {
      import "com.google.android.material.navigation.NavigationView";
      NavigationView;
      layout_height="fill";
      id="navigation";
      layout_width="fill";
    };
  };

};

return mainlayout;