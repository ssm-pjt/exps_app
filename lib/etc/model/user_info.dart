

class UserInfo {
  UserInfo({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.dept,
    this.password,

  });

  String id;
  String name;
  String phone;
  String email;
  String dept;
  String? password;
}