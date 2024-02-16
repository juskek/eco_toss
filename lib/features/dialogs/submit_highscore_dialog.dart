import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/score/i_score_repository.dart';
import 'package:eco_toss/features/name/name_widget.dart';
import 'package:nes_ui/nes_ui.dart';

import '../../atomic/palette.dart';

class SubmitHighScoreDialog extends StatelessWidget {
  const SubmitHighScoreDialog({
    required this.onSubmit,
    required this.onCancel,
    super.key,
  });

  final void Function()? onSubmit;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();

    return Center(
      child: NesContainer(
        width: 420,
        height: 400,
        backgroundColor: palette.backgroundPlaySession.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "New Highscore!",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "Would you like to submit your highscore to the leaderboard?",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const NameWidget(),
            const SizedBox(height: 16),
            FutureBuilder(
              future: getIt<IScoreRepository>().highScore,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Text(
                    "Highscore: ${snapshot.data}",
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 16),
            NesButton(
              onPressed: onSubmit,
              type: NesButtonType.primary,
              child: const Text("Submit to Leaderboard"),
            ),
            NesButton(
              onPressed: onCancel,
              type: NesButtonType.normal,
              child: const Text("No thanks"),
            ),
          ],
        ),
      ),
    );
  }
}
