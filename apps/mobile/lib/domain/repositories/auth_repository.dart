abstract class AuthRepository {
  Future<void> loginUser(String email, String password);
  Future<bool> checkLoggedInUser();
  Future<void> refreshToken();
  Future<void> logout();
}
