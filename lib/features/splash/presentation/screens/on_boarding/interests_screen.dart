import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttproj/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:ttproj/features/splash/presentation/widget/interestes_button.dart';
import '../../../../../core/routes/navigation_helper.dart';
import '../../../../../core/widget/app_button.dart';
import '../../../../../utility.dart';
import '../../widget/interests_title.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() =>
      _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            left: 26.5,
            right: 26.5,
            top: 151.5,
            bottom: 92.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InterestsTitle(),
              Expanded(child: InterestesButton()),
              addVertical(34),
              //! Edit latter
              AppButton(
                button: TextButton(
                  onPressed: () {
                    NavigationHelper.goToAuth(context);
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
