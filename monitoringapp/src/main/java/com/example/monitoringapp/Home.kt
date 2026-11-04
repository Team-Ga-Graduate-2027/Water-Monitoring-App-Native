package com.example.monitoringapp
import com.example.monitoringapp.R
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.view.View
import com.bumptech.glide.Glide
class Home : AppCompatActivity() {
	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_home)
		//Temporary using google apis muna for some icons. Will replace later - hansu
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/y7mzriws_expires_30_days.png").into(findViewById(R.id.rg636cfq6kgw))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/2bzt4ja8_expires_30_days.png").into(findViewById(R.id.rxfzmx96c0eq))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/36hdmj3t_expires_30_days.png").into(findViewById(R.id.rxao8qss6blo))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/yw02kb6x_expires_30_days.png").into(findViewById(R.id.raukd7hhq53o))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/glrbe2jb_expires_30_days.png").into(findViewById(R.id.rijfvamdezrh))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/bpiaf41q_expires_30_days.png").into(findViewById(R.id.r0mxdpmg7uwt))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/5xsf74nz_expires_30_days.png").into(findViewById(R.id.rbyl9j1r46c))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/1eaqqchk_expires_30_days.png").into(findViewById(R.id.r3y4uxh9vpr4))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/glrbe2jb_expires_30_days.png").into(findViewById(R.id.rvsbusjolxom))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/bpiaf41q_expires_30_days.png").into(findViewById(R.id.riuh76botsxg))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/1z6mxqr7_expires_30_days.png").into(findViewById(R.id.rmp0co5yy4i))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/z0s8s216_expires_30_days.png").into(findViewById(R.id.ruxagj4wdzd))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/hy3g8ltc_expires_30_days.png").into(findViewById(R.id.r15oer5rxjih))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/bxdcomxh_expires_30_days.png").into(findViewById(R.id.rriaf8co1bsn))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/86j44f04_expires_30_days.png").into(findViewById(R.id.ri8fysn056qi))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/02cyfxob_expires_30_days.png").into(findViewById(R.id.rlnxgh3v9ije))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/husnnst3_expires_30_days.png").into(findViewById(R.id.rc6fyvali7dv))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/a5hzo4hp_expires_30_days.png").into(findViewById(R.id.rzualjmybf6i))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/zuvtc1r6_expires_30_days.png").into(findViewById(R.id.r9fsar5qi0rh))

		// Navigation
		findViewById<View>(R.id.rzualjmybf6i)?.setOnClickListener {
			startActivity(Intent(this, Sensors::class.java))
		}
		findViewById<View>(R.id.r9fsar5qi0rh)?.setOnClickListener {
			startActivity(Intent(this, Settings::class.java))
		}
		findViewById<View>(R.id.retni5kllqm)?.setOnClickListener {
			startActivity(Intent(this, Sensors::class.java))
		}
		findViewById<View>(R.id.rxao8qss6blo)?.setOnClickListener {
			startActivity(Intent(this, Notification::class.java))
		}
		findViewById<View>(R.id.r45t51oh604m)?.setOnClickListener {
			startActivity(Intent(this, SensorPage::class.java))
		}
	}
}