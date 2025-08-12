import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messenger/datas/bloc/contact_bloc.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ContactBloc cbloc = ContactBloc();

  @override
  void initState() {
    cbloc.add(ContactUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Contacts',
          style: GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: statebody(),
    );
  }

  Widget statebody() {
    return BlocBuilder<ContactBloc, ContactState>(
      bloc: cbloc,
      builder: (context, state) {
        if (state is ContactLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ContactLoaded) {
          if (state.users.isEmpty) {
            return Center(child: Text('No Contacts found'));
          }
          return ListView.builder(
            itemCount: state.users.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final contact = state.users[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      contact.email[0].toString().toUpperCase() +
                          contact.email.toString().split('@')[1][0].toUpperCase(),
                    ),
                  ),
                  title: Text(
                    contact.name,
                    style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    contact.email,
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is ContactError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Center(child: Text('Something Went Wrong!'));
      },
    );
  }
}
