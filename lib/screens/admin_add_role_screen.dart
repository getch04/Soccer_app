import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/blocs/Role/role.dart';
import 'package:soccer_app/blocs/result/result.dart';
import '../models/model.dart';
import '../blocs/club/club.dart';
import '../blocs/fixture/fixture.dart';
import 'route.dart';
import 'admin_role_screen.dart';

class RoleAdd extends StatefulWidget {
  static const routeName = "admin_add_role";

  @override
  RoleAddState createState() {
    return RoleAddState();
  }
}

class RoleAddState extends State<RoleAdd> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  final _stadiumNameFocusNode = FocusNode();

  @override
  void dispose() {
    _stadiumNameFocusNode.dispose();

    super.dispose();
  }

  final Map<String, dynamic> _roles = {};

  Role role = Role();
  String name;

  bool isInit = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopPressed,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Add Role"),
        ),
        body: BlocConsumer<RoleBloc, RoleStates>(
          listener: (cotext, state) {
            if (state is RolePostingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is RolePostingErrorState) {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text('Error Adding the Role')));
            }
            if (state is RolePostedState) {
              BlocProvider.of<RoleBloc>(context).add(GetRoleEvent());
              Navigator.pop(context);
            }
          },
          builder: (cotext, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextFormField(
                        key: Key("role_field"),
                        initialValue: '',
                        validator: (value) {
                          if (value.isEmpty || value.length < 3) {
                            return 'Please Enter Role Name';
                          }
                          return null;
                        },
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Role name',
                          hintText: 'Enter role name',
                        ),
                        onSaved: (value) {
                          setState(() {
                            this._roles["name"] = value;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton.icon(
                      key: Key("add_role_Button"),
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          role = Role(
                            name: _roles["name"],
                          );
                          BlocProvider.of<RoleBloc>(context, listen: false)
                            ..add(PostRoleEvent(role: role));
                        }
                      },
                      label: Text('ADD'),
                      icon: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _willPopPressed() async {
    BlocProvider.of<RoleBloc>(context).add(GetRoleEvent());
    Navigator.of(context).pop();
    return true;
  }
}
