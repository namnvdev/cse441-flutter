import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class CreateProfileUC {
  final ProfileRepository repository;

  CreateProfileUC(this.repository);

  Future<void> call(Profile profile) => repository.createProfile(profile);
}
