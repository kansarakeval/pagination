import 'dart:ui';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination/screen/photo/controller/photo_controller.dart';
import 'package:pagination/screen/photo/model/photo_model.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  PhotoController controller = Get.put(PhotoController());
  HitsModel h1 = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Stack(
            fit: StackFit.expand,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (
                    child,
                    animation,
                    ) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: Image.network(
                  "${controller.list[controller.index.value]!.largeImageURL}",
                  fit: BoxFit.cover,
                  height: double.infinity,
                  key: ValueKey(
                      "${controller.list[controller.index.value]!.largeImageURL}"),
                ),
              ),
              BackdropFilter(
                blendMode: BlendMode.src,
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: CarouselSlider.builder(
                  itemCount: controller.list.length,
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      controller.getIndex(index);
                    },
                    height: MediaQuery.sizeOf(context).height,
                    enlargeCenterPage: true,
                    animateToClosest: true,
                    scrollDirection: Axis.horizontal,
                    initialPage: controller.index.value,
                  ),
                  itemBuilder: (context, index, realIdx) {
                    return Stack(
                      children: [
                        Center(
                          child: Image.network(
                            "${controller.list[index].largeImageURL}",
                            fit: BoxFit.cover,
                            height: MediaQuery.sizeOf(context).height * 0.92,
                            width: MediaQuery.sizeOf(context).width,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(

                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage("${controller.list[index].userImageURL}"),
                                    radius: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "${controller.list[index].user}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${controller.list[index].tags}",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.music_note, color: Colors.white),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Original sound - ${controller.list[index].user}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite_border, color: Colors.white),
                                onPressed: () {},
                              ),
                              Text(
                                '${controller.list[index].likes}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              IconButton(
                                icon: const Icon(Icons.comment_outlined, color: Colors.white),
                                onPressed: () {},
                              ),
                              const SizedBox(height: 10),
                              Builder(
                                builder: (context) {
                                  return IconButton(
                                    icon: const Icon(Icons.share, color: Colors.white),
                                    onPressed: () async {
                                      await controller.shareImg(context, "${controller.list[index].largeImageURL}");
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                              IconButton(
                                icon: const Icon(Icons.format_paint, color: Colors.white),
                                onPressed: () async {
                                  await AsyncWallpaper.setWallpaper(
                                    url: "${controller.list[index].largeImageURL}",
                                    wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
                                    goToHome: true,
                                    toastDetails: ToastDetails.error(),
                                    errorToastDetails: ToastDetails.error(),
                                  );
                                  Get.snackbar("Wallpaper", "Wallpaper set");
                                },
                              ),
                              const SizedBox(height: 10),
                              IconButton(
                                icon: const Icon(Icons.file_download_outlined, color: Colors.white),
                                onPressed: () {
                                  controller.downloadImg(context, "${controller.list[index].largeImageURL}");
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
