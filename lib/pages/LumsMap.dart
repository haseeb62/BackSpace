import 'package:flutter/material.dart';

class Map1 extends StatelessWidget {
  const Map1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: const Text('Lums Map', style: TextStyle(fontFamily: "Poppins")),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Image.asset('assets/images/Map.png'),
      ),
    );
  }
}


//23100139@lums.edu.pk