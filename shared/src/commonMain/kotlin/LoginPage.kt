import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class LoginPage {

    private val scope = CoroutineScope(Dispatchers.Main)
    private val repository = LoginRepository()

    fun login(username: String, password: String,onLoginResult: (Boolean) -> Unit) {
        scope.launch {
            val result = repository.authenticate(username, password)
            onLoginResult(result)
        }
    }
}

