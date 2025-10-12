
class Profile{
  final String uid;
  final String name;
  final String? avatarUrl;
  final String? email;
  final String? address;
  final String? phone;
  final String? bio;

  Profile({
    required this.uid,
    required this.name,
    this.avatarUrl,
    this.email,
    this.address,
    this.phone,
    this.bio,
  });
}
