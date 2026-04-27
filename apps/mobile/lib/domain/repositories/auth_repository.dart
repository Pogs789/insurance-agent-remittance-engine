abstract class AuthRepository {
  Future<void> loginUser(String email, String password);
  Future<void> refreshToken();
  Future<void> logout();
}
