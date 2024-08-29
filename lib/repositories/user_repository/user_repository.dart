import 'package:brightblu_user_info/models/user_model.dart';
import 'package:brightblu_user_info/services/firebase_services/i_firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'i_user_repository.dart';

class UserRepository implements IUserRepository {
  final IFirebaseService _firebaseService;

  UserRepository(this._firebaseService);

  final String _collectionPath = 'employee_info';

  @override
  Future<String> createUser(UserInfo userInfo) async {
    // Convert UserInfo to a map without id
    final userMap = userInfo.toMap();
    userMap.remove('id'); // Remove id from the map to avoid setting it

    DocumentReference docRef =
        await _firebaseService.createDocument(_collectionPath, userMap);
    return docRef.id;
  }

  @override
  Future<UserInfo?> readUser(String id) async {
    DocumentSnapshot docSnapshot =
        await _firebaseService.readDocument(_collectionPath, id);
    if (docSnapshot.exists) {
      // Create UserInfo with the id set to the document id
      return UserInfo.fromMap(docSnapshot.data() as Map<String, dynamic>)
          .copyWith(id: id);
    }
    return null;
  }

  @override
  Future<void> updateUser(UserInfo userInfo) async {
    if (userInfo.id == null) {
      throw ArgumentError('UserInfo must have an id for update operations');
    }
    await _firebaseService.updateDocument(
        _collectionPath, userInfo.id!, userInfo.toMap());
  }

  @override
  Future<void> deleteUser(String id) async {
    await _firebaseService.deleteDocument(_collectionPath, id);
  }

  @override
  Future<List<UserInfo>> readAllUsers() async {
    QuerySnapshot querySnapshot =
        await _firebaseService.readAllDocuments(_collectionPath);
    return querySnapshot.docs
        .map((doc) => UserInfo.fromMap(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id))
        .toList();
  }

  @override
  Stream<List<UserInfo>> streamAllUsers() {
    return _firebaseService
        .streamCollection(_collectionPath)
        .map((querySnapshot) => querySnapshot.docs.map((doc) {
              return UserInfo.fromMap(doc.data() as Map<String, dynamic>)
                  .copyWith(id: doc.id);
            }).toList());
  }
}
