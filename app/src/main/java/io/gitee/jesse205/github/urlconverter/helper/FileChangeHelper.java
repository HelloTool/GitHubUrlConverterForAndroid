package io.gitee.jesse205.github.urlconverter.helper;

import static io.gitee.jesse205.github.urlconverter.helper.FileHelper.getHashByFile;

import java.io.File;
import java.io.IOException;

public class FileChangeHelper {
    private final File file;
    private String fileHash;

    public FileChangeHelper(File file) throws IOException {
        this.file = file;
        update();
    }

    public String getFileHash() {
        return fileHash;
    }

    public void update() throws IOException {
        fileHash = getHashByFile(file);
    }

    public boolean isFileChanged() throws IOException {
        return !fileHash.equals(getHashByFile(file));
    }
}
