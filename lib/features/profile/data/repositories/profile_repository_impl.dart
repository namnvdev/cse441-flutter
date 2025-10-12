import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data/profile_remote_data_source.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createProfile(Profile profile) {
    // final model = ProfileModel(
    //   uid: profile.uid,
    //   name: profile.name,
    //   avatarUrl: profile.avatarUrl,
    //   email: profile.email,
    //   address: profile.address,
    //   phone: profile.phone,
    //   bio: profile.bio,
    // );
    final model = ProfileModel.fromEntity(profile);
    return remoteDataSource.createProfile(model);
  }

  @override
  Future<Profile?> readProfile(String uid) =>
      remoteDataSource.readProfile(uid);

  @override
  Future<void> updateProfile(Profile profile) {
    // final model = ProfileModel(
    //   uid: profile.uid,
    //   name: profile.name,
    //   avatarUrl: profile.avatarUrl,
    //   email: profile.email,
    //   address: profile.address,
    //   phone: profile.phone,
    //   bio: profile.bio,
    // );
    final model = ProfileModel.fromEntity(profile);
    return remoteDataSource.updateProfile(model);
  }

  @override
  Future<void> deleteProfile(String uid) =>
      remoteDataSource.deleteProfile(uid);

  @override
  Future<List<Profile>> getAllProfiles() =>
      remoteDataSource.getAllProfiles();
}
