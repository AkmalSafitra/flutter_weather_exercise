import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRPage extends StatefulWidget {
  static const routeName = '/generateQRPage';

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR Code'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: controller.text,
                size: 200,
                backgroundColor: Colors.white24,
              ),
              SizedBox(
                height: 40,
              ),
              buildtextField(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildtextField(BuildContext context) => TextField(
    controller: controller,
    style: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the Data',
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.greenAccent),
      ),
      suffixIcon: IconButton(
        color: Theme.of(context).accentColor,
        icon: Icon(Icons.done, size: 30,),
        onPressed: () => setState((){}),
      )
    ),
  );
}
