import '../repositories/profile_repository.dart';

class DeleteProfile {
  final ProfileRepository repository;

  DeleteProfile(this.repository);

  Future<void> call(String uid) => repository.deleteProfile(uid);
}
