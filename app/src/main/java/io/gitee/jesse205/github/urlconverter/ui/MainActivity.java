package io.gitee.jesse205.github.urlconverter.ui;

import static io.gitee.jesse205.github.urlconverter.helper.ContextHelper.openInBrowser;

import android.annotation.SuppressLint;
import android.app.ActionBar;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.text.util.Linkify;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;
import android.widget.PopupMenu;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.StringRes;

import com.onegravity.rteditor.RTEditorMovementMethod;

import java.io.IOException;
import java.util.Objects;

import io.gitee.jesse205.github.urlconverter.BuildConfig;
import io.gitee.jesse205.github.urlconverter.R;
import io.gitee.jesse205.github.urlconverter.databinding.ActivityMainBinding;
import io.gitee.jesse205.github.urlconverter.helper.BrowserHelper;
import io.gitee.jesse205.github.urlconverter.helper.ContextHelper;
import io.gitee.jesse205.github.urlconverter.helper.FileChangeHelper;

public class MainActivity extends BaseActivity {
    private ActivityMainBinding binding;
    private ActionBar actionBar;
    @Nullable
    private FileChangeHelper converterConfigsChangeHelper;
    @Nullable
    private FileChangeHelper platformConfigsChangeHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        initUI();
        initFile();

        parseIntent(getIntent());
    }

    private void initUI() {
        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N_MR1) {
            binding.messageView.setRevealOnFocusHint(false);
        }
        actionBar = Objects.requireNonNull(getActionBar());
        actionBar.setSubtitle(String.format("v%s (%s)", BuildConfig.VERSION_NAME, BuildConfig.VERSION_CODE));
    }

    private void initFile() {
        try {
            converterConfigsChangeHelper = new FileChangeHelper(getApp().requireConverterConfigsFile());
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            platformConfigsChangeHelper = new FileChangeHelper(getApp().requirePlatformConfigsFile());
        } catch (IOException e) {
            e.printStackTrace();
        }
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
        if (menuId == R.id.menu_about) {
            showAboutDialog();
            return true;
        } else if (menuId == R.id.menu_repositoryGhProxy) {
            BrowserHelper.openGhProxyRepositoryUrl(this);
            return true;
        } else if (menuId == R.id.menu_editConvertersConfig) {
            editConverterConfigs();
            return true;
        } else if (menuId == R.id.menu_editPlatformsConfig) {
            editPlatformConfigs();
            return true;
        } else if (menuId == R.id.menu_documents) {
            BrowserHelper.openDocumentsUrl(this);
        }
        return super.onMenuItemSelected(featureId, item);
    }

    @Override
    protected void onResume() {
        super.onResume();
        // 当配置文件发生变化时重启
        try {
            if ((converterConfigsChangeHelper != null && converterConfigsChangeHelper.isFileChanged())
                    || (platformConfigsChangeHelper != null && platformConfigsChangeHelper.isFileChanged())) {
                recreate();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void onNewIntent(Intent intent) {
        parseIntent(intent);
    }

    @SuppressLint("ClickableViewAccessibility")
    private void showAboutDialog() {
        AlertDialog dialog = new AlertDialog.Builder(this)
                .setTitle(R.string.app_name)
                .setIcon(R.mipmap.ic_launcher)
                .setMessage("") // 使用空字符串占位，稍后设置内容
                .setPositiveButton(android.R.string.ok, null)
                .setNeutralButton("法律信息...", null)
                .setNegativeButton("开源仓库", null)
                .show();

        TextView messageView = dialog.findViewById(android.R.id.message);
        Button neutralButton = dialog.getButton(Dialog.BUTTON_NEUTRAL);
        Button negativeButton = dialog.getButton(Dialog.BUTTON_NEGATIVE);
        messageView.setAutoLinkMask(Linkify.WEB_URLS | Linkify.EMAIL_ADDRESSES);
        messageView.setTextIsSelectable(true);
        messageView.setMovementMethod(RTEditorMovementMethod.getInstance());
        messageView.setText(getString(R.string.about_message,
                String.format("%s (%s)", BuildConfig.VERSION_NAME, BuildConfig.VERSION_CODE)
        ));
        // 设置为文本后需要取消自动连接，否则会点击重复
        messageView.setAutoLinkMask(0);

        messageView.requestFocus();
        PopupMenu termPopupMenu = new PopupMenu(this, neutralButton);
        termPopupMenu.inflate(R.menu.about_terms);
        termPopupMenu.setOnMenuItemClickListener(menuItem -> {
            int itemId = menuItem.getItemId();
            @StringRes int urlId = 0;
            if (itemId == R.id.menu_userAgreement)
                urlId = R.string.url_userAgreement;
            else if (itemId == R.id.menu_privacyPolicy)
                urlId = R.string.url_privacyPolicy;
            else if (itemId == R.id.menu_openSourceLicense)
                urlId = R.string.url_openSourceLicense;
            else if (itemId == R.id.menu_thirdPartyInformationSharing)
                urlId = R.string.url_informationSharing;

            if (urlId == 0) {
                return false;
            }
            openInBrowser(this, getString(urlId));
            return true;
        });
        neutralButton.setOnClickListener(view -> termPopupMenu.show());
        negativeButton.setOnClickListener(view -> BrowserHelper.openSourceUrl(this));
        neutralButton.setOnTouchListener(termPopupMenu.getDragToOpenListener());
    }

    private void editConverterConfigs() {
        ContextHelper.editFile(this, getApp().requireConverterConfigsFile(), "text/json");
    }

    private void editPlatformConfigs() {
        ContextHelper.editFile(this, getApp().requirePlatformConfigsFile(), "text/json");
    }

    /**
     * 解析 Intent
     *
     * @param intent 要解析的 Intent
     */
    private void parseIntent(Intent intent) {
        String text = null;
        if (intent.getData() != null) {
            Uri data = intent.getData();
            String scheme = data.getScheme();
            String host = data.getHost();
            if ("http".equals(scheme) || "https".equals(scheme)) {
                if ("github.com".equals(host)) {
                    text = data.toString();
                }
            }
        } else if (intent.getStringExtra(Intent.EXTRA_TEXT) != null) {
            text = intent.getStringExtra(Intent.EXTRA_TEXT);
        }

        if (text == null) return;
        binding.inputEdit.setText(text);
    }
}
