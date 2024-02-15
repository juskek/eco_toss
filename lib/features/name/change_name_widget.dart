import 'package:eco_toss/pages/settings/custom_name_dialog.dart';
import 'package:flutter/material.dart';

class ChangeNameWidget extends StatelessWidget {
  const ChangeNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final settings = context.watch<SettingsController>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showCustomNameDialog(context),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('test',
                style: TextStyle(
                  fontFamily: 'Press Start 2P',
                  fontSize: 20,
                )),
            Spacer(),
            Text('player name'),
            // ValueListenableBuilder(
            //   valueListenable: settings.playerName,
            //   builder: (context, name, child) => Text(
            //     '‘$name’',
            //     style: const TextStyle(
            //       fontFamily: 'Press Start 2P',
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _SettingsLine extends StatelessWidget {
  final String title;

  final Widget icon;

  final VoidCallback? onSelected;

  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Press Start 2P',
                  fontSize: 20,
                ),
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
