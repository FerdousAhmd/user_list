
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  Future<List<UserModel>> getUsers() {
    return _apiService.fetchUsers();
  }
}
