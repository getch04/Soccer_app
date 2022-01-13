import 'package:flutter_test/flutter_test.dart';
import 'package:soccer_app/blocs/auth/auth.dart';
import 'package:soccer_app/blocs/club/club.dart';
import 'package:soccer_app/blocs/fixture/fixture.dart';
import 'package:soccer_app/blocs/result/result.dart';
import 'package:soccer_app/blocs/user/user.dart';
import 'package:soccer_app/blocs/user/user_bloc.dart';
import 'package:soccer_app/models/club.dart';
import 'package:soccer_app/models/fixture.dart';
import 'package:soccer_app/models/model.dart';
import 'package:soccer_app/models/user.dart';
import 'package:soccer_app/repository/repository.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockResultRepository extends Mock implements ResultRepository {}

class MockFixtureRepository extends Mock implements FixtureRepository {}

class MockClubRepository extends Mock implements ClubRepository {}

void main() {
  final Role rol = Role(
    id: 1,
    name: "solomon",
  );
  final User user1 = User.fullInfo(
    fullName: "solomon kindie",
    email: "solomon@gmail.com",
    password: "3463",
    phone: "0943550992",
    role: rol,
    roleId: 1,
  );

  final Club club1 = Club(
    id: 1,
    name: "manchester united",
  );
  final Club club2 = Club(
    id: 2,
    name: "arsenal",
  );

  final Fixture fixture = Fixture(
    id: 1,
    startingDate: DateTime.now(),
    clubs: [club1, club2],
    stadiumLatitude: 29.0,
    stadiumLongitude: 34.0,
    stadiumName: "oldtraford",
  );

  final Scorer scorer1 = Scorer(
    id: 1,
    resultID: 2,
    scorerName: "Fernandese",
    scoringMinute: 80,
    clubId: 1,
    club: club1,
  );

  final Result result = Result(
      id: 1,
      fixtureId: 2,
      fixture: fixture,
      firstClubScore: 2,
      secondClubScore: 3,
      scorers: [scorer1]);

  List<Club> clubs = [club1, club2];
  List<Fixture> fixtures = [fixture];
  List<Result> results = [result];
  List<Scorer> scorers = [scorer1];
  List<User> usersLst = [user1];

  //testing of club
  group('ClubsBloc', () {
    MockClubRepository mockClubRepository;
    ClubsBloc clubsBloc;

    setUp(() {
      mockClubRepository = MockClubRepository();
      clubsBloc = ClubsBloc(clubsRepository: mockClubRepository);
    });

    tearDown(() {
      clubsBloc?.close();
    });


    group("Getting Clubs", () {
      test("fetching and fetched state of club", () {
        when(mockClubRepository.getAndSetClubs()).thenAnswer(
                (_) async => Future.value(clubs));

        final bloc = ClubsBloc(clubsRepository: mockClubRepository);

        bloc.add(GetClubsEvent());

        emitsExactly(bloc, [
          ClubsFetchingState(),
          ClubFetchedState(clubs: clubs),
        ]);
        return clubsBloc;
      });

      test("getting club error checking", () {
        when(mockClubRepository.getAndSetClubs()).thenThrow("club error");

        final bloc = ClubsBloc(clubsRepository: mockClubRepository);

        bloc.add(GetClubsEvent());

        emitsExactly(bloc, [
          ClubsFetchingState(),
          ClubsFetchingErrorState(),
        ]);
        return clubsBloc;
      });
    });


    group("Posting CLubs", () {
      test("fixture posting and fixture posted state", () {
        when(mockClubRepository.postClub(club1));

        final bloc = ClubsBloc(clubsRepository: mockClubRepository);
        bloc.add(PostClubEvent(club: club1));
        emitsExactly(bloc, [

          ClubPostingState(),
          ClubPostedState(),
        ]
        );
      });

      test("posting club error checking", () {
        when(mockClubRepository.postClub(club1)).thenThrow(
            "club posting error");

        final bloc = ClubsBloc(clubsRepository: mockClubRepository);

        bloc.add(PostClubEvent(club: club1));

        emitsExactly(bloc, [
          ClubPostingState(),
          ClubPostingErrorState(),
        ]);
        return clubsBloc;
      });
    });


    group("updating Clubs", () {
      test("clubs updating and clubs updated state", () {
        when(mockClubRepository.putClub(club1));
        final bloc = ClubsBloc(clubsRepository: mockClubRepository);
        bloc.add(UpdateClubEvent(club: club1));
        emitsExactly(bloc, [

          ClubUpdatingState(),
          ClubUpdatedState(),
        ]
        );
      });
    });

    test("updating club error checking", () {
      when(mockClubRepository.putClub(club1)).thenThrow("club updating error");

      final bloc = ClubsBloc(clubsRepository: mockClubRepository);

      bloc.add(UpdateClubEvent(club: club1));

      emitsExactly(bloc, [
        ClubUpdatingState(),
        ClubUpdatingErrorState(),
      ]);
      return clubsBloc;
    });

    group("deleting CLubs", () {
      test("clubs deleting and clubs deleted state", () {
        when(mockClubRepository.deleteClub("1"));
        final bloc = ClubsBloc(clubsRepository: mockClubRepository);
        bloc.add(DeleteClubEvent(clubId: "1"));
        emitsExactly(bloc, [

          ClubDeletingState(),
          ClubDeletedState(),
        ]
        );
      });
    });

    test("posting club error checking", () {
      when(mockClubRepository.deleteClub("1")).thenThrow("club error");

      final bloc = ClubsBloc(clubsRepository: mockClubRepository);

      bloc.add(DeleteClubEvent(clubId: "1"));

      emitsExactly(bloc, [
        ClubDeletingState(),
        ClubsDeletingErrorState(),
      ]);
      return clubsBloc;
    });
  });


// testing for fixtures
  group('FixturesBloc', () {
    MockFixtureRepository mockFixtureRepository;
    FixturesBloc fixturesBloc;

    setUp(() {
      mockFixtureRepository = MockFixtureRepository();
      fixturesBloc = FixturesBloc(fixturesRepository: mockFixtureRepository);
    });

    tearDown(() {
      fixturesBloc?.close();
    });

//get fixture
    group("Getting Fixture", () {
      test("fetching and fetched state of fixture ", () {
        when(mockFixtureRepository.getAndSetFixtures()).thenAnswer(
                (_) async => Future.value(fixtures));

        final bloc = FixturesBloc(fixturesRepository: mockFixtureRepository);

        bloc.add(GetFixturesEvent());

        emitsExactly(bloc, [
          FixturesFetchingState(),
          FixturesFetchedState(fixtures: fixtures),
        ]);
        print("succes");
        return fixturesBloc;
      },
      );
    });
//testing error state
    test("getting fixture error checking", () {
      when(mockFixtureRepository.getAndSetFixtures()).thenThrow(
          "fixture getting error");

      final bloc = FixturesBloc(fixturesRepository: mockFixtureRepository);

      bloc.add(PostFixtureEvent(fixture: fixture));

      emitsExactly(bloc, [
        FixturesFetchingState(),
        FixturesFetchingErrorState(),
      ]);
      return fixturesBloc;
    });

//posting fixture
  group("Posting Fixtures", () {
      test("fixture posting and fixture posted state", () {
        when(mockFixtureRepository.postFixture(fixture));
        final bloc = FixturesBloc(fixturesRepository: mockFixtureRepository);
        bloc.add(PostFixtureEvent(fixture: fixture));
        emitsExactly(bloc, [

          FixturePostingState(),
          FixturePostedState(),
        ]
        );
      });
        //post fixture error state
      test("posting fixture error checking", () {
        when(mockFixtureRepository.postFixture(fixture)).thenThrow(
            "club posting error");

        final bloc = FixturesBloc(fixturesRepository: mockFixtureRepository);

        bloc.add(PostFixtureEvent(fixture: fixture));

        emitsExactly(bloc, [
          FixturePostingState(),
          FixturePostingErrorState(),
        ]);
        return fixture;
      });
  });

  //updating error state
    group("updating Fixtures", () {
      test("fixture updating and fixture updated state", () {
        when(mockFixtureRepository.putFixture(fixture));
        final bloc = FixturesBloc(fixturesRepository: mockFixtureRepository);
        bloc.add(UpdateFixtureEvent(fixture: fixture));
        emitsExactly(bloc, [

          FixtureUpdatingState(),
          FixtureUpdatedState(),
        ]
        );
      });

      //testing  updating error state
      test("updating fixture error checking", () {
        when(mockFixtureRepository.getAndSetFixtures()).thenThrow(
            "fixture updating error");

        final bloc = FixturesBloc(fixturesRepository: mockFixtureRepository);

        bloc.add(UpdateFixtureEvent(fixture: fixture));

        emitsExactly(bloc, [
          FixtureUpdatingState(),
          FixtureUpdatingErrorState(),
        ]);
        return fixturesBloc;
      });

    });

//test deleting fixture
    group("deleting Fixtures", () {
      test("fixture deleting and fixture deleted state", () {
        when(mockFixtureRepository.deleteFixture("1"));
        final bloc = FixturesBloc(fixturesRepository: mockFixtureRepository);
        bloc.add(DeleteFixtureEvent(fixtureId: "1"));
        emitsExactly(bloc, [

          FixtureDeletingState(),
          FixtureDeletedState(),
        ]
        );
      });
      //testing error state
      test("deleting fixture error checking", () {
        when(mockFixtureRepository.deleteFixture("1")).thenThrow(
            "fixture deleting error");

        final bloc = FixturesBloc(fixturesRepository: mockFixtureRepository);

        bloc.add(DeleteFixtureEvent(fixtureId: "1"));

        emitsExactly(bloc, [
          FixtureDeletingState(),
          FixturesDeletingErrorState(),
        ]);
        return fixturesBloc;
      });

    });
  });

// result testing

  group("ResultsBloc", () {
    MockResultRepository mockResultRepository;
    ResultsBloc resultBloc;

    setUp(() {
      mockResultRepository = MockResultRepository();
      resultBloc = ResultsBloc(resultRepository: mockResultRepository);
    });

    tearDown(() {
      resultBloc?.close();
    });

    group("Getting Results", () {
      test("fetching and fetched state of result ", () {
        when(mockResultRepository.getAndSetResults()).thenAnswer(
                (_) async => Future.value(results));

        final bloc = ResultsBloc(resultRepository: mockResultRepository);

        bloc.add(GetResultsEvent());

        emitsExactly(bloc, [
          ResultsFetchingState(),
          ResultsFetchedState(results: results),
        ]);
        print("succes");
        return resultBloc;
      },
      );

      //testing error state
      test("getting result error checking", () {
        when(mockResultRepository.getAndSetResults()).thenThrow(
            "fixture getting error");

        final bloc = ResultsBloc(resultRepository: mockResultRepository);

        bloc.add(GetResultsEvent());

        emitsExactly(bloc, [
          ResultsFetchingState(),
          ResultsFetchedState(results: results),
        ]);
        return resultBloc;
      });
    });
       //test posting result
    group("Posting Results", () {
      test("Posting the result", () {
        when(mockResultRepository.postResult(result));

        final bloc = ResultsBloc(resultRepository: mockResultRepository);
        bloc.add(PostResultEvent(result: result));
        emitsExactly(bloc, [
          ResultPostingState(),
          ResultPostedState(),

        ]);

        return resultBloc;
      });
      //post fixture error state
      test("posting fixture error checking", () {
        when(mockResultRepository.postResult(result)).thenThrow(
            "result posting error");

        final bloc = ResultsBloc(resultRepository: mockResultRepository);

        bloc.add(PostResultEvent(result: result));

        emitsExactly(bloc, [
          ResultPostingState(),
          ResultPostingErrorState(),
        ]);
        return resultBloc;
      });
    });
   //updating result error state
    group("Updating Results", () {
      test("updating the result", () {
        when(mockResultRepository.putResult(result));
        final bloc = ResultsBloc(resultRepository: mockResultRepository);
        bloc.add(UpdateResultEvent(result: result));
        emitsExactly(bloc, [

          ResultUpdatingState(),
          ResultUpdatedState(),
        ]);

        return resultBloc;
      });
      //testing  updating error state  of results
      test("updating result error checking", () {
        when(mockResultRepository.putResult(result)).thenThrow(
            "result updating error");

        final bloc = ResultsBloc(resultRepository: mockResultRepository);

        bloc.add(UpdateResultEvent(result: result));

        emitsExactly(bloc, [
          ResultUpdatingState(),
          ResultUpdatingErrorState(),
        ]);
        return resultBloc;
      });
    });

    // test result posting
    group("Deleting Results", () {
      test("Deleting the results", () {
        when(mockResultRepository.deleteResult("1"));

        final bloc = ResultsBloc(resultRepository: mockResultRepository);
        bloc.add(DeleteResultEvent(resultId: "1"));
        emitsExactly(bloc, [

          ResultDeletingState(),
          ResultDeletedState(),
        ]);

        return resultBloc;
      });

      //testing error state of deleting
      test("deleting result error checking", () {
        when(mockResultRepository.deleteResult("1")).thenThrow(
            "result deleting error");

        final bloc = ResultsBloc(resultRepository: mockResultRepository);

        bloc.add(DeleteResultEvent(resultId: "1"));

        emitsExactly(bloc, [
          ResultDeletingState(),
          ResultsDeletingErrorState(),
        ]);
        return resultBloc;
      });

    });
  });
// testing users bloc functionality
  group("usersBloc", () {
    MockUserRepository mockUserRepository;
    UserBloc userBloc;

    setUp(() {
      mockUserRepository = MockUserRepository();
      userBloc = UserBloc(userRepository: mockUserRepository);
    });

    tearDown(() {
      userBloc?.close();
    });
//getting users
    group("Getting users", () {
      test("fetching and fetched state of users", () {
        when(mockUserRepository.getUsers())
            .thenAnswer((_) async => Future.value(usersLst));

        final bloc = UserBloc(userRepository: mockUserRepository);
        bloc.add(GetUsersEvent());
        emitsExactly(bloc, [
          UsersFetchingState(),
          UsersFetchedState(users: usersLst),
        ]);
      });
//  user getting error testing
        test("fetching and fetched sate errors of user", () {
          when(mockUserRepository.getUsers()).thenAnswer(
                  (_) async=> Future.value(usersLst));
      
          final bloc = UserBloc(userRepository: mockUserRepository);
          bloc.add(GetUsersEvent());
          emitsExactly(bloc, [
      
            UsersFetchingErrorState(),
          ]);
          return userBloc;
      
        });
      //
    });
  });
}
