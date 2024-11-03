import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/constant.dart';
import 'package:simple_barcode_scanner/enum.dart';
// ignore: avoid_web_libraries_in_flutter
import 'package:web/web.dart' as html;

import '../barcode_appbar.dart';

/// Barcode scanner for web using iframe
class BarcodeScanner extends StatelessWidget {
  final String lineColor;
  final String cancelButtonText;
  final bool isShowFlashIcon;
  final ScanType scanType;
  final CameraFace cameraFace;
  final Function(String) onScanned;
  final String? appBarTitle;
  final bool? centerTitle;
  final Widget? child;
  final BarcodeAppBar? barcodeAppBar;
  final int? delayMillis;
  final Function? onClose;

  const BarcodeScanner({
    super.key,
    required this.lineColor,
    required this.cancelButtonText,
    required this.isShowFlashIcon,
    required this.scanType,
    this.cameraFace = CameraFace.back,
    required this.onScanned,
    this.appBarTitle,
    this.centerTitle,
    this.child,
    this.barcodeAppBar,
    this.delayMillis,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    String createdViewId = DateTime.now().microsecondsSinceEpoch.toString();
    String? barcodeNumber;

    final iframe = html.HTMLIFrameElement()
      ..src = PackageConstant.barcodeFileWebPath
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..onLoad.listen((event) async {
        /// Barcode listener on success barcode scanned
        html.window.onMessage.listen((event) {
          /// If barcode is null then assign scanned barcode
          /// and close the screen otherwise keep scanning
          if (barcodeNumber == null) {
            barcodeNumber = event.data.toString();
            onScanned(barcodeNumber!);
          }
        });
      });
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory(createdViewId, (int viewId) => iframe);
    final width = MediaQuery.of(context).size.width;
    final height = width / (16 / 9);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: HtmlElementView(
                viewType: createdViewId,
              ),
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    if (appBarTitle == null && barcodeAppBar == null) {
      return null;
    }
    if (barcodeAppBar != null) {
      return AppBar(
        title: barcodeAppBar?.appBarTitle != null
            ? Text(barcodeAppBar!.appBarTitle!)
            : null,
        centerTitle: barcodeAppBar?.centerTitle ?? false,
        leading: barcodeAppBar?.enableBackButton == true
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: barcodeAppBar?.backButtonIcon ??
                    const Icon(Icons.arrow_back_ios))
            : null,
        automaticallyImplyLeading: false,
      );
    }
    return AppBar(
      title: Text(appBarTitle ?? kScanPageTitle),
      centerTitle: centerTitle,
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
