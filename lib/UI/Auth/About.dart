// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  static const route = "AboutScreen";
  final TextEditingController controllerUserName = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  AboutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('حول شركة تقنية سيستمز'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 80.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/images/splash.png"),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'شركة تقنية سيستمز لنظم المعلومات المتكاملة والحلول البرمجية',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "من نحن :",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "* شركة متخصصة في صناعة البرمجيات وتكنولوجيا المعلومات بجمهورية مصر العربية وجميع أنحاء الوطن العربي",
                  style: TextStyle(
                      color: Color.fromARGB(255, 83, 82, 82),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "* منذ أن تأسست الشركة عام 2008 ونحن نعمل على انتاج وتطوير وتسويق حلول إدارة وتخطيط الموارد لدى المؤسسات لكي تتناسب مع السوق العالمي",
                  style: TextStyle(
                      color: Color.fromARGB(255, 83, 82, 82),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "* قامت الشركة بإنتاج العديد من الحلول البرمجية المناسبة لجميع الأنشطة التجارية والصناعية والأعمال الخدمية والتي تضمن تحقيق أقصى استفادة لعملائها بشكل إحترافي مما يتوافق مع المعايير العالمية",
                  style: TextStyle(
                      color: Color.fromARGB(255, 83, 82, 82),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "رؤيتنا :",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "* أن تصبح شركة تقنية سيستمز شريك ناجح ودائم للشركات والمؤسسات في الشرق الأوسط من خلال تزويد عملائها بالحلول المتكاملة من أجل تحقيق النجاح المشترك .",
                  style: TextStyle(
                      color: Color.fromARGB(255, 83, 82, 82),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "وسعيا وراء ذلك :",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "* تم اختيار أمهر الكوادر الوظيفية",
                      style: TextStyle(
                          color: Color.fromARGB(255, 83, 82, 82),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "* ولم تكتفي الشركة بذلك ولكنها تسعى دائماً إلى استخدام أحدث الأساليب البرمجية لمواكبة التطور التكنولوجي المتسارع .",
                  style: TextStyle(
                      color: Color.fromARGB(255, 83, 82, 82),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "للتواصل مع الدعم الفني",
                  style: TextStyle(
                      color: Color.fromARGB(255, 83, 82, 82),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async =>
                          await launch("https://wa.me/+201063554044?text="),
                      child: const Text("+201063554044"),
                    ),
                    TextButton(
                      onPressed: () async =>
                          await launch("https://wa.me/+201014997133?text="),
                      child: const Text("+201014997133"),
                    ),
                    // const Text(
                    //   '0133211262',
                    //   style: TextStyle(
                    //       color: Color.fromARGB(255, 83, 82, 82),
                    //       fontSize: 18.0,
                    //       fontWeight: FontWeight.bold),
                    //   textAlign: TextAlign.end,
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "للتواصل مع قسم المبيعات",
                  style: TextStyle(
                      color: Color.fromARGB(255, 83, 82, 82),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async =>
                          await launch("https://wa.me/+201014996229?text="),
                      child: const Text("+201014996229"),
                    ),
                    TextButton(
                      onPressed: () async =>
                          await launch("https://wa.me/+201014770069?text="),
                      child: const Text("+201014770069"),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async =>
                              await launch("https://takniasystems.com/en"),
                          child: const Text("https://takniasystems.com"),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "لزيارة موقعنا :",
                      style: TextStyle(
                          color: Color.fromARGB(255, 83, 82, 82),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
