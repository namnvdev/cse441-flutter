import 'dart:io';

import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<void> createProfile(Profile profile);
  Future<Profile?> readProfile(String uid);
  Future<void> updateProfile(Profile profile);
  Future<void> deleteProfile(String uid);
  Future<List<Profile>> getAllProfiles();
  Future<void> uploadAvatar(String uid, File file);
}
