import 'package:flutter/material.dart';
import 'package:pagination/screen/photo/view/photo_screen.dart';
import 'package:pagination/screen/wallpaper/view/wallpaper_screen.dart';

Map<String,WidgetBuilder> app_routes={
  '/':(context) => const PhotoScreen(),
  'wallpaper':(context) =>const WallpaperScreen(),
};