part of 'contact_bloc.dart';

sealed class ContactState {}

final class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final List<UserModel> users;
  ContactLoaded(this.users);
}

class ContactError extends ContactState {
  final String message;
  ContactError(this.message);
}
