package com.sleepygarden.swaeng.app;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;
import android.content.Context;

import org.apache.http.client.methods.HttpPost;

import java.util.HashMap;

public class MainActivity extends Activity {

    final Context context = this;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        final Button myButton = (Button)findViewById(R.id.my_button);

        final Button myOtherButton = (Button)findViewById(R.id.my_other_button);
        myButton.setText("Oh SNAP!");
        myOtherButton.setText("You momma");

        myButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast.makeText(context,"Message",Toast.LENGTH_SHORT).show();
            }
        });

        myOtherButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                myButton.setText("Seether is an ok song.");
            }
        });

        HashMap<String,Object> myDict = new HashMap<String,Object>();
    }
}
