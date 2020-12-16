import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papua_tourism/bloc/auth_bloc/authentication_bloc.dart';
import 'package:papua_tourism/model/tourism_model.dart';
import 'package:papua_tourism/repository/tourism_repository.dart';
import 'package:papua_tourism/repository/user_repository.dart';
import 'package:papua_tourism/res/size_config.dart';
import 'package:papua_tourism/res/styling.dart';
import 'package:papua_tourism/ui/screens/home_page.dart';
import 'package:papua_tourism/ui/screens/signin_screen.dart';
import 'package:papua_tourism/ui/screens/welcome_screen.dart';

import 'bloc/tourism_bloc/tourism_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Learning Platform Application',
              theme: AppTheme.lightTheme,
              home: BlocProvider(
                create: (context) => AuthenticationBloc(UserRepositoryImpl()),
                child: SignInScreen(),
              ),
              // home: SignInScreen(),
            );
          },
        );
      },
    );
  }

  // home: BlocProvider(
  //   create: (context) => TourismBloc(TourismRepositoryImpl()),
  //   child: HomePage(),
  // ),
}
