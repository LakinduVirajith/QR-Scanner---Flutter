import 'package:flutter/material.dart';
import 'package:qr_scanner/screen/home.dart';
import 'package:qr_scanner/widget/normal_button.dart';
import 'package:qr_scanner/widget/normal_input.dart';

class CreateQRScreen extends StatefulWidget {
  const CreateQRScreen({super.key});

  @override
  State<CreateQRScreen> createState() => _CreateQRScreenState();
}

class _CreateQRScreenState extends State<CreateQRScreen> {
  final TextEditingController _userNameController = TextEditingController();

  Future<void> _create() async {
    // AFTER SUCCESFULLY CREATED
    _userNameController.clear();
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
                NormalInput(
                  placeholderText: 'User Name',
                  iconPath: 'assets/icons/user.svg',
                  normalController: _userNameController,
                ),
                const SizedBox(height: 24.0),
                NormalButton(buttonText: 'CREATE', onPressed: _create)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
