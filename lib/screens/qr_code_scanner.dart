import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../providers/user_state.dart';
import 'package:provider/provider.dart';

const bgColor = Color(0xfffafafa);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;

  void closeScreen() {
    isScanCompleted = false;
  }

  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    UserState userState = Provider.of<UserState>(context, listen: false);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'QR Scanner',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Place the QR code in the area',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Scanning will be started automatically',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: MobileScanner(
                  allowDuplicates: true,
                  controller: cameraController,
                  onDetect: (barcode, args) {
                    if (!isScanCompleted) {
                      String code = barcode.rawValue ?? '---';
                      isScanCompleted = true;
                      if (userState.userType == UserType.publicUser) {
                        Navigator.of(context)
                            .popAndPushNamed('/usermenulist', arguments: code);
                      } else {
                        Navigator.of(context).popAndPushNamed(
                            '/suppliermenulist',
                            arguments: code);
                      }

                      cameraController.dispose();
                    }
                  }),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: const Text(
                'Powered by Vemdora',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
