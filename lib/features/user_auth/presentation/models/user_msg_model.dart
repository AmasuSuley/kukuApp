import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email; // ✅ Email field
  String? message;
  Timestamp? timestamp; // ✅ Timestamp field

  UserModel({this.id, this.email, this.message, this.timestamp});

  // ✅ Convert Firestore document to UserModel
  factory UserModel.fromFirestore(Map<String, dynamic> data, String docId) {
    return UserModel(
      id: docId,
      email: data['email'] ?? '',
      message: data['message'] ?? '',
      timestamp: data['timestamp'] as Timestamp?, // ✅ Ensure timestamp is retrieved
    );
  }

  // ✅ Convert UserModel to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
