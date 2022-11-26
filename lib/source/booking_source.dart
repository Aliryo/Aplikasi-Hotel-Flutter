import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotelio/models/booking_model.dart';

class BookingSource {
  static Future<BookingModel?> checkIsBooked(
      String userId, String hotelId) async {
    var result = await FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('Booking')
        .where('id_hotel', isEqualTo: hotelId)
        .where('is_done', isEqualTo: false)
        .get();
    if (result.size > 0) {
      return BookingModel.fromJson(result.docs.first.data());
    }
    return null;
  }

  static Future<bool> addBooking(String userId, BookingModel booking) async {
    var ref = FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('Booking');
    var docRef = await ref.add(booking.toJson());
    docRef.update({'id': docRef.id});
    return true;
  }

  static Future<List<BookingModel>> getHistory(String id) async {
    var result = await FirebaseFirestore.instance
        .collection('User')
        .doc(id)
        .collection('Booking')
        .get();
    return result.docs.map((e) => BookingModel.fromJson(e.data())).toList();
  }
}
