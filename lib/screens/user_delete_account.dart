import 'package:flutter/material.dart';
import 'package:soccer_app/blocs/auth/auth_blocs.dart';
import 'package:soccer_app/blocs/auth/auth_states.dart';
import 'package:soccer_app/blocs/user/user.dart';
import 'package:soccer_app/util/util.dart';
import 'login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/models/model.dart';

class DeleteAccountPage extends StatefulWidget {
  static const String routeName = "user_delete_account";

  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Delete Account"),
      ),
      body: BlocConsumer<UserBloc, UserStates>(
        listener: (BuildContext context, state) {
          if (state is UserDeletedState) {
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          }
          if (state is UserDeletingErrorState) {
            scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('User Deleting Error'),
                duration: Duration(
                  seconds: 5,
                )));
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Center(
              child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Are You Sure You want to delete your Account??",
                style: TextStyle(color: Colors.redAccent),
              ),
              FlatButton(
                  onPressed: () async {
                    Util util = new Util();
                    User user = await util.getUserInformation();
                    context
                        .read<UserBloc>()
                        .add(DeleteUserEvent(userId: user.id.toString()));
                  },
                  child: Text("YES")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No"))
            ],
          ));
        },
      ),
    );
  }
}
