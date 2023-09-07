import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/viewModel/wallet_vm.dart';
import 'package:wedme1/widget/app_bar_widget.dart';

class PaymentScreen extends StatefulWidget {
  final String? source;
  const PaymentScreen({super.key, this.source});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController _controller;
  bool isLoaded = false;
  WalletVm? walletVm;

  @override
  void initState() {
    walletVm = getIt.get<WalletVm>();
    // final walletVm = getIt.get<WalletVm>().initatiatePaymentResponse;
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
            if (progress == 100) {
              setState(() {
                isLoaded = true;
              });
            }
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
            Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
                      ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            print('The payment ${request.url}');
            if (request.url ==
                "https://wedfuse.com/?status=cancelled&tx_ref=${walletVm!.generateTxRef!}") {
              Navigator.of(context).pop();
            } else if (request.url.contains(
                'status=successful&tx_ref=${walletVm!.generateTxRef!}')) {
              if (widget.source == 'premium') {
                walletVm!.premiumSubscription(context);
              } else if (widget.source == 'buyCoin') {
                walletVm!.topupUserCoin(context);
              }
            } else if (request.url ==
                'https://wedfuse.com/?status=failed&tx_ref=${walletVm!.generateTxRef!}') {
              print('he payment transaction is failed');
            }
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   debugPrint('blocking navigation to ${request.url}');
            //   return NavigationDecision.prevent;
            // }
            // debugPrint('allowing navigation to ${request.url}');

            // if (request.url == 'https://standard.paystack.co/close') {
            //   // getit!.proceedPayment(context, getit!.orderId!);
            // }

            // if (request.url ==
            //     "https://jsoft.com/?trxref=${initialValue!.data!.accessCode!}&reference=${initialValue.data!.reference}") {
            //   print('The payment is here');
            //   // verifyTransaction(reference);
            //   // Navigator.of(context).pop();
            // }
// https://wedfuse.com/?status=successful&tx_ref=9x674Ctn1s3KH&transaction_id=4314021

//uNzimDlxmwzcx
            return NavigationDecision.prevent;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(
          Uri.parse('${walletVm!.initatiatePaymentResponse!.data!.link}'));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, 'Wedfuse Payment', isPop: true),
      body: !isLoaded
          ? Container(
              alignment: Alignment.center,
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: const CupertinoActivityIndicator(
                color: Colors.amber,
              ),
            )
          : WebViewWidget(
              controller: _controller,
            ),
    );
  }
}
