import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/blocs/user/user.dart';
import 'package:soccer_app/blocs/user/user_bloc.dart';
import 'package:soccer_app/repository/role_repository.dart';
import 'package:soccer_app/screens/admin_fixtures_screen.dart';
import 'data_provider/data.dart';
import 'repository/repository.dart';
import 'blocs/auth/auth.dart';
import 'blocs/fixture/fixture.dart';
import 'blocs/result/result.dart';
import 'blocs/club/club.dart';
import 'blocs/Role/role.dart';
import 'screens/route.dart';
import 'bloc_observer.dart';
import 'util/util.dart';
import 'package:http/http.dart' as http;
import 'package:soccer_app/repository/user_repository.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

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

  runApp(SoccerApp(
    userRepository: userRepository,
    clubRepository: clubRepository,
    fixtureRepository: fixtureRepository,
    resultRepository: resultRepository,
    roleRepository: roleRepository,
  ));
}

class SoccerApp extends StatelessWidget {
  final UserRepository userRepository;
  final ClubRepository clubRepository;
  final FixtureRepository fixtureRepository;
  final ResultRepository resultRepository;
  final RoleRepository roleRepository;

  SoccerApp({
    @required this.roleRepository,
    @required this.userRepository,
    @required this.clubRepository,
    @required this.fixtureRepository,
    @required this.resultRepository,
  }) : assert(userRepository != null &&
            clubRepository != null &&
            fixtureRepository != null &&
            resultRepository != null &&
            roleRepository != null);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (_) => this.userRepository,
          ),
          RepositoryProvider<ClubRepository>(
            create: (_) => this.clubRepository,
          ),
          RepositoryProvider<FixtureRepository>(
            create: (_) => this.fixtureRepository,
          ),
          RepositoryProvider<ResultRepository>(
            create: (_) => this.resultRepository,
          ),
          RepositoryProvider<RoleRepository>(
              create: (_) => this.roleRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (_) =>
                  AuthBloc(userRepository: this.userRepository, util: Util())
                    ..add(AutoLoginEvent()),
            ),
            BlocProvider<ClubsBloc>(
              create: (_) => ClubsBloc(clubsRepository: this.clubRepository)
                ..add(
                  GetClubsEvent(),
                ),
            ),
            BlocProvider<FixturesBloc>(
              create: (_) =>
                  FixturesBloc(fixturesRepository: this.fixtureRepository)
                    ..add(
                      GetFixturesEvent(),
                    ),
            ),
            BlocProvider<ResultsBloc>(
              create: (_) =>
                  ResultsBloc(resultRepository: this.resultRepository)
                    ..add(GetResultsEvent()),
            ),
            ////////ROLE Added
            BlocProvider<RoleBloc>(
              create: (_) => RoleBloc(roleRepository: this.roleRepository)
                ..add(GetRoleEvent()),
            ),
            BlocProvider<UserBloc>(
              create: (_) => UserBloc(userRepository: this.userRepository)
                ..add(GetUsersEvent()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Soccer App',
            initialRoute: '/',
            onGenerateRoute: AppRoutes.generateRoute,
            theme: ThemeData(
                textTheme: TextTheme(
                  headline6: TextStyle(fontWeight: FontWeight.bold),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.pink[400],
                ),
                primaryColor: Colors.black,
                primaryTextTheme: TextTheme(
                  headline6: TextStyle(fontWeight: FontWeight.bold),
                  button: TextStyle(fontWeight: FontWeight.bold),
                ),
                accentColorBrightness: Brightness.dark,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  brightness: Brightness.dark,
                  color: Colors.pink[600],
                  elevation: 3.0,
                  iconTheme: IconThemeData(
                    size: 30,
                    color: Colors.white,
                  ),
                  textTheme: TextTheme(
                    headline6: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                )),
          ),
        ));
  }
}
