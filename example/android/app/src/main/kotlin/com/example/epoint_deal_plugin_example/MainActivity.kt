package com.example.epoint_deal_plugin_example

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val PERMISSION_CHANNEL = "flutter.permission/requestPermission"
    private val PERMISSION_REQUEST_CODE = 1001
    private var pendingResult: MethodChannel.Result? = null
    private var pendingPermission: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PERMISSION_CHANNEL)
            .setMethodCallHandler { call, result ->
                val isRequest = call.argument<Boolean>("isRequest") ?: false
                val permission = when (call.method) {
                    "camera" -> Manifest.permission.CAMERA
                    "storage" -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
                        Manifest.permission.READ_MEDIA_IMAGES
                    else
                        Manifest.permission.READ_EXTERNAL_STORAGE
                    "location" -> Manifest.permission.ACCESS_FINE_LOCATION
                    "microphone" -> Manifest.permission.RECORD_AUDIO
                    "notification" -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
                        Manifest.permission.POST_NOTIFICATIONS
                    else {
                        result.success(1)
                        return@setMethodCallHandler
                    }
                    else -> {
                        result.notImplemented()
                        return@setMethodCallHandler
                    }
                }

                val granted = ContextCompat.checkSelfPermission(this, permission) ==
                        PackageManager.PERMISSION_GRANTED

                if (granted) {
                    result.success(1)
                    return@setMethodCallHandler
                }

                if (!isRequest) {
                    result.success(0)
                    return@setMethodCallHandler
                }

                pendingResult = result
                pendingPermission = permission
                ActivityCompat.requestPermissions(this, arrayOf(permission), PERMISSION_REQUEST_CODE)
            }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != PERMISSION_REQUEST_CODE) return

        val result = pendingResult ?: return
        val permission = pendingPermission
        pendingResult = null
        pendingPermission = null

        if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
            result.success(1)
        } else if (permission != null &&
            !ActivityCompat.shouldShowRequestPermissionRationale(this, permission)
        ) {
            result.success(-1) // permanently denied → show settings dialog
        } else {
            result.success(0) // denied
        }
    }
}
