import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    late final file;

    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    file = File('${dir.path}/$name');
    print(file.path);

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    File url = file;

    await openFile(url);
  }

  static Future SaveInPhone(Document pdf) async {
    File file = File("example.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}
