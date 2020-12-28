import 'dart:typed_data';
import 'package:convert/convert.dart';

String convertUint8ListToHex(Uint8List input){
    List<int> inputInt = input.cast<int>();
    return hex.encode(inputInt);
  }