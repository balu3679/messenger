import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messenger/datas/bloc/contact_bloc.dart';
import 'package:messenger/service/authentication.dart';
import 'package:messenger/widgets/global/alerts.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final ContactBloc cbloc = ContactBloc();

  @override
  void initState() {
    cbloc.add(ContactActiveUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              bool resp = await Constants.showalert(
                context,
                title: 'Log out ?',
                subtitle: 'Are you sure want to logout',
              );
              if (resp) {
                await Authentication.signOut();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }
            },
          ),
        ],
        title: Text(
          'My Account',
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
          return ListView.builder(
            itemCount: state.users.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final contact = state.users[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text('Username', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                      Text(contact.name, style: GoogleFonts.poppins()),
                      const SizedBox(height: 12),
                      Text('Email Id', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                      Text(contact.email, style: GoogleFonts.poppins()),
                      const SizedBox(height: 12),
                      Text(
                        'Contact Number',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                      ),
                      Text(contact.phone, style: GoogleFonts.poppins()),
                      const SizedBox(height: 12),
                      Text('Comapany', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                      Text(contact.company, style: GoogleFonts.poppins()),
                      const SizedBox(height: 12),
                      Text('Notes', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                      Text(contact.notes, style: GoogleFonts.poppins()),
                    ],
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
