package io.gitee.jesse205.github.urlconverter.ui;

import android.app.Activity;
import android.content.Context;

import io.gitee.jesse205.github.urlconverter.App;

public class BaseActivity extends Activity {

    public static App getApp() {
        return App.getInstance();
    }
}
