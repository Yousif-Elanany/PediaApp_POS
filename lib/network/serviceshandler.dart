import 'dart:convert';
import 'package:http/http.dart' as http;

class ServicesHandler {
  Future<dynamic> getService(
      {String? urlSuffix, Map<String, String>? headers}) async {
    var headers = {
      'Authorization': 'Bearer oyHwASjY3nfpWjpkWVcdF1ARZN3I0t',
      'Cookie': 'session_id=5f66951b0e3326282569672327d6f7879c8587a7'
    };

    var request = http.Request('GET',
       // Uri.parse('https://5.189.161.154:80/api/${urlSuffix.toString()}'));
        Uri.parse('http://207.180.213.98:80/api/${urlSuffix.toString()}'));
    // Uri.parse('http://192.168.1.162:5000/api/${urlSuffix.toString()}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responsee = await http.Response.fromStream(response);
    if (responsee.statusCode == 200) {
      return json.decode(responsee.body);
    }
  }

  Future<dynamic> getServiceJSON({required String proName, required dynamic params, required String constr}) async {
 var headers = {
    'Content-Type':'application/json',
    };
    var param = {
      'proName': proName,
      'par': params,
      'constr': constr,
    };
  var  par=json.encode(param) ;
 // var response = await http.post(Uri.parse('http://207.180.213.98:80/api/RunSql'),headers: headers,body:par);
 var response = await http.post(Uri.parse('http://192.168.1.162:5000/api/RunSql'),headers: headers,body:par);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }
}
