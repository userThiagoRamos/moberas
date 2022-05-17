import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mobEras/core/services/scale/IScaleService.dart';

@Injectable(as: IScaleService)
class ScaleService implements IScaleService {
  var manifestContent;

  @override
  Future<Map<String, String>> getScaleImageMap(String scale) async {
    manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    var imgNameList = <String>[];
    var imgPathList = <String>[];

    imgNameList = manifestMap.keys
        .where((String key) => key.contains('images/scale/$scale'))
        .map((e) => e.substring(e.lastIndexOf('/') + 1, e.length))
        .toList(growable: false);

    imgNameList.sort((img1, img2) => int.tryParse(img1.substring(
            img1.lastIndexOf('/') + 1, img1.lastIndexOf('/') + 2))
        .compareTo(int.tryParse(img2.substring(
            img2.lastIndexOf('/') + 1, img2.lastIndexOf('/') + 2))));

    imgPathList = manifestMap.keys
        .where((String key) => key.contains('images/scale/$scale'))
        .toList(growable: false);

    imgPathList.sort((img1, img2) => int.tryParse(img1.substring(
            img1.lastIndexOf('/') + 1, img1.lastIndexOf('/') + 2))
        .compareTo(int.tryParse(img2.substring(
            img2.lastIndexOf('/') + 1, img2.lastIndexOf('/') + 2))));

    return Map<String, String>.fromIterables(imgNameList, imgPathList);
  }
}
