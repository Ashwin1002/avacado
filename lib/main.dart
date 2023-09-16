import 'package:avacado_task/common/theme/theme.dart';
import 'package:avacado_task/src/home/bloc/home_bloc.dart';
import 'package:avacado_task/src/home/repository/home_repository.dart';
import 'package:avacado_task/src/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HomeRepository(),
      child: BlocProvider(
        create: (context) => HomeBloc(
          repository: RepositoryProvider.of(context),
        )..add(FetchPostListEvent()),
        child: MaterialApp(
          title: 'Avacado Task',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
