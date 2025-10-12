import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetAllProfiles {
  final ProfileRepository repository;

  GetAllProfiles(this.repository);

  Future<List<Profile>> call() => repository.getAllProfiles();
}
