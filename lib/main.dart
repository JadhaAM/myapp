import 'package:flutter/material.dart';
import 'media_share_screen.dart'; // Import the MediaShareScreen file

void main() {
  runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    @override
      Widget build(BuildContext context) {
          return MaterialApp(
                title: 'Media Share App',
                      theme: ThemeData(
                              primarySwatch: Colors.blue,
                                    ),
                                          debugShowCheckedModeBanner: false, // Disable the debug banner
                                                home: MediaShareScreen(), // Set MediaShareScreen as the main screen
                                                    );
                                                      }
                                                      }
                                                      
