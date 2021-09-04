import 'package:equatable/equatable.dart';

class LoginClickEvent extends Equatable {
  final String username, password;

  LoginClickEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}
