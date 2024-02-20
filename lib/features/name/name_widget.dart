import 'package:eco_toss/features/name/name_dialog.dart';
import 'package:eco_toss/features/name/name_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final nameViewModel = context.watch<NameViewModel>();

    return FilledButton.tonal(
      onPressed: () => showNameDialog(context),
      child: Selector<NameViewModel, Future<String>>(
        selector: (context, viewModel) async => await viewModel.playerName,
        builder: (context, value, child) {
          return FutureBuilder(
            future: nameViewModel.playerName,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Text(
                  '${snapshot.data}',
                  style: const TextStyle(decoration: TextDecoration.underline),
                );
              }
              return const CircularProgressIndicator();
            },
          );
        },
      ),
    );
  }
}
