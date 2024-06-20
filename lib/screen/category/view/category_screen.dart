import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pagination/screen/photo/controller/photo_controller.dart';
import 'package:pagination/screen/wallpaper/view/wallpaper_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PhotoController controller = Get.put(PhotoController());
  final ScrollController scrollController = ScrollController();

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
                const Gap(5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => Row(
                      children: [
                        categoryButton("car"),
                        const Gap(5),
                        categoryButton("Art"),
                        const Gap(5),
                        categoryButton("Home"),
                        const Gap(5),
                        categoryButton("Wallpaper"),
                        const Gap(5),
                        categoryButton("Animal"),
                      ],
                    ),
                  ),
                ),
                const Gap(5),
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
                          controller.getIndex(index);
                          Get.to(() => const WallpaperScreen(),
                              transition: Transition.downToUp,
                              arguments: controller.list[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              "${controller.list[index].previewURL}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget categoryButton(String category) {
    return ElevatedButton(
      onPressed: () {
        controller.categoryData(category);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.category.value == category
            ? Colors.yellow
            : Colors.white,
      ),
      child: Text(category),
    );
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }
}
