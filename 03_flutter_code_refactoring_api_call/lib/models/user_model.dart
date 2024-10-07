import 'user_name_model.dart';

class User {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final UserName name;

  User({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
  });

  String get fullName {
    return "${name.title} ${name.first} ${name.last}";
  }
}
