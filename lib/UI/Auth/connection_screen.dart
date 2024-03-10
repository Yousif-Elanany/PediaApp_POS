// ignore_for_file: deprecated_member_use
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/Provider/user_provider.dart';
import 'package:pediaPOS/Data/components/displaysnackbar.dart';
import 'package:pediaPOS/Data/components/navigator.dart';
import 'package:pediaPOS/UI/Auth/login.dart';
import 'package:pediaPOS/network/cache_helper.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectionScreen extends StatelessWidget {
  ConnectionScreen({Key? key}) : super(key: key);
  var ConnStr;
  var connectionController = TextEditingController();
  var msg = "استفسار بخصوص الموبايل ابليكيشن";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Connection String',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: connectionController,
                        enabled: true,
                        maxLines: 5,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                          labelText: 'Connection String',
                          labelStyle:
                              const TextStyle(fontStyle: FontStyle.italic),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.deepPurple,
                              width: .5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.deepPurple,
                              width: .5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.deepPurple,
                        child: MaterialButton(
                          onPressed: () async {
                            final validationService = Provider.of<UserProvider>(
                                context,
                                listen: false);
                            ConnStr = decryptAES(connectionController.text);
                            var response =
                                await validationService.connectAPI(ConnStr);
                            switch (response) {
                              case 100:
                                displaySnackBar(
                                    context, "يرجي مراجعة البيانات ");
                                break;
                              case 200:
                                validationService.listen();
                                await CacheHelper.saveData(
                                    key: "Conn_str", value: ConnStr);
                                String txt = ConnStr;

                                String db = ConnStr.substring(
                                    txt.indexOf('database=') +
                                        'database='.length,
                                    txt.indexOf(
                                        ';',
                                        txt.indexOf('database=') +
                                            'database='.length));
                                await CacheHelper.saveData(
                                    key: "db_Name", value: db);
                                var register = await validationService
                                    .mobRegister(ConnStr);
                                switch (register) {
                                  case 100:
                                    displaySnackBar(context,
                                        "التعامل مع الموبايل ابليكيشن غير مفعل من فضلك تواصل مع الدعم الفني");
                                    break;
                                  case 200:
                                    AppNavigator.navigateTo(
                                        context, LoginScreen());
                                    break;
                                }
                                break;
                            }
                          },
                          child: const Text(
                            'Connect',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'للتواصل مع الدعم الفني عبر الواتس :',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 83, 82, 82),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                            ),
                            TextButton(
                              onPressed: () async => await launch(
                                  "https://wa.me/+201063554044?text=$msg"),
                              child: const Text("+201063554044"),
                            ),
                            TextButton(
                              onPressed: () async => await launch(
                                  "https://wa.me/+201014997133?text=$msg"),
                              child: const Text("+201014997133"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

decryptAES(encrypted) {
  var key = enc.Key.fromBase64('yE9tgqNxWcYDTSPNM+EGQw==');
  var iv = enc.IV.fromBase64('8PzGKSMLuqSm0MVbviaWHA==');
  var encrypter = enc.Encrypter(enc.AES(key));

  var decrypted =
      encrypter.decrypt(enc.Encrypted.fromBase64(encrypted), iv: iv);
  return decrypted;
}
