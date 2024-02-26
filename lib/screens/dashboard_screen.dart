import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_ledger/screens/intro_screen.dart';
import 'package:digital_ledger/utils/utils.dart';
import 'package:digital_ledger/widgets/add_business.dart';
import 'package:digital_ledger/widgets/business_card.dart';
import 'package:digital_ledger/widgets/crdr_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isLogoutLoading = false;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  void logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    setState(() {
      isLogoutLoading = false;
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const IntroScreen()));
  }

  _showDialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          content: AddBusiness()
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 8, 40, 66),
        title: const Text(
          "Digi-Ledger",
          style: TextStyle(color: Color.fromARGB(247, 255, 255, 255)),
        ),
        actions: [
          IconButton(
            onPressed: logOut,
            icon: isLogoutLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:12.0),
        child: FloatingActionButton(
          onPressed: (){
            _showDialog(context);
          },
          child: const Icon(Icons.add),
          ),
      ),
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 8, 40, 66),
        child: SingleChildScrollView(
          child: BodyCard(userId: userId,),
        ),
      ),
    );
  }
}

class BodyCard extends StatelessWidget {
  BodyCard({
    super.key, required this.userId,
  });
  final String userId;

  @override
  Widget build(BuildContext context) {
      final Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance.collection("users").doc(userId).snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: _userStream,
       builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.hasError){
          return const Center(child: Text("Something went wrong"),);
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        var data = snapshot.data!.data() as Map<String, dynamic>;
        return ColumnCard(data:data, userId: userId,);
       });
  }
}

class ColumnCard extends StatelessWidget {
  final Map data;
  final String userId;
  const ColumnCard({
    super.key, required this.data, required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:12.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total Balance", style: TextStyle(fontSize: 20),),
              Text("Rs ${data["totalBalance"]}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                     CrDbCard(
                      cardColor: credit,
                      type: "Credit",
                      value: "Rs. ${data["totalCredit"]}",
                      icon: Icons.arrow_upward,
                      ),
                      CrDbCard(
                        cardColor: debit,
                        type: "Debit",
                        value: "Rs. ${data["totalDebit"]}",
                          icon: Icons.arrow_downward,
                        )
                ],
              ),
              BusinessCard(userId: userId,)
            ],
          ),
        )
      ],
    );
  }
}
