package com.example.monitoringapp
import com.example.monitoringapp.R
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.view.View
import com.bumptech.glide.Glide
class Sensors : AppCompatActivity() {
	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_sensors)
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/h7seo3d7_expires_30_days.png").into(findViewById(R.id.rauouysx40np))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/ha4fm85y_expires_30_days.png").into(findViewById(R.id.r6xnjiwnr28f))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/86vr2nm5_expires_30_days.png").into(findViewById(R.id.r380mhu37x8j))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/9hy3wv8r_expires_30_days.png").into(findViewById(R.id.rrmolojka06s))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/4y0ifsd2_expires_30_days.png").into(findViewById(R.id.rqor77xfz0h))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/1bht3db4_expires_30_days.png").into(findViewById(R.id.rakuoeqhjcg))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/v95w7wyg_expires_30_days.png").into(findViewById(R.id.rr88ht3q8xdj))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/zsocc8qn_expires_30_days.png").into(findViewById(R.id.rsqitv87dluj))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/wpw93po6_expires_30_days.png").into(findViewById(R.id.rpld0aonulrq))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/33xt134t_expires_30_days.png").into(findViewById(R.id.rgzcfrsusv0m))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/a0i9zp61_expires_30_days.png").into(findViewById(R.id.rnb2xvjraz7))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/4va4fc83_expires_30_days.png").into(findViewById(R.id.ri6tn68qlrcn))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/9kv4p8sr_expires_30_days.png").into(findViewById(R.id.raoroob7zzsm))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/vnj11iou_expires_30_days.png").into(findViewById(R.id.r93nv4b60zj))
		Glide.with(this).load("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/h9i36jb01W/oheq83gl_expires_30_days.png").into(findViewById(R.id.rngit975vior))

		// Navigation
		findViewById<View>(R.id.rrmolojka06s)?.setOnClickListener {
			finish()
		}
		findViewById<View>(R.id.r3ry1ysalbhz)?.setOnClickListener {
			startActivity(Intent(this, SensorPage::class.java))
		}
	}
}