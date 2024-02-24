import 'package:digital_ledger/screens/login_screen.dart';
import 'package:digital_ledger/utils/utils.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Transform.rotate(
                angle: -0.5,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: textSmall,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Business-A",
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Credit",
                            style: TextStyle(
                                color: credit,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "+20000",
                            style: TextStyle(
                                color: credit,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Transform.rotate(
                angle: 0.5,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: textSmall,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Business-B",
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Debit",
                            style: TextStyle(
                                color: debit,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "-10000",
                            style: TextStyle(
                                color: debit,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              const Text(
                "D I G I - L E D G E R",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      "A one place solution to manage transactions, ledger records, and balance of your business",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: textSmall),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Material(
                color: textSmall,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  splashColor: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 60,
                    width: 180,
                    decoration: BoxDecoration(
                        //  color: textSmall,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      "Get Started",
                      style: TextStyle(
                          fontSize: 22,
                          color: black,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
