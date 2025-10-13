import 'dart:io';
import 'package:my_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:my_app/features/profile/domain/repositories/profile_repository.dart';

class UploadAvatar {
  final ProfileRepository _repository;

  UploadAvatar(this._repository);

  Future<void> call(String uid, File file) async {
    await _repository.uploadAvatar(uid, file);
  }
}
