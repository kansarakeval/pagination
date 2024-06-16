import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pagination/screen/photo/model/photo_model.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  HitsModel h1 = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: Scaffold(
    //     body: Center(
    //       child: SizedBox(
    //         height: double.infinity,
    //         width: double.infinity,
    //         child: Image.network("${h1.largeImageURL}"),
    //       ),
    //     ),
    //   ),
    // );
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Video or image
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.network(
                "${h1.largeImageURL}",
                fit: BoxFit.cover,
              ),
            ),
            // Overlay elements
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User info
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage("${h1.userImageURL}"),
                        radius: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "${h1.user}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Follow functionality
                        },
                        child: Text('Follow'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Description
                  Text(
                    "${h1.tags}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Music info
                  Row(
                    children: [
                      Icon(Icons.music_note, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Original sound - ${h1.user}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            // Interactive buttons
            Positioned(
              right: 16,
              bottom: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {
                      // Like functionality
                    },
                  ),
                  Text(
                    '${h1.likes}',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  IconButton(
                    icon: Icon(Icons.comment_outlined, color: Colors.white),
                    onPressed: () {
                      // Comment functionality
                    },
                  ),
                  SizedBox(height: 16),
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.white),
                    onPressed: () {
                      // Share functionality
                    },
                  ),
                  SizedBox(height: 16),
                  IconButton(
                    icon: Icon(Icons.bookmark_border, color: Colors.white),
                    onPressed: () {
                      // Save functionality
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
