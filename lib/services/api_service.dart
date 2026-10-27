
import 'package:dio/dio.dart';
import '../models/user_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await _dio.get(
        'https://randomuser.me/api/?results=10',
      );

      final List usersJson = response.data['results'];

      return usersJson
          .map((json) => UserModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }
}
