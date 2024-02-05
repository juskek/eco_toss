import 'package:eco_toss/common_imports.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({
    required this.message,
    this.loading = false,
    super.key,
  });
  final String message;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const FlutterLogo(),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
