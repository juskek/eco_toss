import 'package:eco_toss/features/name/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../atomic/palette.dart';
import 'settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundSettings.color,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: ListView(
                  children: [
                    _gap,
                    const Text(
                      'Settings',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Press Start 2P',
                        fontSize: 30,
                        height: 1,
                      ),
                    ),
                    _gap,
                    const NameWidget(),
                    ValueListenableBuilder<bool>(
                      valueListenable: settings.soundsOn,
                      builder: (context, soundsOn, child) => _SettingsLine(
                        'Sound FX',
                        Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
                        onSelected: () => settings.toggleSoundsOn(),
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: settings.musicOn,
                      builder: (context, musicOn, child) => _SettingsLine(
                        'Music',
                        Icon(musicOn ? Icons.music_note : Icons.music_off),
                        onSelected: () => settings.toggleMusicOn(),
                      ),
                    ),
                    _gap,
                    const Text('Credits'),
                    const Text(
                        '''Meadow Waltz by Keys of Moon | https://soundcloud.com/keysofmoon
Music promoted by https://www.free-stock-music.com
Creative Commons / Attribution 4.0 International (CC BY 4.0)
https://creativecommons.org/licenses/by/4.0/
''')
                  ],
                ),
              ),
            ),
            _gap,
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text('Back'),
            ),
            _gap,
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
