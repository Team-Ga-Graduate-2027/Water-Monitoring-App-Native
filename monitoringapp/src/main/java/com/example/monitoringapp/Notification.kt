package com.example.monitoringapp
import com.example.monitoringapp.R
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.view.View
import com.bumptech.glide.Glide
class Notification : AppCompatActivity() {
	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_notification)
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/0n5drika_expires_30_days.png").into(findViewById(R.id.r74dpb339w6d))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/wikj3njz_expires_30_days.png").into(findViewById(R.id.r02smuchxqz7))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/b85xdo3p_expires_30_days.png").into(findViewById(R.id.rjtq0772dv))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/v4i5u5mg_expires_30_days.png").into(findViewById(R.id.rg6qmyudt1yk))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/w5hi8csq_expires_30_days.png").into(findViewById(R.id.rn7eawyc1w2k))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/6mwndiwv_expires_30_days.png").into(findViewById(R.id.rgjemf8dh30r))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/09bswhld_expires_30_days.png").into(findViewById(R.id.rtfdfo93ffyk))
	}
}