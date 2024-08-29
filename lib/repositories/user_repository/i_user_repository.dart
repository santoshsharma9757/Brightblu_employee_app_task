// lib/repositories/i_user_repository.dart
import 'package:brightblu_user_info/models/user_model.dart';

abstract class IUserRepository {
  Future<String> createUser(UserInfo userInfo);
  Future<UserInfo?> readUser(String id);
  Future<void> updateUser(UserInfo userInfo);
  Future<void> deleteUser(String id);
  Future<List<UserInfo>> readAllUsers();
  Stream<List<UserInfo>> streamAllUsers();
}
