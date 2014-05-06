package com.sleepygarden.swaeng.app;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends Activity {

    final Context context = this;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        final Button practiceBtn = (Button)findViewById(R.id.practice_btn);
        final Button dictBtn = (Button)findViewById(R.id.dict_btn);

        practiceBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(context,PracticeActivity.class);
                startActivity(intent);
                //finish();
            }
        });

        dictBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(context,DictionaryActivity.class);
                startActivity(intent);
                // if you leave this in, this current layer is taken off the activity stack before the next is added
                // finish();
            }
        });
    }
}
