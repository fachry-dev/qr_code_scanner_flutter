import 'package:dio/dio.dart';
import 'package:qr_scanner/features/history/models/ticket_model.dart';

class QrCodeService {
  static final _baseUrl = 'https://event-ticketing-ruddy.vercel.app/';

  final _dio = Dio(BaseOptions(baseUrl: _baseUrl));

  Future<void> scanTicket(String qrData) async {
    await _dio.post('/api/scan', data: {'qr_data': qrData});
  }

  Future<List<TicketModel>> getTickets() async {
    final response = await _dio.get('/api/tickets');
    return (response.data as List)
        .map((ticketData) => TicketModel.fromJson(ticketData))
        .toList();
  }

  Future<void> redeemTicket(String ticketId) async {
    await _dio.post('/api/redeem', data: {'ticket_id': ticketId});
  }

  Future<void> cancelTicket(String ticketId) async {
    await _dio.post('/api/cancel', data: {'ticket_id': ticketId});
  }

  Future<void> addTicket(String name) async {
    await _dio.post('/api/tickets', data: {'name': name});
  }

  Future<void> deleteTicket(String id) async {
    await _dio.delete('/api/tickets', queryParameters: {'id': id});
  }


}