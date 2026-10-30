import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    required this.isAnonymous,
  });

  final String uid;
  final bool isAnonymous;

  @override
  List<Object?> get props => [uid, isAnonymous];
}