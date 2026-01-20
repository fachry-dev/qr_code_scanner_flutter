import 'package:dio/dio.dart';

class QrCodeService {
  static final _baseUrl = 'https://event-ticketing-ruddy.vercel.app/';

  final _dio = Dio(BaseOptions(baseUrl: _baseUrl));

  Future<void> scanTicket(String qrData) async {
    await _dio.post('/api/scan', data: {'qr_data': qrData});
  }

}