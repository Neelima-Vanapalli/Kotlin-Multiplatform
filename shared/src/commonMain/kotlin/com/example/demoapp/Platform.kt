package com.example.demoapp

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform