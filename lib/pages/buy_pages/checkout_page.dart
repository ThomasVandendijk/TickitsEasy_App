import 'package:event_system/pages/builder/root_page.dart';
import 'package:event_system/rest/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:event_system/utils/settings.dart';

void redirectToCheckout(BuildContext context, String sessionId, String publicKey) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (_) => CheckoutPage(sessionId: sessionId, publicKey: publicKey),
  ));
}

class CheckoutPage extends StatefulWidget {
  final String sessionId;
  final String publicKey;

  const CheckoutPage({Key key, this.sessionId, this.publicKey}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WebView(
        initialUrl: initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (webViewController) =>
            _webViewController = webViewController,
        onPageFinished: (String url) {
          if (url == initialUrl) {
            _redirectToStripe(widget.sessionId, widget.publicKey);
          }
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith(getHost() + URLs().paymentsSuccessUrl)) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => new RootPage()));
            displayDialog(context, "Congratulations!", "The tickets were bought");
          } else if (request.url.startsWith(URLs().paymentsCancelUrl)) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => new RootPage()));
            displayDialog(context, "Cancelled", "You have cancelled the payment process");
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  String get initialUrl => getHost() + URLs().paymentsCheckoutUrl;

  Future<void> _redirectToStripe(String sessionId, String publicKey) async {
    final redirectToCheckoutJs = '''
      var stripe = Stripe(\'$publicKey\');
          
      stripe.redirectToCheckout({
        sessionId: '$sessionId'
      }).then(function (result) {
        result.error.message = 'Error'
      });
      ''';

    try {
      await _webViewController.evaluateJavascript(redirectToCheckoutJs);
    } on PlatformException catch (e) {
      if (!e.details.contains(
          'JavaScript execution returned a result of an unsupported type')) {
        rethrow;
      }
    }
  }
}