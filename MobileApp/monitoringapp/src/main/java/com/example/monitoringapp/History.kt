package com.example.monitoringapp
import com.example.monitoringapp.R
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.view.View
import com.bumptech.glide.Glide
class History : AppCompatActivity() {
	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_history)
		//temporary google apis muna for some icons
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/85tu65x7_expires_30_days.png").into(findViewById(R.id.rdelvabl6j9i))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/8myc9xsb_expires_30_days.png").into(findViewById(R.id.r6r4ox5plxtt))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/9a1qic9e_expires_30_days.png").into(findViewById(R.id.rbz3dvxzfq74))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/9otbwtf8_expires_30_days.png").into(findViewById(R.id.rrgg4sssatcm))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/ot4l4kgj_expires_30_days.png").into(findViewById(R.id.r9481qv15d3g))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/ihsesrx9_expires_30_days.png").into(findViewById(R.id.rqkh5bui3ey))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/wfkr49uh_expires_30_days.png").into(findViewById(R.id.rjidesl6k7po))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/0d5wsuvm_expires_30_days.png").into(findViewById(R.id.rj3718c98ck))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/g7tymv9k_expires_30_days.png").into(findViewById(R.id.r5o5j5hr0zgy))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/l02vbm7g_expires_30_days.png").into(findViewById(R.id.rkc7xxn1zoo))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/h0uhkv32_expires_30_days.png").into(findViewById(R.id.rvesrkp0ysd))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/aiz0byja_expires_30_days.png").into(findViewById(R.id.r5sdrovvj6eh))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/dlupr6xt_expires_30_days.png").into(findViewById(R.id.rjjbo100itf))
		val button1: View = findViewById(R.id.rb92ox0wmoim)
		button1.setOnClickListener {
			println("Pressed")
		}
	}
}