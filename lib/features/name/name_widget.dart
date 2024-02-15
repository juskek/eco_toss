import 'package:eco_toss/features/name/name_viewmodel.dart';
import 'package:eco_toss/pages/settings/custom_name_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final nameViewModel = context.watch<NameViewModel>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showCustomNameDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Name',
            ),
            const Spacer(),
            FutureBuilder(
              future: nameViewModel.playerName,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Text(
                    '${snapshot.data}',
                  );
                }
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
