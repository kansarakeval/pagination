import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pagination/screen/photo/controller/photo_controller.dart';
import 'package:pagination/screen/wallpaper/view/wallpaper_screen.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  PhotoController controller = Get.put(PhotoController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.getPhotoData();
    scrollController.addListener(scrollListener);
  }

  Future<void> scrollListener() async {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent &&
        !controller.isLoading.value) {
      controller.isLoading.value = true;
      await controller.getPhotoData();
      controller.isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
              () {
            if (controller.photoModel.value == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                const Gap(20),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.95,
                  child: SearchBar(
                    hintText: "Search",
                    shadowColor: WidgetStateColor.transparent,
                    leading: const Icon(Icons.search),
                    onSubmitted: (value) {
                      controller.list.clear();
                      controller.categoryData(value);
                      controller.getPhotoData();
                    },
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: GridView.builder(
                    controller: scrollController,
                    itemCount: controller.list.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, mainAxisExtent: 170),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == controller.list.length) {
                        return controller.isLoading.value
                            ? const Center(
                          child: CircularProgressIndicator(),
                        )
                            : const SizedBox.shrink();
                      }
                      return InkWell(
                        onTap: () {
                          Get.to(() => const WallpaperScreen(),
                              transition: Transition.downToUp,
                              arguments: controller.list[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              "${controller.list[index]!.previewURL}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (controller.isLoading.value)
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
