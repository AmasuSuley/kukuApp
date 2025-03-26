import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreHelper {
  static final CollectionReference messagesRef =
  FirebaseFirestore.instance.collection('messages');

  // ✅ Send message and store email + timestamp
  static Future<void> sendMessage(String message) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("⚠️ No logged-in user found!");
      return;
    }

    await messagesRef.add({
      'email': user.email, // ✅ Store email of logged-in user
      'message': message,
      'timestamp': FieldValue.serverTimestamp(), // ✅ Store timestamp
    });

    print("✅ Message sent by: ${user.email}");
  }

  // ✅ Read messages ordered by timestamp
  static Stream<List<Map<String, dynamic>>> readMessages() {
    return messagesRef
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
}
