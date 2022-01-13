import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:soccer_app/blocs/user/user.dart';
import 'package:soccer_app/blocs/user/user_bloc.dart';
import 'package:soccer_app/repository/role_repository.dart';
import 'package:soccer_app/screens/admin_add_role_screen.dart';
import 'package:soccer_app/data_provider/data.dart';
import 'package:soccer_app/repository/repository.dart';
import 'package:soccer_app/blocs/auth/auth.dart';
import 'package:soccer_app/blocs/fixture/fixture.dart';
import 'package:soccer_app/blocs/result/result.dart';
import 'package:soccer_app/blocs/club/club.dart';
import 'package:soccer_app/blocs/Role/role.dart';
import 'package:soccer_app/screens/admin_home_screen.dart';
import 'package:soccer_app/screens/login_screen.dart';
import 'package:soccer_app/screens/route.dart';
import 'package:soccer_app/bloc_observer.dart';
import 'package:soccer_app/screens/user_home_screen.dart';
import 'package:soccer_app/util/util.dart';
import 'package:http/http.dart' as http;
import 'package:soccer_app/repository/user_repository.dart';

class Cos {
  UserRepository userRepository = UserRepository(
      userDataProvider: UserDataProvider(httpClient: http.Client()));
  ClubRepository clubRepository = ClubRepository(
      clubDataProvider: ClubDataProvider(httpClient: http.Client()));
  FixtureRepository fixtureRepository = FixtureRepository(
      fixtureDataProvider: FixtureDataProvider(httpClient: http.Client()));
  ResultRepository resultRepository = ResultRepository(
      resultDataProvider: ResultDataProvider(httpClient: http.Client()));
  RoleRepository roleRepository = RoleRepository(
      roleDataProvider: RoleDataProvider(httpClient: http.Client()));
}

void main() {
  Cos _provider = Cos();
  testWidgets("login_test", (WidgetTester tester) async {
    await tester.pumpWidget(MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (_) => _provider.userRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(
                  userRepository: _provider.userRepository, util: Util())
                ..add(AutoLoginEvent()),
            ),

            ////////ROLE Added
            BlocProvider<RoleBloc>(
              create: (_) => RoleBloc(roleRepository: _provider.roleRepository)
                ..add(GetRoleEvent()),
            ),
            BlocProvider<UserBloc>(
              create: (_) => UserBloc(userRepository: _provider.userRepository)
                ..add(GetUsersEvent()),
            ),
          ],
          child: MaterialApp(
            home: LoginScreen(),
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        )));
    await tester.pumpAndSettle(Duration(seconds: 30));

    var textFieldEmail = find.byKey(Key('email_login'));
    var textFieldPassword = find.byKey(Key('password_login'));
    var loginButton = find.byKey(Key('login_button'));
    expect(textFieldEmail, findsOneWidget);
    expect(textFieldPassword, findsOneWidget);
    expect(loginButton, findsOneWidget);

    await tester.enterText(textFieldEmail, 'di@email.com');
    await tester.enterText(textFieldPassword, '123456');
    await tester.tap(loginButton);
    await tester.pumpAndSettle(Duration(seconds: 30));
    // expect(find.byKey(Key('container')), findsNothing);
  });

  /////////////

  testWidgets("admin_homepage_test", (WidgetTester tester) async {
    await tester.pumpWidget(MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (_) => _provider.userRepository,
          ),
          RepositoryProvider<ClubRepository>(
            create: (_) => _provider.clubRepository,
          ),
          RepositoryProvider<FixtureRepository>(
            create: (_) => _provider.fixtureRepository,
          ),
          RepositoryProvider<ResultRepository>(
            create: (_) => _provider.resultRepository,
          ),
          RepositoryProvider<RoleRepository>(
              create: (_) => _provider.roleRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(
                  userRepository: _provider.userRepository, util: Util())
                ..add(AutoLoginEvent()),
            ),
            BlocProvider<ClubsBloc>(
              create: (_) =>
                  ClubsBloc(clubsRepository: _provider.clubRepository)
                    ..add(
                      GetClubsEvent(),
                    ),
            ),
            BlocProvider<FixturesBloc>(
              create: (_) =>
                  FixturesBloc(fixturesRepository: _provider.fixtureRepository)
                    ..add(
                      GetFixturesEvent(),
                    ),
            ),
            BlocProvider<ResultsBloc>(
              create: (_) =>
                  ResultsBloc(resultRepository: _provider.resultRepository)
                    ..add(GetResultsEvent()),
            ),
            ////////ROLE Added
            BlocProvider<RoleBloc>(
              create: (_) => RoleBloc(roleRepository: _provider.roleRepository)
                ..add(GetRoleEvent()),
            ),
            BlocProvider<UserBloc>(
              create: (_) => UserBloc(userRepository: _provider.userRepository)
                ..add(GetUsersEvent()),
            ),
          ],
          child: MaterialApp(
            home: AdminHome(),
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        )));
    await tester.pump();
    // var icon_add = find.byKey(Key('fix_add'));
    //
    // expect(icon_add, findsOneWidget);
    // await tester.tap(icon_add);
    expect(find.byKey(Key('float_button')), findsOneWidget);
    expect(find.text('Fixtures'), findsOneWidget);
    expect(find.text('Result'), findsOneWidget);

    await tester.pump();
  });

  testWidgets("user_homepage_test", (WidgetTester tester) async {
    await tester.pumpWidget(MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (_) => _provider.userRepository,
          ),
          RepositoryProvider<ClubRepository>(
            create: (_) => _provider.clubRepository,
          ),
          RepositoryProvider<FixtureRepository>(
            create: (_) => _provider.fixtureRepository,
          ),
          RepositoryProvider<ResultRepository>(
            create: (_) => _provider.resultRepository,
          ),
          RepositoryProvider<RoleRepository>(
              create: (_) => _provider.roleRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(
                  userRepository: _provider.userRepository, util: Util())
                ..add(AutoLoginEvent()),
            ),
            BlocProvider<ClubsBloc>(
              create: (_) =>
                  ClubsBloc(clubsRepository: _provider.clubRepository)
                    ..add(
                      GetClubsEvent(),
                    ),
            ),
            BlocProvider<FixturesBloc>(
              create: (_) =>
                  FixturesBloc(fixturesRepository: _provider.fixtureRepository)
                    ..add(
                      GetFixturesEvent(),
                    ),
            ),
            BlocProvider<ResultsBloc>(
              create: (_) =>
                  ResultsBloc(resultRepository: _provider.resultRepository)
                    ..add(GetResultsEvent()),
            ),
            ////////ROLE Added
            BlocProvider<RoleBloc>(
              create: (_) => RoleBloc(roleRepository: _provider.roleRepository)
                ..add(GetRoleEvent()),
            ),
            BlocProvider<UserBloc>(
              create: (_) => UserBloc(userRepository: _provider.userRepository)
                ..add(GetUsersEvent()),
            ),
          ],
          child: MaterialApp(
            home: UserHome(),
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        )));
    await tester.pump();
    // expect(find.byKey(Key('float_button')), findsOneWidget);
    expect(find.text('Fixtures'), findsOneWidget);
    expect(find.text('Result'), findsOneWidget);

    await tester.pump();
  });

  testWidgets("role_test", (WidgetTester tester) async {
    await tester.pumpWidget(MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (_) => _provider.userRepository,
          ),
          RepositoryProvider<ClubRepository>(
            create: (_) => _provider.clubRepository,
          ),
          RepositoryProvider<FixtureRepository>(
            create: (_) => _provider.fixtureRepository,
          ),
          RepositoryProvider<ResultRepository>(
            create: (_) => _provider.resultRepository,
          ),
          RepositoryProvider<RoleRepository>(
              create: (_) => _provider.roleRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(
                  userRepository: _provider.userRepository, util: Util())
                ..add(AutoLoginEvent()),
            ),
            BlocProvider<ClubsBloc>(
              create: (_) =>
                  ClubsBloc(clubsRepository: _provider.clubRepository)
                    ..add(
                      GetClubsEvent(),
                    ),
            ),
            BlocProvider<FixturesBloc>(
              create: (_) =>
                  FixturesBloc(fixturesRepository: _provider.fixtureRepository)
                    ..add(
                      GetFixturesEvent(),
                    ),
            ),
            BlocProvider<ResultsBloc>(
              create: (_) =>
                  ResultsBloc(resultRepository: _provider.resultRepository)
                    ..add(GetResultsEvent()),
            ),
            ////////ROLE Added
            BlocProvider<RoleBloc>(
              create: (_) => RoleBloc(roleRepository: _provider.roleRepository)
                ..add(GetRoleEvent()),
            ),
            BlocProvider<UserBloc>(
              create: (_) => UserBloc(userRepository: _provider.userRepository)
                ..add(GetUsersEvent()),
            ),
          ],
          child: MaterialApp(
            home: RoleAdd(),
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        )));
    await tester.pump();
    // expect(find.byKey(Key('float_button')), findsOneWidget);
    expect(find.byKey(Key('role_field')), findsOneWidget);
    expect(find.byKey(Key('add_role_Button')), findsOneWidget);
    await tester.pump();
  });
}
