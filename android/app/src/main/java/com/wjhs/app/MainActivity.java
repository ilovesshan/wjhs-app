package com.wjhs.app;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.wjhs.app.constants.ChannelConstant;
import com.wjhs.app.util.MediaUtil;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
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
}
