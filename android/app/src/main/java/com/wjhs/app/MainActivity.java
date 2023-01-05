package com.wjhs.app;

import android.Manifest;
import android.content.IntentFilter;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.wjhs.app.constants.ChannelConstant;
import com.wjhs.app.receiver.SmsReceiver;
import com.wjhs.app.util.MediaUtil;
import com.wjhs.app.util.PermissionUtils;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {

    private static final String TAG = "MainActivity";

    private static final String SMS_RECEIVED_ACTION = "android.provider.Telephony.SMS_RECEIVED";
    private static final String[] permissions = {android.Manifest.permission.RECEIVE_SMS, Manifest.permission.READ_SMS};
    private SmsReceiver smsReceiver;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // 注册广播
        registerSmsBroadcastReceiver();

        // 动态申请权限
        PermissionUtils.checkPermission(MainActivity.this, permissions);

        MethodChannel methodChannel = new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), ChannelConstant.NOTICE_CHANNEL_NAME);

        methodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if (call.method.equals(ChannelConstant.NOTICE_CHANNEL_METHOD_KEY)) {
                    // 调用系统提示音和震动
                    MediaUtil.play_voice(getApplicationContext());
                    MediaUtil.set_vibrator(getApplicationContext());
                }
            }
        });
    }


    private void registerSmsBroadcastReceiver() {
        smsReceiver = new SmsReceiver();
        IntentFilter intentFilter = new IntentFilter(SMS_RECEIVED_ACTION);
        registerReceiver(smsReceiver, intentFilter);

        // 注册回调接口 监听短信结果
        smsReceiver.setOnSmsResultReceivedListener(sms -> {
            Log.d(TAG, "onSmsResultReceived: " + sms.getSenderPhone());
            Log.d(TAG, "onSmsResultReceived: " + sms.getReceiveMessage());

            // 将监听结果通知给 flutter
            new Handler().post(new Runnable() {
                @Override
                public void run() {
                    new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), ChannelConstant.RECEIVE_CHANNEL_NAME)
                            .invokeMethod(ChannelConstant.RECEIVE_CHANNEL_METHOD_KEY, sms.toString());
                }
            });
        });
    }
}
