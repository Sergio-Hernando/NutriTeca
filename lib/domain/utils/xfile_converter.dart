import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:isolate';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class XFileConverter {
  // Función para comprimir la imagen y convertirla a Base64 usando Isolate
  Future<String> convertImageToBase64(XFile image, {int quality = 30}) async {
    final bytes = await File(image.path).readAsBytes();

    // Inicia un Isolate para comprimir la imagen
    final compressedBytes =
        await _compressImageInIsolate(bytes, quality: quality);

    // Convierte a Base64
    return base64Encode(compressedBytes);
  }

  // Función para convertir de Base64 a XFile
  Future<XFile> base64ToXFile(String base64String) async {
    final Uint8List bytes = base64Decode(base64String);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp_image.png');
    await tempFile.writeAsBytes(bytes);
    return XFile(tempFile.path);
  }

  // Función privada para comprimir la imagen en un Isolate
  Future<Uint8List> _compressImageInIsolate(Uint8List imageBytes,
      {int quality = 80}) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(
        _compressImage, [imageBytes, quality, receivePort.sendPort]);

    // Espera la respuesta del Isolate
    final compressedBytes = await receivePort.first;
    return compressedBytes as Uint8List;
  }

  // Función que se ejecuta en el Isolate
  static void _compressImage(List<dynamic> args) {
    final imageBytes = args[0] as Uint8List;
    final quality = args[1] as int;
    final sendPort = args[2] as SendPort;

    // Decodifica y comprime la imagen
    final image = img.decodeImage(imageBytes)!;
    final compressedImage = img.encodeJpg(image, quality: quality);

    // Envía de vuelta el resultado al hilo principal
    sendPort.send(Uint8List.fromList(compressedImage));
  }
}
