import 'package:eco_toss/atomic/molecules/fab_molecule.dart';
import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/features/responsive.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:store_redirect/store_redirect.dart';

class UpdateAppPage extends StatelessWidget {
  const UpdateAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/navigation/jigsaw.png'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "We've released new changes, update your app to get the latest features!",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          if (Responsive.isIOS())
            FABMolecule.textIcon(
                text: 'Update on App Store',
                icon: const Icon(SimpleIcons.appstore),
                onPressed: () =>
                    StoreRedirect.redirect(iOSAppId: '1672537834')),
          if (Responsive.isAndroid())
            FABMolecule.textIcon(
                text: 'Update on Google Play',
                icon: const Icon(SimpleIcons.googleplay),
                onPressed: () => StoreRedirect.redirect(
                    androidAppId: 'tech.kek.socialgames.app')),
        ],
      ),
    );
  }
}
