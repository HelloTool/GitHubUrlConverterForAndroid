package io.gitee.jesse205.github.urlconverter;

import android.os.Bundle;
import com.androlua.LuaActivity;
import java.io.File;

public class ConvertActivity extends LuaActivity {

    public static final String TAG = "ConvertActivity";

    public String luaDir;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


    }

	@Override
    public String getLuaPath() {
        String   path = getLocalDir() + "/sub/Convert/main.lua";
        applyLuaDir(path);
        return path;
    }

	//应用一下LuaDir
	public void applyLuaDir(String luaPath) {
		String parent = new File(luaPath).getParent();
		luaDir = parent;
		while (parent != null) {
			if (new File(parent, "main.lua").exists() && new File(parent, "init.lua").exists()) {
				luaDir = parent;
				break;
			}
			parent = new File(parent).getParent();
		}
		setLuaDir(luaDir);
	}
}
