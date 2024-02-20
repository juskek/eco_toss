import 'package:eco_toss/atomic/atoms/eco_toss_logo_atom.dart';
import 'package:eco_toss/atomic/atoms/eco_toss_title_atom.dart';
import 'package:eco_toss/atomic/responsive_screen.dart';
import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/features/flame_game/game_implementations/home_page/background_only_game.dart';
import 'package:eco_toss/features/responsive.dart';
import 'package:flame/game.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:store_redirect/store_redirect.dart';

class UpdateAppPage extends StatelessWidget {
  const UpdateAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: BackgroundOnlyGame()),
          ResponsiveScreen(
              squarishMainArea: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EcoTossLogoAtom(),
                    EcoTossTitleAtom(),
                  ],
                ),
              ),
              rectangularMenuArea: Center(
                  child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "We've released new changes, update your app to get the latest features!",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (Responsive.isIOS())
                    FilledButton.icon(
                        label: const Text('Update on App Store'),
                        icon: const Icon(SimpleIcons.appstore),
                        onPressed: () =>
                            StoreRedirect.redirect(iOSAppId: '1672537834')),
                  if (Responsive.isAndroid())
                    FilledButton.icon(
                        label: const Text('Update on Google Play'),
                        icon: const Icon(SimpleIcons.googleplay),
                        onPressed: () => StoreRedirect.redirect(
                            androidAppId: 'tech.kek.socialgames.app')),
                ],
              )))
        ],
      ),
    );
  }
}
