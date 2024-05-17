import 'package:flutter/material.dart';
import 'package:qr_scanner/widget/normal_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _create() async {}
  Future<void> _scan() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                NormalButton(buttonText: 'CREATE QR', onPressed: _create),
                const SizedBox(height: 24.0),
                NormalButton(buttonText: 'SCAN QR', onPressed: _scan)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
