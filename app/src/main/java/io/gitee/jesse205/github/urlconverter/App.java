package io.gitee.jesse205.github.urlconverter;

import android.app.Application;

import androidx.annotation.NonNull;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import io.gitee.jesse205.github.urlconverter.helper.FileHelper;

public class App extends Application {

    private static App instance;

    private File configDir;
    private File platformConfigsFile;
    private File converterConfigsFile;

    @NonNull
    public static App getInstance() {
        return instance;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;
        configDir = getExternalFilesDir("config");
        platformConfigsFile = new File(configDir, Constant.PATH_CONFIGS_PLATFORM_CONFIGS);
        converterConfigsFile = new File(configDir, Constant.PATH_CONFIGS_CONVERTER_CONFIGS);

        // 迁移数据
        FileHelper.moveFileIfExists(
                new File(configDir, Constant.PATH_CONFIGS_CONVERTER_CONFIGS_V0),
                converterConfigsFile);

        // requirePlatformConfigFile();
        // requireConverterConfigFile();
    }

    @NonNull
    public File requirePlatformConfigsFile() {
        if (!platformConfigsFile.isFile()) {
            if (platformConfigsFile.exists()) {
                //noinspection ResultOfMethodCallIgnored
                platformConfigsFile.delete();
            }
            try (InputStream inputStream = getAssets().open(Constant.PATH_ASSETS_PLATFORM_CONFIGS_DEFAULT);
                 FileOutputStream outputStream = new FileOutputStream(platformConfigsFile)) {
                FileHelper.copyFile(inputStream, outputStream);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        return platformConfigsFile;
    }

    @NonNull
    public File requireConverterConfigsFile() {
        if (!converterConfigsFile.isFile()) {
            if (converterConfigsFile.exists()) {
                //noinspection ResultOfMethodCallIgnored
                converterConfigsFile.delete();
            }
            try (InputStream inputStream = getAssets().open(Constant.PATH_ASSETS_CONFIGS_CONVERTER_CONFIGS_DEFAULT);
                 FileOutputStream outputStream = new FileOutputStream(converterConfigsFile)) {
                FileHelper.copyFile(inputStream, outputStream);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        return converterConfigsFile;
    }

    @NonNull
    public File getConfigDir() {
        return configDir;
    }

    @NonNull
    public File getPlatformConfigsFile() {
        return platformConfigsFile;
    }

    @NonNull
    public File getConverterConfigsFile() {
        return converterConfigsFile;
    }
}

