import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bip32/bip32.dart';
import 'package:event_system/model/my_access_token.dart';
import 'package:event_system/pages/builder/page_class.dart';
import 'package:event_system/utils/bytes_to_hex.dart';
import 'package:event_system/utils/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:ui';
import 'package:event_system/utils/animation.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class TicketDetailPage extends PageClass{

  MyAccessToken myAccessToken;
  String dataString;

  TicketDetailPage({this.myAccessToken, this.dataString});

  @override
  AppBar getAppbar(BuildContext context) {
    return AppBar(
            title: Center(
              child: Text(myAccessToken.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
              ),
            );
  }

  @override
  Widget getBody(BuildContext context) {
    return GenerateScreen(myAccessToken: myAccessToken, dataString: dataString,);
  }

}

class GenerateScreen extends StatefulWidget {
  MyAccessToken myAccessToken;
  String dataString;
  GenerateScreen({this.myAccessToken, this.dataString});
  
  @override
  State<StatefulWidget> createState() => GenerateScreenState(myAccessToken: myAccessToken, dataString: dataString);

}

class GenerateScreenState extends State<GenerateScreen> with TickerProviderStateMixin {

  GenerateScreenState({this.myAccessToken, this.dataString});

  String _inputErrorText;
  MyAccessToken myAccessToken;

  GlobalKey globalKey = new GlobalKey();
  String dataString;
  String message;
  String signature;
  AnimationController _controller;
  Animation _animation;
  String firstName = "Thomas";
  String lastName = "Vandendijk";
  String checkStatus = "not Found";

  String get timerString {
    Duration duration = _controller.duration - _controller.duration * _controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ))..addStatusListener(handler);
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _contentWidget(),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(bottom: 2.0, top: 20.0)),
                Text(
                  firstName + " " + lastName,
                  style: const TextStyle(
                    fontSize: 30.0,
                    color: Colors.black54,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 2.0, top: 20.0)),
                Text(
                  "Ticket type:",
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  myAccessToken.type,
                  style: const TextStyle(
                    fontSize: 28.0,
                    color: Colors.black54,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 2.0, top: 20.0)),
                Text(
                  "Price:",
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '€' + myAccessToken.price.toString(),
                  style: const TextStyle(
                    fontSize: 26.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handler(status){
    if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
        setState(() {
          generateNewQR(myAccessToken.id).then((qr_data){
            dataString = qr_data;
          });
        });
      }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _contentWidget() {
      ThemeData themeData = Theme.of(context);
      SizeConfig().init(context);
      return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
              height: SizeConfig.blockSizeVertical * 40,
              width: SizeConfig.blockSizeHorizontal * 60,
              child: Center(
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImage(
                    version: 7,
                    data: dataString,
                    onError: (ex){
                      print("[QR] ERROR - $ex");
                      setState((){
                      _inputErrorText = "Error! Maybe your input value is too long?";
                    });
                    },
                  ),
                ),
              ),
            )),
            Center(
              child: Container(
              height: SizeConfig.blockSizeVertical * 10,
              width: SizeConfig.blockSizeHorizontal * 15,
              child: Center(
                child: RepaintBoundary(
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Container(
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Align(
                                      alignment: FractionalOffset.center,
                                      child: AspectRatio(
                                        aspectRatio: 1.0,
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned.fill(
                                              child: CustomPaint(
                                                  painter: CustomTimerPainter(
                                                    animation: _animation,
                                                    backGroundColor: Colors.white,
                                                    color: themeData.indicatorColor,
                                                  )),
                                            ),
                                            Align(
                                              alignment: FractionalOffset.center,
                                              child:Text(
                                                    timerString,
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.red),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ],
              ));
          }))))
        )],),
      );
  }
}

class SizeConfig {
 static MediaQueryData _mediaQueryData;
 static double screenWidth;
 static double screenHeight;
 static double blockSizeHorizontal;
 static double blockSizeVertical;
 
 void init(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData.size.width;
  screenHeight = _mediaQueryData.size.height;
  blockSizeHorizontal = screenWidth / 100;
  blockSizeVertical = screenHeight / 100;
 }

}

Future<String> generateNewQR(int id) async {
  BIP32 bip32 = await PrivateKey.bip32;
  var dateTime = DateTime.now();
  String formattedDate = DateFormat('dd:MM:yyyy:kk:mm:ss').format(dateTime);
  String message = formattedDate + ':::' + id.toString();
  Uint8List pubKeyBytes = bip32.publicKey;
  String pubKey = convertUint8ListToHex(pubKeyBytes);
  Uint8List messageBytes = utf8.encode(message);
  final d = new SHA256Digest();
  final Uint8List hash = d.process(messageBytes);
  Uint8List signatureBytes = bip32.sign(hash);
  String signature = convertUint8ListToHex(signatureBytes);
  return signature + ':::' + message;
}

Future<bool> sendAccessCheck(String message, String signature, String url) async {
  final storage = new FlutterSecureStorage();
  String authToken = await storage.read(key: 'authToken');
  var res = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Token $authToken',
      },
      body: {
        "message": message,
        "signature": signature,
      }
    );
  return res.statusCode == 200;
}



