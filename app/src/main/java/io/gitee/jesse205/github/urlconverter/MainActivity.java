package io.gitee.jesse205.github.urlconverter;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.Menu;
import android.view.MenuItem;

import java.util.Objects;

import io.gitee.jesse205.github.urlconverter.databinding.ActivityMainBinding;

public class MainActivity extends Activity {
    private ActivityMainBinding binding;
    private ActionBar actionBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());
        actionBar = Objects.requireNonNull(getActionBar());
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N_MR1) {
            binding.messageView.setRevealOnFocusHint(false);
        }
        actionBar.setSubtitle(String.format("v%s (%s)", BuildConfig.VERSION_NAME, BuildConfig.VERSION_CODE));

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        super.onCreateOptionsMenu(menu);
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }

    @Override
    public boolean onMenuItemSelected(int featureId, @NonNull MenuItem item) {
        int menuId = item.getItemId();
        return super.onMenuItemSelected(featureId, item);
    }
}
