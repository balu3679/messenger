import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/models/chat_screen_argments_model.dart';
import 'package:messenger/widgets/global/alerts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        bool resp = await Constants.showalert(
          context,
          title: 'Exit App ?',
          subtitle: 'Are you sure want to exit',
        );
        if (resp) {
          exit(0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Messenger',
            style: GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),

        body: statebody(),
      ),
    );
  }

  Widget statebody() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error : ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return cardlist(snapshot, context);
        }
        return Center(child: Text('Something Went Wrong!'));
      },
    );
  }

  Widget cardlist(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: snapshot.data!.docs
          .where((doc) => doc['email'] != FirebaseAuth.instance.currentUser!.email)
          .map<Widget>(
            (doc) => Card(
              child: ListTile(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/chat',
                  arguments: ChatScreenModel(
                    userId: doc['uid'],
                    email: doc['email'],
                    userName: doc['email'].toString().split('@')[0],
                  ),
                ),
                leading: CircleAvatar(
                  child: Text(
                    doc['email'][0].toString().toUpperCase() +
                        doc['email'].toString().split('@')[1][0].toUpperCase(),
                  ),
                ),
                title: Text(
                  doc['email'].toString().split('@')[0][0].toUpperCase() +
                      doc['email'].toString().split('@')[0].substring(1).toLowerCase(),
                  style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  doc['email'],
                  style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
