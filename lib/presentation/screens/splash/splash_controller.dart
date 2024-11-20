import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/routes/app_paths.dart';
import 'package:nutri_teca/presentation/screens/splash/bloc/splash_bloc.dart';
import 'package:nutri_teca/presentation/screens/splash/bloc/splash_state.dart';
import 'package:nutri_teca/presentation/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class SplashController extends StatelessWidget {
  const SplashController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.splashed) {
            if (state.userId != null && state.userId != '') {
              context.go(AppRoutesPath.home);
            } else {
              context.go(AppRoutesPath.login);
            }
          }
        },
        builder: (context, state) => const SplashScreen());
  }
}
