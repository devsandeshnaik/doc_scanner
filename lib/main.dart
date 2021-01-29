
import 'package:doc_scanner/view_document.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Classes.dart';


void main() {
  runApp(MaterialApp(home:MyApp() ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> masterData;
  List<DirectoryOS> masterDirectories = [];
  String _imagePath = 'Unknown';

  @override
  void initState() {
    askPermission();

  }
  void askPermission() async {
    await _requestPermission();
  }

  Future<bool> _requestPermission() async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.requestPermissions(
        <PermissionGroup>[PermissionGroup.storage, PermissionGroup.camera]);
    if (result[PermissionGroup.storage] == PermissionStatus.granted &&
        result[PermissionGroup.camera] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }



  @override
  Widget build(BuildContext context) {
    return
    SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: RichText(
            text: TextSpan(
              text: 'Scan',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),

            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          visible: true,
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          tooltip: 'Scan Options',
          heroTag: 'speed-dial-hero-tag',
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.camera_alt),
              backgroundColor: Colors.blue,
              label: 'Camera',
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewDocument(
                    ),
                  ),
                );
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.image),
              backgroundColor: Colors.blue,
              label: 'Import from Gallery',
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewDocument(
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
     );
  }
}
