

import 'dart:io';

import 'package:doc_scanner/pdfViewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:images_to_pdf/images_to_pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:printing/printing.dart';


import 'file_operations.dart';


class ViewDocument extends StatefulWidget {

  @override
  _ViewDocumentState createState() => _ViewDocumentState();
}


class _ViewDocumentState extends State<ViewDocument> {
  FileOperations fileOperations;
  File image_file;
  String dirPath;
  FileStat _pdfStat;
  File _pdfFile;





  Future<void> createDirectoryPath() async {
    Directory appDir = await getExternalStorageDirectory();
    dirPath = "${appDir.path}/DocScan ${DateTime.now()}";
  }


  Future<void> _createPdf() async {

      final tempDir = await getApplicationDocumentsDirectory();
      final output = File(path.join(tempDir.path, 'doc_scan.pdf'));

      final images = [];
      images.add(image_file);

      await ImagesToPdf.createPdf(
        pages: images
            .map(
              (file) => PdfPage(
            imageFile: file,

          ),
        )
            .toList(),
        output: output,
      );
      _pdfStat = await output.stat();
      this.setState(() {
        _pdfFile = output;
      });
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PDFScreen(_pdfFile.path)));
  }

  Future<void> _sharePdf() async {
    if(_pdfFile != null) {
      final tempDir = await getApplicationDocumentsDirectory();
      final output = File(path.join(tempDir.path, 'scan.pdf'));

      final images = [];
      images.add(image_file);

      await ImagesToPdf.createPdf(
        pages: images
            .map(
              (file) =>
              PdfPage(
                imageFile: file,

              ),
        )
            .toList(),
        output: output,
      );
      _pdfStat = await output.stat();
      this.setState(() {
        _pdfFile = output;
      });
    }
    if (_pdfFile != null) {
      try {
        final bytes = await _pdfFile.readAsBytes();
        await Printing.sharePdf(
            bytes: bytes, filename: path.basename(_pdfFile.path));
      } catch (e) {
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        actions: [
          IconButton(icon: Icon(Icons.picture_as_pdf), onPressed: (){ _createPdf();}),
          IconButton(icon: Icon(Icons.share), onPressed: (){_sharePdf();})

        ],
      ),

        body: Column(
          children: [
            Container(
                child:  Expanded(child: Image.file(image_file) )

            ),
            FlatButton(
              child: Text("Save"),
                onPressed: (){
                // _saveImage();
                })
          ],
        )
        ,
    ),
    );
  }

  @override
  void initState() {
    fileOperations = FileOperations();
    getImage();
  }

  Future<void> getImage() async {
     image_file = await fileOperations.openGallery();
     setState(() {

     });

  }

}


