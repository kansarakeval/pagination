import 'package:get/get.dart';
import 'package:pagination/screen/photo/model/photo_model.dart';
import 'package:pagination/utils/api_helper.dart';

class PhotoController extends GetxController {
  Rxn<PhotoModel> photoModel = Rxn<PhotoModel>();
  RxList<HitsModel> list = <HitsModel>[].obs;
  RxInt page = 1.obs;
  RxBool isLoading = false.obs;
  RxString category = "nature".obs;

  Future<void> getPhotoData() async {
    isLoading.value = true;
    PhotoModel? p1 = await ApiHelper.helper.pageApi(page.value, category.value);
    if (p1 != null) {
      photoModel.value = p1;
      list.addAll(p1.hitsList!);
      page.value++;
    }
    isLoading.value = false;
  }

  void categoryData(String c1) {
    category.value = c1;
    page.value = 1;
    list.clear();
    getPhotoData();
  }
}
