import 'package:eco_toss/atomic/atoms/dialog_atom.dart';
import 'package:eco_toss/atomic/atoms/spacer_atom.dart';
import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/score/i_score_repository.dart';
import 'package:eco_toss/features/name/name_widget.dart';

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
    return DialogAtom(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "New Highscore!",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SpacerAtom.medium(),
          const Text(
            "Would you like to submit your highscore to the leaderboard?",
            textAlign: TextAlign.center,
          ),
          const SpacerAtom.medium(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const NameWidget(),
              FutureBuilder(
                future: getIt<IScoreRepository>().highScore,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Text(
                      "Score: ${snapshot.data}",
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
          const SpacerAtom.medium(),
          const SpacerAtom.medium(),
          FilledButton(
            onPressed: onSubmit,
            child: const Text("Submit to Leaderboard"),
          ),
          FilledButton.tonal(
            onPressed: onCancel,
            child: const Text("No thanks"),
          ),
        ],
      ),
    );
  }
}
