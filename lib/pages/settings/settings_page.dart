import 'package:eco_toss/atomic/atoms/padding_atom.dart';
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
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: PaddingAtom(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _gap,
                    Text('General',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const Divider(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Name:'),
                        NameWidget(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sound Effects:'),
                        ValueListenableBuilder<bool>(
                            valueListenable: settings.soundsOn,
                            builder: (context, soundsOn, child) =>
                                FilledButton.tonalIcon(
                                  onPressed: () => settings.toggleSoundsOn(),
                                  label: soundsOn
                                      ? const Text('On')
                                      : const Text('Muted'),
                                  icon: Icon(soundsOn
                                      ? Icons.graphic_eq
                                      : Icons.volume_off),
                                )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Music:'),
                        ValueListenableBuilder<bool>(
                            valueListenable: settings.musicOn,
                            builder: (context, musicOn, child) =>
                                FilledButton.tonalIcon(
                                  onPressed: () => settings.toggleMusicOn(),
                                  label: musicOn
                                      ? const Text('On')
                                      : const Text('Muted'),
                                  icon: Icon(musicOn
                                      ? Icons.graphic_eq
                                      : Icons.volume_off),
                                )),
                      ],
                    ),
                    _gap,
                    Text('Credits',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const Divider(),
                    const Text(
                        'Meadow Waltz by Keys of Moon | https://soundcloud.com/keysofmoon'),
                    const Text(
                        'Music promoted by https://www.free-stock-music.com'),
                    const Text(
                        'Creative Commons / Attribution 4.0 International (CC BY 4.0)'),
                    const Text('https://creativecommons.org/licenses/by/4.0/'),
                  ],
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
      ),
    );
  }
}
