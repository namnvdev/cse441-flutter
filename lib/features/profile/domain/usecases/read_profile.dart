import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class ReadProfile {
  final ProfileRepository repository;

  ReadProfile(this.repository);

  Future<Profile?> call(String uid) => repository.readProfile(uid);
}
