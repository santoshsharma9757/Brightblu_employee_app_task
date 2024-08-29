// lib/services/i_firebase_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IFirebaseService {
  Future<DocumentReference> createDocument(String collectionPath, Map<String, dynamic> data);
  Future<DocumentSnapshot> readDocument(String collectionPath, String id);
  Future<void> updateDocument(String collectionPath, String id, Map<String, dynamic> data);
  Future<void> deleteDocument(String collectionPath, String id);
  Future<QuerySnapshot> readAllDocuments(String collectionPath);
  Stream<QuerySnapshot> streamCollection(String collectionPath);
}
