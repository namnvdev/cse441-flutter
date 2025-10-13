import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '/core/data/firebase_remote_data_source.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<void> createProfile(ProfileModel profile);
  Future<ProfileModel?> readProfile(String uid);
  Future<void> updateProfile(ProfileModel profile);
  Future<void> deleteProfile(String uid);
  Future<List<ProfileModel>> getAllProfiles();
  String? getUserId();
  Future<void> uploadAvatar(String uid, File file);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {

  final FirebaseRemoteDS<ProfileModel> _remoteSource;

  ProfileRemoteDataSourceImpl()
      : _remoteSource = FirebaseRemoteDS<ProfileModel>(
          collectionName: 'profiles',
          fromFirestore: (doc) => ProfileModel.fromFirestore(doc),
          toFirestore: (model) => model.toJson(),
        );

  final CollectionReference _collection = FirebaseFirestore.instance.collection('profiles');
  // final FirebaseFirestore firestore;
  // ProfileRemoteDataSourceImpl(this.firestore);
  // CollectionReference get _collection => _remoteSource.collection('profiles');
  @override
  Future<void> createProfile(ProfileModel profile) async {
    if (profile.uid.isNotEmpty){
      await _collection.doc(profile.uid).set(profile.toJson());
      return;
    }
      await  _remoteSource.add(profile);
  }

  @override
  Future<ProfileModel?> readProfile(String uid) async {
    // final doc = await _collection.doc(uid).get();
    // if (!doc.exists) return null;
    // return ProfileModel.fromJson(doc.data() as Map<String, dynamic>);
    
    return await _remoteSource.getById(uid);
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    // await _collection.doc(profile.uid).update(profile.toJson());
    await _remoteSource.update(profile.uid, profile);
  }

  @override
  Future<void> deleteProfile(String uid) async {
    // await _collection.doc(uid).delete();
    await _remoteSource.delete(uid);
  }

  @override
  Future<List<ProfileModel>> getAllProfiles() async {
    // final snapshot = await _collection.get();
    // return snapshot.docs
    //     .map((doc) => ProfileModel.fromJson(doc.data() as Map<String, dynamic>))
    //     .toList();
    return await _remoteSource.getAll();
  }


  @override
  String? getUserId()  {
    return _remoteSource.getUserId();
  }

  @override
  Future<void> uploadAvatar(String uid, File file) async {
   
    String docId = await _remoteSource.getDocId(uid);
//upload file to storage

//update path to docId.avatarUrl
  }
}
