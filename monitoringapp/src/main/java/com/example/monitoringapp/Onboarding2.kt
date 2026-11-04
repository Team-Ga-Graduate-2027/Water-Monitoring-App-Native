package com.example.monitoringapp
import com.example.monitoringapp.R
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.view.View
import com.bumptech.glide.Glide
class Onboarding2 : AppCompatActivity() {
	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_onboarding2)
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/95phvtcd_expires_30_days.png").into(findViewById(R.id.raoilv9osdxt))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/d6s0acbd_expires_30_days.png").into(findViewById(R.id.ral1acj2v195))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/1fte8r6x_expires_30_days.png").into(findViewById(R.id.r54gpty0nwfd))
		val button1: View = findViewById(R.id.rlhop7wzue4)
		button1.setOnClickListener {
			val intent = Intent(this, Onboarding3::class.java)
			startActivity(intent)
			overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)
		}
	}
}