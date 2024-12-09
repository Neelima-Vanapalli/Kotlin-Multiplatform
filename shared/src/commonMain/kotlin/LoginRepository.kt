import kotlinx.coroutines.delay

class LoginRepository {
     suspend fun authenticate(username: String, password: String): Boolean {
         delay(2000)
         return username == "admin" && password == "password"
    }
}