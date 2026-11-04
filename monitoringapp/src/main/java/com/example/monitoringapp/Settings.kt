package com.example.monitoringapp
import com.example.monitoringapp.R
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.view.View
import com.bumptech.glide.Glide
class Settings : AppCompatActivity() {
	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_settings)
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/udznzrmx_expires_30_days.png").into(findViewById(R.id.r2xill398584))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/gemw2o7i_expires_30_days.png").into(findViewById(R.id.r72avdp1uc8h))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/c9epe6l0_expires_30_days.png").into(findViewById(R.id.rldmvvl5dtch))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/ql1e4iwa_expires_30_days.png").into(findViewById(R.id.rxkckxr3uh6n))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/mq424f2c_expires_30_days.png").into(findViewById(R.id.rht5l948942j))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/01300v2k_expires_30_days.png").into(findViewById(R.id.r8g3xi7w5o0j))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/38f0nzs2_expires_30_days.png").into(findViewById(R.id.rkvks7aivpo))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/jbkbr0fw_expires_30_days.png").into(findViewById(R.id.rjkaxtb6cv0c))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/42r8t407_expires_30_days.png").into(findViewById(R.id.rk14qmxixhch))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/d4zbgc35_expires_30_days.png").into(findViewById(R.id.r0w5hw2rusoz))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/6sq4oc9v_expires_30_days.png").into(findViewById(R.id.rbk12d774plb))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/f782j8aj_expires_30_days.png").into(findViewById(R.id.ryf89hrxhb7m))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/nvhqyrra_expires_30_days.png").into(findViewById(R.id.rxwhean3i48h))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/eydyf9z0_expires_30_days.png").into(findViewById(R.id.relxcsjhb15))

		// Navigation
		findViewById<View>(R.id.ryf89hrxhb7m)?.setOnClickListener {
			startActivity(Intent(this, Home::class.java))
			finish()
		}
		findViewById<View>(R.id.rxwhean3i48h)?.setOnClickListener {
			startActivity(Intent(this, Sensors::class.java))
		}
	}
}