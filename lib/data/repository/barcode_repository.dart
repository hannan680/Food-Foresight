import "package:dio/dio.dart";

class BarcodeRepository {
  final String apiKey;
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.barcodelookup.com/v3/products';

  BarcodeRepository(this.apiKey);

  Future<Map<String, dynamic>> lookupBarcode(String barcode) async {
    try {
      final response = await _dio.get(
        '$baseUrl',
        queryParameters: {'barcode': barcode, 'formatted': 'y', 'key': apiKey},
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load barcode information');
      }
    } catch (e) {
      throw Exception('Failed to load barcode information: $e');
    }
  }
}
