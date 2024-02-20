import 'package:eco_toss/atomic/atoms/dialog_atom.dart';
import 'package:eco_toss/atomic/atoms/padding_atom.dart';
import 'package:eco_toss/features/name/name_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void showNameDialog(BuildContext context) async {
  showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          NameDialog(animation: animation));
}

class NameDialog extends StatefulWidget {
  final Animation<double> animation;

  const NameDialog({required this.animation, super.key});

  @override
  State<NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameViewModel = context.watch<NameViewModel>();
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: widget.animation,
        curve: Curves.easeOutCubic,
      ),
      child: Material(
        color: Colors.transparent,
        child: DialogAtom(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Change name',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              PaddingAtom(
                child: FutureBuilder<String>(
                  future: nameViewModel.playerName,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      _controller.text = snapshot.data ?? '';

                      return TextField(
                        controller: _controller,
                        autofocus: true,
                        maxLength: 24,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.done,
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonal(
                    child: const Text(
                      'Save',
                    ),
                    onPressed: () {
                      nameViewModel.setPlayerName(_controller.value.text);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
