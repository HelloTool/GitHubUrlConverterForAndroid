package io.gitee.jesse205.github.urlconverter.helper;

import static io.gitee.jesse205.github.urlconverter.helper.ContextHelper.openInBrowser;

import android.content.Context;

import androidx.annotation.NonNull;

import io.gitee.jesse205.github.urlconverter.R;

public class BrowserHelper {
    /**
     * 打开源代码仓库链接
     *
     * @param context 上下文
     */
    public static void openSourceUrl(@NonNull Context context) {
        openInBrowser(context, context.getString(R.string.url_source));
    }

    public static void openGhProxyRepositoryUrl(@NonNull Context context) {
        openInBrowser(context, context.getString(R.string.url_gh_proxy_repository));
    }

    public static void openDocumentsUrl(@NonNull Context context) {
        openInBrowser(context, context.getString(R.string.url_documents));
    }
}
