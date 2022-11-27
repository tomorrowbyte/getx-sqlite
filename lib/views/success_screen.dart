import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.done,
              size: 64,
              color: Colors.green,
            ),
            Text("Payment successful"),
            SizedBox(height: 20),
            SizedBox(
              child: ElevatedButton.icon(
                icon: Icon(Icons.home),
                label: Text("Home"),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
