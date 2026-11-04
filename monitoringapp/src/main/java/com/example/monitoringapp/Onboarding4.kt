package com.example.monitoringapp
import com.example.monitoringapp.R
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import androidx.appcompat.app.AppCompatActivity
import android.view.View
import com.bumptech.glide.Glide
class Onboarding4 : AppCompatActivity() {
	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_onboarding4)
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/fs9otmlc_expires_30_days.png").into(findViewById(R.id.rdpfafmxc4qf))

		val handler = Handler(Looper.getMainLooper())
		val runnable = Runnable {
			navigateToOnboarding1()
		}
		handler.postDelayed(runnable, 1500)

		findViewById<View>(android.R.id.content).setOnClickListener {
			handler.removeCallbacks(runnable)
			navigateToOnboarding1()
		}
	}

	private fun navigateToOnboarding1() {
		val intent = Intent(this, Onboarding1::class.java)
		startActivity(intent)
		finish()
	}
}