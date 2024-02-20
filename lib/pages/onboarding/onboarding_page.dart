import 'package:eco_toss/atomic/atoms/padding_atom.dart';
import 'package:eco_toss/data/new_user/i_new_user_repository.dart';
import 'package:eco_toss/features/name/name_widget.dart';
import 'package:eco_toss/ioc/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's get you set up!"),
      ),
      body: Center(
        child: PaddingAtom(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: const [
                    _gap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Enter your name:'),
                        NameWidget(),
                      ],
                    ),
                  ],
                ),
              ),
              _gap,
              FilledButton(
                onPressed: () {
                  getIt<INewUserRepository>().setHasOnboarded(true);
                  context.go('/');
                },
                child: const Text('Continue'),
              ),
              _gap,
            ],
          ),
        ),
      ),
    );
  }
}
