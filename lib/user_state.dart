import 'package:find_job_app/Jobs/jobs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginPage/login_screen.dart';

class UserState extends StatelessWidget {
   UserState({super.key});



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot)
      {
        if(userSnapshot.data == null)
          {
            print('User is Offline');
            return const Login();
          }
        else if(userSnapshot.hasData)
          {
          print('User is Online');
          return JobsScreen();
          }

        else if(userSnapshot.hasError)
          {
            return const Scaffold(
              body: Center(
                child: Text('An error Occurred. Try Again Later'),
              ),
            );
          }

        else if(userSnapshot.connectionState == ConnectionState.waiting)
        {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text('Something Went Wrong'),
          ),
        );
      },
    );
  }
}
