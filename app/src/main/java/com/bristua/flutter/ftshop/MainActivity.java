package com.bristua.flutter.ftshop;

import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;

import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.bristua.flutter.ftshop.plugin.PluginDelegate;
import com.bristua.flutter.ftshop.plugin.PluginProvider;

import io.flutter.facade.Flutter;
import io.flutter.view.FlutterView;

public class MainActivity extends AppCompatActivity {
    FlutterView flutterView;

    private final String TAG=MainActivity.class.getName();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ActionBar supportActionBar = getSupportActionBar();
        if (supportActionBar != null) {
            supportActionBar.hide();
        }
        flutterView = Flutter.createView(MainActivity.this, getLifecycle(), "route1");
        FrameLayout.LayoutParams layout = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        PluginProvider.registerPlugin(this, flutterView, new PluginDelegate());
        setContentView(flutterView, layout);
    }


    private void testLogin(){
//        try {
//            Protocol protocol = new Protocol();
//            WXCode wxCode = new WXCode();
//            wxCode.setCode("12312313");
//            protocol.setData(wxCode);
//            protocol.setMethod(CategoryConstant.CATEGORY_TYPE_ROOT);
//            String json = JSON.toJSONString(protocol);
//            BRouter.getInstance().build(CategoryConstant.CATEGORY_MODULE).setProtocol(json).setResult(new IFlutterResult() {
//                @Override
//                public void success(@Nullable String pResult, int pErrorCode, @Nullable String pMessage) {
//
//                    Log.i(TAG,String.format("pResult:%s,code:%d,message:%s",pResult,pErrorCode,pMessage));
//                }
//
//                @Override
//                public void error(@Nullable String pMessage, int pErrorCode) {
//                    Log.i(TAG,String.format("pMessage:%s,code:%d",pMessage,pErrorCode));
//                }
//
//                @Override
//                public void notImplemented() {
//
//                }
//            }).navigation();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }


    @Override
    protected void onDestroy() {
        if (flutterView != null) {
            flutterView.destroy();
        }
        super.onDestroy();
    }

    @Override
    protected void onPause() {
        super.onPause();
        flutterView.onPause();
    }

    @Override
    protected void onPostResume() {
        super.onPostResume();
        flutterView.onPostResume();
    }

    @Override
    protected void onResume() {
        super.onResume();

    }

    @Override
    public void onBackPressed() {
        if (flutterView != null) {
            flutterView.popRoute();
            return;
        }
        super.onBackPressed();
    }
}
