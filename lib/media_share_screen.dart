import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaShareScreen extends StatefulWidget {
  @override
  _MediaShareScreenState createState() => _MediaShareScreenState();
}

class _MediaShareScreenState extends State<MediaShareScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedFile;

  Future<void> _pickMedia(ImageSource source, bool isVideo) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      XFile? file = isVideo
          ? await _picker.pickVideo(source: source)
          : await _picker.pickImage(source: source);
      setState(() {
        _selectedFile = file;
      });
    }
  }

  void _shareMedia() {
    if (_selectedFile != null) {
      Share.shareFiles([_selectedFile!.path], text: 'Check out this media!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Share'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedFile != null
                ? _selectedFile!.path.endsWith('.mp4')
                    ? Icon(Icons.video_file, size: 200, color: Colors.blueAccent)
                    : Image.file(File(_selectedFile!.path), height: 200)
                : Text(
                    'Select an image or video to share!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickMedia(ImageSource.gallery, false),
                  icon: Icon(Icons.photo_library),
                  label: Text('Pick Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () => _pickMedia(ImageSource.gallery, true),
                  icon: Icon(Icons.video_library),
                  label: Text('Pick Video'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _selectedFile != null
                ? ElevatedButton.icon(
                    onPressed: _shareMedia,
                    icon: Icon(Icons.share),
                    label: Text('Share'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
