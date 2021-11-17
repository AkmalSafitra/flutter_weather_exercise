import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String firstName;

  @HiveField(1)
  final String lastName;

  @HiveField(2)
  final String emailAddress;

  @HiveField(3)
  final String password;

  User(
     this.firstName,
     this.lastName,
     this.emailAddress,
     this.password,
  );
}
