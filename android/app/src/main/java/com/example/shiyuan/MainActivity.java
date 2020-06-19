package com.example.shiyuan;

import io.flutter.embedding.android.FlutterActivity;
import android.os.Bundle;
public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.getWindow().getDecorView().setBackgroundColor(R.color.white);
    }
}
