local R = import "R"

local item_app=
{import "android.widget.LinearLayout";
  LinearLayout,
  layout_width='fill';
  layout_height='wrap';
  paddingTop='12dp';
  paddingLeft='12dp';
  paddingRight='12dp';
  {import "com.google.android.material.card.MaterialCardView";
    MaterialCardView,
    radius="16dp",
    layout_width='fill';
    layout_height='wrap';
    strokeWidth="0dp",
    layout_margin="4dp",
    id="contents",
    {import "android.widget.LinearLayout";
    LinearLayout,
      Orientation=0,
      layout_width="fill",
      layout_height="wrap",
      {import "androidx.appcompat.widget.AppCompatImageView";
        AppCompatImageView,
        layout_marginTop="16dp",
        layout_marginBottom="16dp",
        layout_marginLeft="8dp",
        layout_width="42dp",
        layout_height="42dp",
        id="icon",
      },
      {import "android.widget.LinearLayout";
      LinearLayout,
        layout_gravity="center",
        layout_marginTop="16dp",
        layout_marginBottom="16dp",
        layout_marginLeft="8dp",
        Orientation=1,
        layout_width="match_parent",
        layout_height="match_parent",
        {import "com.google.android.material.textview.MaterialTextView";
          MaterialTextView,
          textSize="14sp",
          id="name",
        },
        {import "com.google.android.material.textview.MaterialTextView";
          MaterialTextView,
          textSize="12sp",
          id="packname",
        },
      },
    },
  },
}
return item_app;