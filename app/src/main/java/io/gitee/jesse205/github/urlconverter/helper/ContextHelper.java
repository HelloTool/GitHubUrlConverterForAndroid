package io.gitee.jesse205.github.urlconverter.helper;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.StringRes;

import java.io.File;

import io.gitee.jesse205.github.urlconverter.R;

public class ContextHelper {
    public static void openInBrowser(@NonNull Context context, String url) {
        Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        tryStartActivity(context, intent);
    }

    public static void openInOtherApp(Context context, Uri uri, String type) {
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
        intent.setDataAndType(uri, type);
        tryStartActivity(context, intent);
    }

    /**
     * 尝试获启动活动，如果失败就弹出失败原因。
     *
     * @param context 上下文
     * @param intent  要启动的意图
     */
    private static void tryStartActivity(@NonNull Context context, @NonNull Intent intent) {
        try {
            context.startActivity(intent);
        } catch (ActivityNotFoundException e) {
            e.printStackTrace();
            toast(context, R.string.cannotFoundApp);
        }
    }

    public static void toast(Context context, @StringRes int resId) {
        Toast.makeText(context, resId, Toast.LENGTH_SHORT).show();
    }

    public static void editExternalFile(Context context, String dirType, String child, String type) {
        File file = new File(context.getExternalFilesDir(dirType), child);
        editFile(context, file, type);
    }

    public static void editFile(Context context, File file, String type) {
        ContextHelper.openInOtherApp(context, FileHelper.getUriForFile(context, file), type);
    }
}
