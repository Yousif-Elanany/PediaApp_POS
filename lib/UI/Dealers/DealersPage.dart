import 'package:flutter/material.dart';
import 'package:pediaPOS/Data/components/navigator.dart';
import 'package:pediaPOS/UI/Dealers/DealersBalancesDetails.dart';
import 'package:pediaPOS/UI/Dealers/addDealer.dart';
import 'package:pediaPOS/helpers/Custom_Button.dart';

class DealersPage extends StatelessWidget {
  const DealersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        centerTitle: true,
        title: const Text(
          " العملاء",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButon(
              text: 'أضافة عميل جديد',
              Height: 60,
              onTap: () {
                AppNavigator.navigateTo(
                  context,
                  addDealerScreen(),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            CustomButon(
              text: 'أرصدة العملاء',
              Height: 60,
              onTap: () {
                AppNavigator.navigateTo(
                  context,
                  const dealersBalances(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
