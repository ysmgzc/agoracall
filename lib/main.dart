import 'package:agoranewproject/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(
     const GetMaterialApp(
          home: HomePage(),
        debugShowCheckedModeBanner: false, 
      )
  );
}
