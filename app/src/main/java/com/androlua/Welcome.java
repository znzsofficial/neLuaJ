package com.androlua;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.widget.LinearLayout;
import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import net.lingala.zip4j.ZipFile;
import net.lingala.zip4j.exception.ZipException;

public class Welcome extends Activity {

  private boolean isUpdata;
  private LuaApplication app;
  private String localDir;
  private long mLastTime;
  private long mOldLastTime;
  private boolean isVersionChanged;
  private String mVersionName;
  private String mOldVersionName;
  private ArrayList<String> permissions;

  @CallLuaFunction
  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    LinearLayout layout = new LinearLayout(this);
    setContentView(layout);
    app = (LuaApplication) getApplication();
    localDir = app.getLuaDir();
    /*try {
        if (new File(app.getLuaPath("setup.png")).exists())
            getWindow().setBackgroundDrawable(new LuaBitmapDrawable(app, app.getLuaPath("setup.png"), getResources().getDrawable(R.drawable.icon)));
    } catch (Exception e) {
        e.printStackTrace();
    }*/
    if (checkInfo()) {
      LuaApplication.getInstance().setSharedData("UnZiped", false);
      new UpdateTask().execute();
    } else {
      startActivity();
    }
  }

  public void startActivity() {
    try {
      InputStream f = getAssets().open("main.lua");
      if (f != null) {
        Intent intent = new Intent(Welcome.this, LuaActivity.class);
        if (isVersionChanged) {
          intent.putExtra("isVersionChanged", isVersionChanged);
          intent.putExtra("newVersionName", mVersionName);
          intent.putExtra("oldVersionName", mOldVersionName);
        }
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
        finish();
        return;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    // overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out
    //
    // );
    finish();
  }

  public boolean checkInfo() {
    try {
      PackageInfo packageInfo = getPackageManager().getPackageInfo(this.getPackageName(), 0);
      long lastTime = packageInfo.lastUpdateTime;
      String versionName = packageInfo.versionName;
      SharedPreferences info = getSharedPreferences("appInfo", 0);
      String oldVersionName = info.getString("versionName", "");
      mVersionName = versionName;
      mOldVersionName = oldVersionName;
      if (!versionName.equals(oldVersionName)) {
        SharedPreferences.Editor edit = info.edit();
        edit.putString("versionName", versionName);
        edit.apply();
        isVersionChanged = true;
      }
      long oldLastTime = info.getLong("lastUpdateTime", 0);
      if (oldLastTime != lastTime) {
        SharedPreferences.Editor edit = info.edit();
        edit.putLong("lastUpdateTime", lastTime);
        edit.apply();
        isUpdata = true;
        mLastTime = lastTime;
        mOldLastTime = oldLastTime;
        return true;
      }
    } catch (PackageManager.NameNotFoundException e) {
      e.printStackTrace();
    }
    return false;
  }

  @SuppressLint("StaticFieldLeak")
  private class UpdateTask extends AsyncTaskX<String, String, String> {
    @Override
    protected String doInBackground(String[] p1) {
      // TODO: Implement this method
      try {
        unApk("assets/", localDir);
      } catch (ZipException e) {
        e.printStackTrace();
      }
      return null;
    }

    protected void onPostExecute(String result) {
      startActivity();
      LuaApplication.getInstance().setSharedData("UnZiped", true);
    }

    private void unApk(String dir, String extDir) throws ZipException {
      File file = new File(extDir);
      String tempDir = getCacheDir().getPath();
      rmDir(file);
      ZipFile zipFile = new ZipFile(getApplicationInfo().publicSourceDir);
      zipFile.extractFile(dir, tempDir);
      new File(tempDir + "/" + dir).renameTo(file);
    }

    private void rmDir(File file, String str) {
      if (file.isDirectory()) {
        for (File file2 : file.listFiles()) {
          rmDir(file2, str);
        }
        file.delete();
      }
      if (file.getName().endsWith(str)) {
        file.delete();
      }
    }

    private boolean rmDir(File file) {
      if (file.isDirectory()) {
        for (File file2 : file.listFiles()) {
          rmDir(file2);
        }
      }
      return file.delete();
    }
  }
}
