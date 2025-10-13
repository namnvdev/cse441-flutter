import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A generic Firestore DataSource for basic CRUD operations.
/// T = Model type that represents the Firestore document.
class FirebaseRemoteDS<T> {
  final String collectionName;
  final T Function(DocumentSnapshot doc) fromFirestore;
  final Map<String, dynamic> Function(T item) toFirestore;

  FirebaseRemoteDS({
    required this.collectionName,
    required this.fromFirestore,
    required this.toFirestore,
  });

  CollectionReference get _collection =>
      FirebaseFirestore.instance.collection(collectionName);


  /// Get all documents in the collection
  Future<List<T>> getAll() async {
    final snapshot = await _collection.orderBy('created_at', descending: true).get();
    return snapshot.docs.map((e) => fromFirestore(e)).toList();
  }

  /// Get a single document by ID
  Future<T?> getById(String id) async {
    String docId = await getDocId(id);
    final doc = await _collection.doc(docId).get();
    if (!doc.exists) return null;
    return fromFirestore(doc);
    // final doc = await _collection.doc(id).get();
    // if (!doc.exists){
    //   final docuid = await _collection.where('uid', isEqualTo: id).limit(1).get();
    //   return fromFirestore(docuid.docs.first);
    // } 
    // return fromFirestore(doc);
  }

  /// Add a new document
  Future<String> add(T item) async {
    final docRef = await _collection.add(toFirestore(item));
    return docRef.id;
  }

  /// Update an existing document
  Future<void> update(String id, T item) async {
    String docId = await getDocId(id);
    await _collection.doc(docId).update(toFirestore(item));
  //  final doc = await _collection.doc(id).get();
  //   if (!doc.exists){
  //     final docuid = await _collection.where('uid', isEqualTo: id).limit(1).get();
  //     await _collection.doc(docuid.docs.first.id).update(toFirestore(item));
  //   } 
  // await _collection.doc(id).update(toFirestore(item));
  }

  /// Delete a document
  Future<void> delete(String id) async {
    String docId = await getDocId(id);
    await _collection.doc(docId).delete();
    //  final doc = await _collection.doc(id).get();
    // if (!doc.exists){
    //   final docuid = await _collection.where('uid', isEqualTo: id).limit(1).get();
    //   await _collection.doc(docuid.docs.first.id).delete();
    // } 
    // await _collection.doc(id).delete();
  }

  /// Listen to realtime changes in a collection
  Stream<List<T>> watchAll() {
    return _collection.orderBy('created_at', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((e) => fromFirestore(e)).toList(),
        );
  }

  String? getUserId()  {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return '';
    return user.uid;
  }

  Future<String> getDocId(String id) async{
    final doc = await _collection.doc(id).get();
    if (!doc.exists){
      final docuid = await _collection.where('uid', isEqualTo: id).limit(1).get();
      return docuid.docs.first.id;
    } 
    return doc.id;
  }
}
