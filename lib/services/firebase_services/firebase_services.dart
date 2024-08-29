// lib/services/firebase_service.dart

import 'package:brightblu_user_info/services/firebase_services/i_firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService implements IFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<DocumentReference> createDocument(
      String collectionPath, Map<String, dynamic> data) {
    return _firestore.collection(collectionPath).add(data);
  }

  @override
  Future<DocumentSnapshot> readDocument(String collectionPath, String id) {
    return _firestore.collection(collectionPath).doc(id).get();
  }

  @override
  Future<void> updateDocument(
      String collectionPath, String id, Map<String, dynamic> data) {
    return _firestore.collection(collectionPath).doc(id).update(data);
  }

  @override
  Future<void> deleteDocument(String collectionPath, String id) {
    return _firestore.collection(collectionPath).doc(id).delete();
  }

  @override
  Future<QuerySnapshot> readAllDocuments(String collectionPath) {
    return _firestore.collection(collectionPath).get();
  }

  @override
  Stream<QuerySnapshot> streamCollection(String collectionPath) {
    return _firestore.collection(collectionPath).snapshots();
  }
}
