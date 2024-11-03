import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/barcode_appbar.dart';
import 'package:simple_barcode_scanner/enum.dart';

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
  const BarcodeScanner(
      {super.key,
      this.lineColor = "#ff6666",
      this.cancelButtonText = "Cancel",
      this.isShowFlashIcon = false,
      this.scanType = ScanType.barcode,
      this.cameraFace = CameraFace.back,
      required this.onScanned,
      this.appBarTitle,
      this.child,
      this.centerTitle,
      this.barcodeAppBar,
      this.delayMillis,
      this.onClose});

  @override
  Widget build(BuildContext context) {
    throw 'Platform not supported';
  }
}
