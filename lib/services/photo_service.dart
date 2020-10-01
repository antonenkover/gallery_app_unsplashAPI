import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_app/components/list_photo_item.dart';

const String apiKey =
    'YOUR_API_KEY_HERE';
const String mainURL = 'https://api.unsplash.com/photos';

class PhotoService {
  Future<List<ListPhotoItem>> getPhotoDataPerPage(int pageIndex) async {
    List<ListPhotoItem> photos = [];
    String url = '$mainURL?page=$pageIndex';
    http.Response response =
        await http.get(url, headers: {"Authorization": "Client-ID $apiKey"});
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        photos.add(ListPhotoItem(
            previewImageURL: data.elementAt(i)['urls']['small'],
            fullImageURL: data.elementAt(i)['urls']['regular'],
            authorName: data.elementAt(i)['user']['name']));
      }
    } else
      print(response.statusCode);
    return photos;
  }
}
