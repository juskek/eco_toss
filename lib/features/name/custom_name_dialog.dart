import 'package:eco_toss/features/name/name_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void showCustomNameDialog(BuildContext context) async {
  final playerName = await context.read<NameViewModel>().playerName;
  showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          CustomNameDialog(animation: animation, playerName: playerName));
}

class CustomNameDialog extends StatefulWidget {
  final Animation<double> animation;
  final String playerName;

  const CustomNameDialog(
      {required this.animation, required this.playerName, super.key});

  @override
  State<CustomNameDialog> createState() => _CustomNameDialogState();
}

class _CustomNameDialogState extends State<CustomNameDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameViewModel = context.watch<NameViewModel>();
    _controller.text = widget.playerName;
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: widget.animation,
        curve: Curves.easeOutCubic,
      ),
      child: SimpleDialog(
        title: Center(
          child: Text(
            'Change name',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            maxLength: 12,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
          ),
          TextButton(
            onPressed: () {
              nameViewModel.setPlayerName(_controller.value.text);
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
