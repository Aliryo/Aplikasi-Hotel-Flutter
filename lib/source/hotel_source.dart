import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotelio/models/hotel_model.dart';

class HotelSource {
  static Future<List<HotelModel>> getHotel() async {
    var result = await FirebaseFirestore.instance.collection('Hotel').get();
    return result.docs.map((e) => HotelModel.fromJson(e.data())).toList();
  }
}
