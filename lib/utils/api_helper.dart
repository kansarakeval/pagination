import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pagination/screen/photo/model/photo_model.dart';

class ApiHelper {
  static ApiHelper helper = ApiHelper._();

  ApiHelper._();

  Future<PhotoModel?> pageApi(int page, String category) async {
    String api = "https://pixabay.com/api/?key=41719809-bfbc15734e5fd2f31cfcb2f83&q=$category&page=$page";
    var response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      PhotoModel photoModel = PhotoModel.mapToModel(json);
      return photoModel;
    }
    return null;
  }
}
