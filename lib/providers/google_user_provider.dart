// user_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserModel {
  const UserModel({this.name, this.email, this.photoUrl});
  final String? name, email, photoUrl;
}

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);
  void setUser({String? name, String? email, String? photoUrl}) =>
      state = UserModel(name: name, email: email, photoUrl: photoUrl);
}

final userProvider =
    StateNotifierProvider<UserNotifier, UserModel?>((_) => UserNotifier());
