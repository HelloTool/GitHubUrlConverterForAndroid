package io.gitee.jesse205.github.urlconverter.helper;

import android.app.Dialog;
import android.widget.TextView;

public class DialogHelper {
    public static void setMessageIsSelectable(Dialog dialog, boolean selectable) {
        TextView textView = dialog.findViewById(android.R.id.message);
        textView.setTextIsSelectable(selectable);
    }
}
