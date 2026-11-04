package com.example.monitoringapp
import com.example.monitoringapp.R
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.view.View
import com.bumptech.glide.Glide
class Onboarding3 : AppCompatActivity() {
	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_onboarding3)
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/68hjfyv4_expires_30_days.png").into(findViewById(R.id.recczlogpxr))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/quwsum2a_expires_30_days.png").into(findViewById(R.id.re6w0yhqfcyo))
		val button1: View = findViewById(R.id.rhr7zj6ajmi)
		button1.setOnClickListener {
			val intent = Intent(this, Home::class.java)
			startActivity(intent)
			overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)
			finish()
		}
	}
}