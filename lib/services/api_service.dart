import 'package:dio/dio.dart';
import '../models/booking_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://car-2lv3.onrender.com/api/bookings/';

  Future<bool> createBooking(Booking booking) async {
    try {
      final response = await _dio.post(
        _baseUrl,
        data: booking.toJson(), // Use the toJson method
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      // Successful creation often returns 201 (Created)
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        print(
            'Booking failed with status: ${response.statusCode}, Data: ${response.data}');
        return false;
      }
    } on DioException catch (e) {
      print('API Error: ${e.message}');
      if (e.response != null) {
        print('Server response data: ${e.response!.data}');
      }
      return false;
    } catch (e) {
      print('Unknown Error: $e');
      return false;
    }
  }
}
