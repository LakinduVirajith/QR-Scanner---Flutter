import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/widget/normal_button.dart';
import 'package:qr_scanner/widget/normal_input.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/widget/number_input.dart';

class CreateQRScreen extends StatefulWidget {
  const CreateQRScreen({super.key});

  @override
  State<CreateQRScreen> createState() => _CreateQRScreenState();
}

class _CreateQRScreenState extends State<CreateQRScreen> {
  final TextEditingController _ticketNumberController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _qrData;
  String? ticketNumber;
  String? userName;
  String? mobileNumber;

  // CREATE QR CODE AND UPLOAD TO THE DB
  Future<void> _create() async {
    if (_userNameController.text.isNotEmpty &&
        _mobileNumberController.text.isNotEmpty) {
      setState(() {
        _qrData =
            'Username: ${_userNameController.text}, Mobile: ${_mobileNumberController.text}';
      });

      // NEED TO BE UPLOAD QR AND ADD USER DETAILS
      // await _firestore.collection('QRCode').add({'data': _qrData});

      ticketNumber = _ticketNumberController.text;
      userName = _userNameController.text;
      mobileNumber = _mobileNumberController.text;
      _ticketNumberController.clear();
      _userNameController.clear();
      _mobileNumberController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Both fields must be filled')),
      );
    }
  }

  // SAVE QR CODE
  Future<void> _saveQRCode() async {
    final image = await QrPainter(
      data: _qrData!,
      version: QrVersions.auto,
      gapless: false,
    ).toImage(300);

    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    final directory = await getDownloadsDirectory();
    final imagePath = '${directory!.path}/$userName-$mobileNumber';
    final File imageFile = File(imagePath);
    await imageFile.writeAsBytes(pngBytes);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('QR Code saved to gallery')),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberInput(
                  placeholderText: 'Ticket Number',
                  iconPath: 'assets/icons/mobile.svg',
                  numberController: _ticketNumberController,
                ),
                const SizedBox(height: 24.0),
                NormalInput(
                  placeholderText: 'User Name',
                  iconPath: 'assets/icons/user.svg',
                  normalController: _userNameController,
                ),
                const SizedBox(height: 24.0),
                NumberInput(
                  placeholderText: 'Mobile Number',
                  iconPath: 'assets/icons/mobile.svg',
                  numberController: _mobileNumberController,
                ),
                const SizedBox(height: 24.0),
                NormalButton(buttonText: 'CREATE', onPressed: _create),
                const SizedBox(height: 20),
                if (_qrData != null)
                  Row(
                    children: [
                      Expanded(
                        child: QrImageView(
                          data: _qrData!,
                          version: QrVersions.auto,
                          size: 250,
                          gapless: false,
                        ),
                      ),
                      IconButton(
                        onPressed: _saveQRCode,
                        icon: const Icon(Icons.download),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
