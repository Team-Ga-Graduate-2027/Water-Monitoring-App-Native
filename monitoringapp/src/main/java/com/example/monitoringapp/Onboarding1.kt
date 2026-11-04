package com.example.monitoringapp
import com.example.monitoringapp.R
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.view.View
import com.bumptech.glide.Glide
class Onboarding1 : AppCompatActivity() {
	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_onboarding1)
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/jfukisxn_expires_30_days.png").into(findViewById(R.id.rfsrbtilwtmk))
		val button1: View = findViewById(R.id.rof1jd72f9pi)
		button1.setOnClickListener {
			val intent = Intent(this, Onboarding2::class.java)
			startActivity(intent)
			overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)
		}
	}
}