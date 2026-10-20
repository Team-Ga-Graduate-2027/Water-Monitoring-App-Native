
package com.example.salin_suri;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        TextView textView = new TextView(this);
        textView.setText("Hello world bitchass part 333pasdasdasd");
        textView.setTextSize(28);

        setContentView(textView);
    }
}
