local R = import "R"

head = {
  import "android.widget.*";
  LinearLayout;
  gravity="bottom";
  orientation="vertical";
  paddingTop="16dp";
  paddingBottom="16dp";
  paddingLeft="16dp";
  layout_width="fill";
  layout_height="160dp";
  paddingRight="16dp";
  id="heard";
  BackgroundResource=R.drawable.side_nav_bar;
  {
    ImageView;
    layout_height="56dp";
    id="heard_image";
    layout_width="56dp";
    --BackgroundResource=R.drawable.ic_material;
  };
  {
    TextView;
    text="Material3 in LuaJ++";
    layout_width="match_parent";
    layout_height="wrap_content";
    paddingTop="16dp";
    textSize="16sp";
  };
  {
    TextView;
    layout_height="wrap_content";
    id="textView";
    text="DrawerLayout@Demo";
    layout_width="wrap_content";
  };
};

return head;