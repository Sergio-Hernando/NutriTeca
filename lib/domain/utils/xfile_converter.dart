import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class XFileConverter {
  Future<String> convertImageToBase64(XFile image) async {
    final bytes = await File(image.path).readAsBytes();
    return base64Encode(bytes);
  }

  Future<XFile> base64ToXFile(String base64String) async {
    final Uint8List bytes = base64Decode(base64String);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp_image.png');
    await tempFile.writeAsBytes(bytes);
    return XFile(tempFile.path);
  }
}
