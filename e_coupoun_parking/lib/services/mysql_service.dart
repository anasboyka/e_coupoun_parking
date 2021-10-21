import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MysqlService {
//https://fypcarparking.000webhostapp.com/

  getMethod() async {
    var urlmain =
        Uri.parse("https://fypcarparking.000webhostapp.com/get_driver.php");

    print(urlmain);
    print(Uri.encodeFull(urlmain.toString()));
    var res = await http.get(urlmain, headers: {"Accept": "application/json"});
    print(res.body);
    var responsBody = convert.jsonDecode(res.body);
    print(responsBody);
    return responsBody;
  }
}
