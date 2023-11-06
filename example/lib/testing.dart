// import 'package:flutter/material.dart';
// import 'package:video_manipulation/video_manipulation.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Image to Video Example'),
//         ),
//         body: MyImageToVideoConverter(),
//       ),
//     );
//   }
// }
//
// class MyImageToVideoConverter extends StatefulWidget {
//   @override
//   _MyImageToVideoConverterState createState() => _MyImageToVideoConverterState();
// }
//
// class _MyImageToVideoConverterState extends State<MyImageToVideoConverter> {
//   @override
//   void initState() {
//     super.initState();
//     createVideoFromImages();
//   }
//
//   createVideoFromImages() async {
//     final imagePaths = ['image1.jpg', 'image2.jpg', 'image3.jpg']; // List of image paths
//
//     final videoController = VideoController(
//       outputPath: 'outputVideo.mp4',
//       resolution: Resolution.HD720, // Set your desired resolution
//     );
//
//     for (final imagePath in imagePaths) {
//       final image = await Image.fromFile(File(imagePath));
//       videoController.addImage(image);
//     }
//
//     await videoController.exportVideo();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }