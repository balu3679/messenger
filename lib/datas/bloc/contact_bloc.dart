import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/models/user_model.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ContactBloc() : super(ContactInitial()) {
    on<ContactUsers>(_onLoadcontacts);
    on<ContactActiveUsers>(_onlogginuser);
  }

  Future<void> _onLoadcontacts(ContactUsers event, Emitter<ContactState> emit) async {
    emit(ContactLoading());
    try {
      final currentUid = FirebaseAuth.instance.currentUser!.uid;

      final snapshot = await firestore.collection('users').get();

      final users = snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .where((user) => user.uid != currentUid)
          .toList();

      emit(ContactLoaded(users));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onlogginuser(ContactActiveUsers event, Emitter<ContactState> emit) async {
    emit(ContactLoading());
    try {
      final currentUid = FirebaseAuth.instance.currentUser!.uid;

      final docSnapshot = await firestore.collection('users').doc(currentUid).get();

      if (!docSnapshot.exists) {
        emit(ContactError("User not found"));
        return;
      }

      final currentUser = UserModel.fromMap(docSnapshot.data()!);

      emit(ContactLoaded([currentUser]));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}
