// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:hotelio/models/hotel_model.dart';
import 'package:hotelio/source/hotel_source.dart';

class NearbyController extends GetxController {
  final _category = 'All Place'.obs;
  String get category => _category.value;
  set category(n) {
    _category.value = n;
    update();
  }

  List<String> get categories => [
        'All Place',
        'Industrial',
        'Village',
      ];

  final _listHotel = <HotelModel>[].obs;
  List<HotelModel> get listHotel => _listHotel.value;

  getListHotel() async {
    _listHotel.value = await HotelSource.getHotel();
    update();
  }

  @override
  void onInit() {
    getListHotel();
    super.onInit();
  }
}
