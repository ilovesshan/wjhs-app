package com.wjhs.app.util;

/**
 * Created with IntelliJ IDEA.
 *
 * @author: ilovesshan
 * @date: 2022/12/24
 * @description:
 */

import android.content.Context;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Vibrator;

/**
 * 多媒体控制类
 */
public class MediaUtil {

    /**
     * 播放系统声音
     */
    public static void play_voice(Context context) {
        //初始化 系统声音
        RingtoneManager rm = new RingtoneManager(context);
        //获取系统声音路径
        Uri uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        //通过Uri 来获取提示音的实例对象
        Ringtone mRingtone = RingtoneManager.getRingtone(context, uri);
        mRingtone.play();//播放:
    }

    /**
     * 设置振动
     */
    public static void set_vibrator(Context context) {
        //设置震动
        Vibrator vibrator = (Vibrator) context.getSystemService(Context.VIBRATOR_SERVICE);
        //震动时长 ms
        vibrator.vibrate(500);
    }
}