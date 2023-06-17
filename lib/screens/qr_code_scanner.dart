import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vemdora_flutter_frontend/utils/config.dart';
import 'package:vemdora_flutter_frontend/widgets/qr_scanner_overlay.dart';
import '../../providers/user_state.dart';
import 'package:provider/provider.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  MobileScannerController cameraController = MobileScannerController();
  List<String> vmIDList = [];

  @override
  void initState() {
    super.initState();
    fetchVmIDList();
  }

  void closeScreen() {
    isScanCompleted = false;
  }

  Future<void> fetchVmIDList() async {
    try {
      String myConfig = Config.apiLink;
      final response = await get(Uri.parse('$myConfig/vendingMachines'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<String> fetchedVmIDList = [];

        for (var item in data) {
          String vmID = item['vendingMachineID'].toString();
          fetchedVmIDList.add(vmID);
        }

        setState(() {
          vmIDList = fetchedVmIDList;
        });
      } else {
        print('Failed to fetch vmID list. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to fetch vmID list. Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    UserState userState = Provider.of<UserState>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
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
                    'Scan QR Code on Vending Machine',
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
              child: Stack(
                children: [
                  MobileScanner(
                    allowDuplicates: true,
                    controller: cameraController,
                    onDetect: (barcode, args) async {
                      if (!isScanCompleted) {
                        String code = barcode.rawValue ?? '---';
                        isScanCompleted = true;

                        await Future.delayed(const Duration(milliseconds: 500));

                        if (vmIDList.contains(code)) {
                          if (userState.userType == UserType.publicUser) {
                            Navigator.of(context).popAndPushNamed(
                                '/usermenulist',
                                arguments: code);
                          } else {
                            Navigator.of(context).popAndPushNamed(
                                '/suppliermenulist',
                                arguments: code);
                          }
                          cameraController.dispose();
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Invalid QR Code'),
                                content: const Text(
                                  'QR Code Scanned is not regconised by Vemdora',
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      await Future.delayed(
                                          const Duration(milliseconds: 1000));
                                      closeScreen();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                  QRScannerOverlay(
                    overlayColour: const Color.fromRGBO(188, 219, 255, 1),
                  )
                ],
              ),
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
