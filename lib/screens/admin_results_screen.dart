import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/result/result.dart';
import '../widgets/result_comp_admin.dart';
import 'splash_screen.dart';

class AdminResultsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  AdminResultsScreen({@required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResultsBloc, ResultStates>(
      listener: (_, state) {
        if (state is ResultDeletingState) {
          scaffoldKey.currentState.removeCurrentSnackBar();
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Deleting result.....'),
          ));
        }
        if (state is ResultDeletedState) {
          scaffoldKey.currentState.removeCurrentSnackBar();
          BlocProvider.of<ResultsBloc>(context, listen: false)
              .add(GetResultsEvent());
        }
        if (state is ResultsDeletingErrorState) {
          scaffoldKey.currentState.removeCurrentSnackBar();
          scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Result Deleting error'),
              duration: Duration(
                seconds: 5,
              )));
        }
      },
      builder: (_, state) {
        if (state is ResultsFetchingState) {
          return SplashScreen(title: 'Fetching Results');
        } else if (state is ResultsFetchedState) {
          final results = state.results;

          return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: results.length,
              itemBuilder: (_, idx) =>
                  ResultComponentAdmin(result: results[idx]));
        } else if (state is ResultsEmptyState) {
          return SplashScreen(title: 'No Recent Results');
        }

        return SplashScreen(title: 'Failed to load results');
      },
    );
  }
}
