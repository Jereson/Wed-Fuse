import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/viewModel/deeplink_vm.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 4500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    print('The splash screen why');
    controller.forward().then((_) {
      // navigationPage();

      getIt.get<DynamicDeepLinkModelView>().initDynamicOnclickLink(context);
      // getIt.get<AuthViewModel>().dummyAddUser();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // void navigationPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const WelcomeScreen()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: kPrimaryWhite),
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                    child: opacity.value > 0.2
                        ? Opacity(
                            opacity: opacity.value,
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Image.asset(
                                    'assets/images/webfuse-logo.png')))
                        : Center(child: Lottie.asset("assets/gif/loading.json"))

                    // const CustomLoader()

                    ),
                const Center(
                  child: Text(
                    "Powered by WedFuse",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
