import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:soccer_app/blocs/auth/auth.dart';
import 'package:soccer_app/util/util.dart';
import '../../repository/repository.dart';
import '../../models/user.dart';
import '../../models/http_exception.dart';
import '../../repository/user_repository.dart';
import 'user_states.dart';
import 'user_events.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  final UserRepository userRepository;

  UserBloc({@required this.userRepository}) : super(UserUninitializedState());

  @override
  Stream<UserStates> mapEventToState(UserEvents event) async* {
    if (event is GetUsersEvent) {
      yield* _mapGetUsersEventToState();
    } else if (event is UpdateUserEvent) {
      yield* _mapUpdateUserEventToState(event.user);
    } else if (event is UpdateUserPasswordEvent) {
      yield* _mapUpdatePasswordEventToState(event.user, event.oldPassword);
    } else if (event is DeleteUserEvent) {
      yield* _mapDeleteUserEventToState(event.userId);
    }
  }

  Stream<UserStates> _mapGetUsersEventToState() async* {
    yield UsersFetchingState();
    try {
      List<User> users = await userRepository.getUsers();
      if (users.length == 0) {
        yield UsersEmptyState();
      } else {
        yield UsersFetchedState(users: users);
      }
    } on HttpException catch (e) {
      yield UsersFetchingErrorState(message: e.message);
    } catch (e) {
      yield UsersFetchingErrorState();
    }
  }

  Stream<UserStates> _mapUpdateUserEventToState(User user) async* {
    yield UserUpdatingState();
    try {
      User userUpdated = await userRepository.updateUser(user);
      yield UserUpdatedState(user: userUpdated);
    } on HttpException catch (e) {
      yield UserUpdatingErrorState(message: e.message);
    } catch (e) {
      yield UserUpdatingErrorState();
    }
  }

  Stream<UserStates> _mapUpdatePasswordEventToState(
      User user, String oldPass) async* {
    yield UserUpdatingState();
    try {
      await userRepository.updateUserPassword(user, oldPass);
      yield UserUpdatedState();
    } on HttpException catch (e) {
      if (e.toString() == 'Incorrect Old Password') {
        yield UserIncorrectOldPasswordState();
      } else {
        yield UserUpdatingErrorState(message: e.message);
      }
    } catch (e) {
      yield UserUpdatingErrorState();
    }
  }

  Stream<UserStates> _mapDeleteUserEventToState(String userId) async* {
    yield UserDeletingState();
    try {
      await userRepository.deleteUser(userId);
      Util util = new Util();
      util.logOut();
      yield UserDeletedState();
    } on HttpException catch (e) {
      yield UserDeletingErrorState();
    } catch (e) {
      yield UserDeletingErrorState();
    }
  }
}
