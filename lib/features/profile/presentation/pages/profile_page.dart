import 'package:flutter/material.dart';
import 'package:my_app/features/profile/data/data/profile_remote_data_source.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/create_profile.dart' as usecase;
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

  late final String uid = _remoteSource.getUserId()??'';
  

  // late final _repo = ProfileRepositoryImpl(
  //   ProfileRemoteDataSourceImpl(FirebaseFirestore.instance),
  // );

  late final _create = usecase.CreateProfileUC(_repo);
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

  Future<void> _createProfile() async {
    final newProfile = Profile(
      uid: uid,
      name: 'New Profile',);
    await _create(newProfile);
    _loadProfile();

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

  Future<void> _updateAvatar() async {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile CRUD')),
      body: Center(
        child: profile == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No profile found.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _createProfile,
                    child: const Text('Create Profile'),)
                  ]
            ) 
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _updateAvatar, // ✅ handle tap
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profile!.avatarUrl ?? ''),
                      radius: 40,
                    ),
                  ),
                  TextField(
                     decoration:InputDecoration(
                      labelText: profile!.name ?? '',
                      border: OutlineInputBorder(),)
                     ),
                  
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
