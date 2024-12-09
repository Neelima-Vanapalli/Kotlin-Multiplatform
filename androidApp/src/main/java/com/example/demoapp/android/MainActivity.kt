package com.example.demoapp.android

import LoginPage
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.Button
import android.widget.EditText
import android.widget.ProgressBar
import android.widget.Toast
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class MainActivity : AppCompatActivity() {

    private val loginViewModel = LoginPage()
    private lateinit var loader: ProgressBar

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val username = findViewById<EditText>(R.id.emailAddress)
        val password = findViewById<EditText>(R.id.password)
        val loginButton = findViewById<Button>(R.id.loginBtn)
        loader = findViewById(R.id.loading)

        loginButton.setOnClickListener {
            val username = username.text.toString()
            val password = password.text.toString()

            if (username.isEmpty() || password.isEmpty()) {
                Toast.makeText(this, "Please enter both username and password", Toast.LENGTH_SHORT)
                    .show()
            } else {
                loader.visibility = ProgressBar.VISIBLE  // Show loader

                loginViewModel.login(username, password) { isSuccess ->
                    loader.visibility = ProgressBar.GONE  // Hide loader

                    val message = if (isSuccess) "Login successful!" else "Invalid credentials"
                    Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
                }


            }

        }
    }

}

