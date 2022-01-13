import 'package:flutter/material.dart';
import 'package:soccer_app/blocs/Role/role.dart';
import 'package:soccer_app/blocs/fixture/fixture.dart';
import 'package:soccer_app/models/fixture.dart';
import 'package:soccer_app/screens/admin_role_screen.dart';
import '../models/user.dart';
import '../models/fixture.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RoleComponent extends StatelessWidget {
  final Role role;

  RoleComponent({this.role});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          key: Key(role.name.toString()),
          child: Text(role.name.toString()),
        ),
        IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              BlocProvider.of<RoleBloc>(context, listen: false)
                ..add(DeleteRoleEvent(RoleId: role.id.toString()));
              Navigator.of(context).pushNamed(AdminRoleScreen.routeName);
            })
      ],
    ));
  }
}
