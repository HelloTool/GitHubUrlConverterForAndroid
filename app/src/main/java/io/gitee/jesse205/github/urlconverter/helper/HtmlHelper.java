package io.gitee.jesse205.github.urlconverter.helper;


import android.os.Build;
import android.text.Html;
import android.text.Spanned;

public class HtmlHelper {
    public static Spanned fromHtml(String source) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N)
            return Html.fromHtml(source, Html.FROM_HTML_MODE_COMPACT);
        else
            //noinspection deprecation
            return Html.fromHtml(source);
    }
}
