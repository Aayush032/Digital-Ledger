import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_ledger/utils/utils.dart';
import 'package:digital_ledger/widgets/add_transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BusinessScreen extends StatelessWidget {
  final dynamic data;
  const BusinessScreen({super.key, required this.data});

  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: AddTransaction(
              businessId: data["businessId"],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${data["businessName"]}"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 8, 40, 66),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialog(context);
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          color: Colors.white70,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 26,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: credit,
                          size: 30,
                        ),
                        Icon(
                          Icons.arrow_downward,
                          color: debit,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.819,
                  child: SingleTransaction(
                    businessId: data["businessId"],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class SingleTransaction extends StatelessWidget {
  final String businessId;
  const SingleTransaction({
    super.key,
    required this.businessId,
  });

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("business")
        .doc(businessId)
        .collection("transaction")
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _userStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Transactions found",
                style: TextStyle(color: Colors.black87),
              ),
            );
          }
          var data = snapshot.data!.docs;
          return ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var transactionData = data[index];
                return TransactionCard(
                  data: transactionData,
                );
              });
        });
  }
}

class TransactionCard extends StatelessWidget {
  final dynamic data;
  const TransactionCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100,
      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 208, 207, 207),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                color: const Color.fromARGB(255, 93, 92, 92).withOpacity(0.09),
                blurRadius: 10,
                spreadRadius: 4)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${data["transactionName"]}",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 22),
              ),
              const Icon(
                Icons.delete,
                color: Color.fromARGB(255, 132, 13, 5),
              )
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMd().format(data["datePublished"].toDate()),
                style: const TextStyle(color: Colors.black87),
              ),
              Row(
                children: [
                  Icon(data["type"]=="credit"?Icons.arrow_upward:Icons.arrow_downward, color:data["type"] == "credit" ? credit : debit,),
                  Text(
                    "${data["amount"]}",
                    style: TextStyle(
                        color: data["type"] == "credit" ? credit : debit,
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                        ),
                  ),
                ],
              )
            ],
          ),
          // subtitle: Text(
          // DateFormat.yMMMd().format(data["datePublished"].toDate()),
          // style: const TextStyle(color: Colors.black87),
          // ),
          // trailing: Column(
          //   //  mainAxisAlignment: MainAxisAlignment.,
          //   children: [
          //     Icon(
          //       Icons.delete,
          //       color: Colors.red[800],
          //     ),
          //     //const SizedBox(height: 10,),
          //     Text(
          //       "${data["amount"]}",
          //       style: TextStyle(color: data["type"] == "credit"?credit: debit, fontSize: 22),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
