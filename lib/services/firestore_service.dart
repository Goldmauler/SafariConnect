// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sanctuary_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get a stream of all sanctuaries
  Stream<List<Sanctuary>> getSanctuaries() {
    return _db.collection('sanctuaries').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Sanctuary.fromFirestore(doc)).toList());
  }

  // Get a stream for just the featured sanctuaries (e.g., first 3)
  Stream<List<Sanctuary>> getFeaturedSanctuaries() {
    return _db
        .collection('sanctuaries')
        .limit(3)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Sanctuary.fromFirestore(doc))
            .toList());
  }
}