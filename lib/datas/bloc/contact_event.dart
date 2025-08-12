part of 'contact_bloc.dart';

sealed class ContactEvent {}

class ContactUsers extends ContactEvent {}

class ContactActiveUsers extends ContactEvent {}
