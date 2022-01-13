import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user/user.dart';
import '../screens/admin_users_screen.dart';
import '../blocs/auth/auth.dart';
import '../screens/admin_role_screen.dart';

class UserAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Soccer'),
              automaticallyImplyLeading: false,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 50.0,
                child: Image.asset(
                  "images/person.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.sports_soccer,
                  color: Colors.pink,
                ),
                title: Text('Home'),
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(AutoLoginEvent());
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.pink,
                ),
                title: Text('Logout'),
                onTap: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
