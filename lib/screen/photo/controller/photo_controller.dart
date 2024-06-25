import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pagination/screen/photo/model/photo_model.dart';
import 'package:pagination/utils/api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PhotoController extends GetxController {
  Rxn<PhotoModel> photoModel = Rxn<PhotoModel>();
  RxList<HitsModel> list = <HitsModel>[].obs;
  RxInt page = 1.obs;
  RxInt index = 0.obs;
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

  void getIndex(int i) {
    index.value = i;
  }

  //download Image
  Future<void> downloadImg(BuildContext context, String uri) async {
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getExternalStorageDirectory();
        if (dir == null) {
          throw Exception("failed to get directory ");
        }
        String filePath = "${dir.path}/image.png";
        File file = File(filePath);
        await file.writeAsBytes(bytes);
        final params = SaveFileDialogParams(sourceFilePath: filePath);
        final result = await FlutterFileDialog.saveFile(params: params);
        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("image save to gallery"),
            ),
          );
        } else {
          throw Exception("failed to save image in to gallery");
        }
      } else {
        throw Exception("failed to download image in to gallery");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }
  }

  //share Image
  Future<void> shareImg(context, String share) async {
    final RenderBox box = context.findRenderObject();
    if (Platform.isAndroid) {
      var response = await get(Uri.parse(share));
      final documentDirectory = (await getExternalStorageDirectory())!.path;
      File imgFile = File('$documentDirectory/flutter.png');
      imgFile.writeAsBytesSync(response.bodyBytes);

      Share.shareXFiles([XFile('$documentDirectory/flutter.png')],
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }
}
