import 'package:flutter/material.dart';
import 'package:my_app/features/profile/data/data/profile_remote_data_source.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/create_profile.dart';
import '../../domain/usecases/read_profile.dart';
import '../../domain/usecases/update_profile.dart';
import '../../domain/usecases/delete_profile.dart';
import '../../data/repositories/profile_repository_impl.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late final _remoteSource = ProfileRemoteDataSourceImpl();
  late final _repo = ProfileRepositoryImpl(_remoteSource);

  late final String uid = _remoteSource.getUserId().toString();
  

  // late final _repo = ProfileRepositoryImpl(
  //   ProfileRemoteDataSourceImpl(FirebaseFirestore.instance),
  // );

  late final _create = CreateProfile(_repo);
  late final _read = ReadProfile(_repo);
  late final _update = UpdateProfile(_repo);
  late final _delete = DeleteProfile(_repo);

  Profile? profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final data = await _read(uid);
    setState(() => profile = data);
  }

  Future<void> _updateProfile() async {
    if (profile == null) return;
    final updated = Profile(
      uid: profile!.uid,
      name: "Updated ${profile!.name}",
      avatarUrl: profile!.avatarUrl,
      email: profile!.email,
      address: profile!.address,
      phone: profile!.phone,
      bio: profile!.bio,
    );
    await _update(updated);
    _loadProfile();
  }

  Future<void> _deleteProfile() async {
    await _delete(uid);
    setState(() => profile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile CRUD')),
      body: Center(
        child: profile == null
            ? const Text('No profile found')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(profile!.avatarUrl ?? ''),
                    radius: 40,
                  ),
                  Text(profile!.name, style: const TextStyle(fontSize: 20)),
                  Text(profile!.email ?? ''),
                  Text(profile!.address ?? ''),
                  Text(profile!.phone ?? ''),
                  Text(profile!.bio ?? ''),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateProfile,
                    child: const Text('Update Profile'),
                  ),
                  ElevatedButton(
                    onPressed: _deleteProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Delete Profile'),
                  ),
                ],
              ),
      ),
    );
  }
}
