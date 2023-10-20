package io.gitee.jesse205.github.urlconverter.helper;

import android.content.Context;
import android.net.Uri;

import androidx.annotation.NonNull;
import androidx.core.content.FileProvider;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import io.gitee.jesse205.github.urlconverter.BuildConfig;

public class FileHelper {
    private static final String AUTHORITY = BuildConfig.APPLICATION_ID + ".fileprovider";

    public static Uri getUriForFile(Context context, File file) {
        return FileProvider.getUriForFile(context, AUTHORITY, file);
    }

    public static void copyFile(@NonNull FileChannel sourceChannel, @NonNull FileChannel destChannel) throws IOException {
        long size = sourceChannel.size();
        for (long left = size; left > 0; ) {
            left -= sourceChannel.transferTo((size - left), left, destChannel);
        }
    }

    public static void copyFile(@NonNull FileInputStream sourceStream, @NonNull FileOutputStream destStream) throws IOException {
        try (FileChannel sourceChannel = sourceStream.getChannel(); FileChannel destChannel = destStream.getChannel()) {
            copyFile(sourceChannel, destChannel);
        }
    }

    public static void copyFile(@NonNull InputStream sourceStream, @NonNull OutputStream destStream) throws IOException {
        if (sourceStream instanceof FileInputStream && destStream instanceof FileOutputStream) {
            copyFile((FileInputStream) sourceStream, (FileOutputStream) destStream);
            return;
        }
        byte[] b = new byte[1024 * 5];
        int len;
        while ((len = sourceStream.read(b)) != -1) {
            destStream.write(b, 0, len);
        }
        destStream.flush();
    }

    public static void copyFile(@NonNull File sourceFile, @NonNull File destFile) throws IOException {
        try (FileInputStream sourceInputStream = new FileInputStream(sourceFile); FileOutputStream destOutputStream = new FileOutputStream(destFile)) {
            copyFile(sourceInputStream, destOutputStream);
        }
    }

    /**
     * 当 <code>oldFile</code> 存在时，则移动文件到 <code>newFile</code>
     *
     * @param oldFile 旧文件
     * @param newFile 新文件
     * @return 如果移动成功，或者无需移动时返回 <code>true</code>
     * @noinspection UnusedReturnValue
     */
    public static boolean moveFileIfExists(@NonNull File oldFile, @NonNull File newFile) {
        if (!newFile.exists() && oldFile.isFile()) {
            return oldFile.renameTo(newFile);
        }
        return true;
    }

    /**
     * 版权声明：本文为 CSDN 博主「星河漫步」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
     * 原文链接：<a href="https://blog.csdn.net/jinqilin721/article/details/94429400">...</a>
     * 计算文件的 Hash 值
     *
     * @return hash：SHA-256
     */
    public static String getHashByFile(@NonNull File file) throws IOException {
        try {
            return getHashByFile(file, "SHA-256");
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 计算文件的 Hash 值
     */
    public static String getHashByFile(@NonNull File file, @NonNull String hashType) throws IOException, NoSuchAlgorithmException {
        String value;
        try (FileInputStream fis = new FileInputStream(file)) {
            MappedByteBuffer byteBuffer = fis.getChannel().map(FileChannel.MapMode.READ_ONLY, 0, file.length());
            MessageDigest digest = MessageDigest.getInstance(hashType);
            digest.update(byteBuffer);
            BigInteger bigInteger = new BigInteger(1, digest.digest());
            value = bigInteger.toString(16);
        }
        return value;
    }
}
