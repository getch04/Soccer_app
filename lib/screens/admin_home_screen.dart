import 'package:flutter/material.dart';
import 'package:soccer_app/models/model.dart';
import 'package:soccer_app/screens/change_password_screen.dart';
import 'package:soccer_app/screens/user_delete_account.dart';
import 'package:soccer_app/util/util.dart';
import '../widgets/app_drawer_admin.dart';
import 'admin_fixtures_screen.dart';
import 'admin_results_screen.dart';
import 'admin_add_schedule.dart';
import 'change_username_screen.dart';
import 'route.dart';

class AdminHome extends StatefulWidget {
  static const routeName = 'admin_home';

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        key: Key("float_button"),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            FixtureAddUpdate.routeName,
            arguments: FixtureRoutArgs(edit: false),
          );
        },
      ),
      appBar: AppBar(
        title: Text('Soccer'),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (ctx) => [
                    PopupMenuItem(
                      child: TextButton(
                        child: Text('Change Password'),
                        onPressed: () async {
                          Util util = new Util();
                          User user = await util.getUserInformation();
                          Navigator.pop(ctx);
                          Navigator.of(context).pushNamed(
                              PasswordChangeScreen.routeName,
                              arguments: user);
                        },
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: TextButton(
                        child: Text('Change Username'),
                        onPressed: () async {
                          Util util = new Util();
                          User user = await util.getUserInformation();
                          Navigator.pop(ctx);
                          Navigator.of(context).pushNamed(
                              UsernameChangeScreen.routeName,
                              arguments: user);
                        },
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: TextButton(
                        child: Text('Delete Account'),
                        onPressed: () async {
                          Navigator.pop(ctx);
                          Navigator.of(context).pushNamed(
                            DeleteAccountPage.routeName,
                          );
                        },
                      ),
                      value: 3,
                    ),
                  ]),

          // IconButton(
          //     key: Key("fix_add"),
          //     icon: Icon(Icons.add),
          //     onPressed: () {
          //       Navigator.of(context).pushNamed(
          //         FixtureAddUpdate.routeName,
          //         arguments: FixtureRoutArgs(edit: false),
          //       );
          //     })
        ],
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(
              text: "Fixtures",
            ),
            Tab(
              text: "Result",
            )
          ],
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        key: Key('container'),
        child: TabBarView(controller: controller, children: <Widget>[
          AdminFixturesScreen(
            scaffoldKey: scaffoldKey,
          ),
          AdminResultsScreen(
            scaffoldKey: scaffoldKey,
          )
        ]),
      ),
    );
  }
}
