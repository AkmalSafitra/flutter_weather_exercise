import 'dart:io';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_exercise/application/weather/weather_bloc.dart';
import 'package:flutter_weather_exercise/domain/Weather/weather.dart';
import 'package:flutter_weather_exercise/domain/user/user_model.dart';
import 'package:flutter_weather_exercise/presentation/routes/router.gr.dart';
import 'package:flutter_weather_exercise/presentation/weather/weather_detail_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRPage extends StatefulWidget {
  static const routeName = '/scanQRPage';

  @override
  State<ScanQRPage> createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {

  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildViewQR(context),
          Positioned(
            top: 10,
            child: buildControlButtons(),
          ),
          Positioned(
            bottom: 10,
            child: buildResult(),
          ),
        ],

      )
      ,
    );
  }

  Widget buildViewQR(BuildContext context) =>
      QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 10,
          borderColor: Colors.black12,
          cutOutSize: MediaQuery
              .of(context)
              .size
              .width * 0.8,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((barcode) =>
        setState(() {
          this.barcode = barcode;
        }));
  }

  Widget buildResult() =>
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          barcode != null ? 'Result : ${barcode!.code}' : 'Scan Barcode',
          maxLines: 3,
        ),
      );

  Widget buildControlButtons() =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
                icon: FutureBuilder<bool?>(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    if(snapshot.data != null ){
                      return Icon(snapshot.data! ? Icons.flash_on : Icons.flash_off);
                    }else{
                      return Container();
                    }
                  }
                ),
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                }),
            IconButton(
                icon: FutureBuilder(
                    future: controller?.getCameraInfo(),
                    builder: (context, snapshot) {
                      if(snapshot.data != null ){
                        return Icon(Icons.switch_camera);
                      }else{
                        return Container();
                      }
                    }
                ),
                onPressed: () async {
                  await controller?.flipCamera();
                  setState(() {});
                }),

          ],
        ),
      );

}



