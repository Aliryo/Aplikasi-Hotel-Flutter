// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:hotelio/models/booking_model.dart';
import 'package:hotelio/source/booking_source.dart';

class HistoryController extends GetxController {
  final _listBooking = <BookingModel>[].obs;
  List<BookingModel> get listBooking => _listBooking.value;

  getListBooking(String id) async {
    _listBooking.value = await BookingSource.getHistory(id);
    update();
  }
}
