import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_ledger/screens/business_screen.dart';
import 'package:digital_ledger/utils/utils.dart';
import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  final String userId;
  const BusinessCard({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Businesses", style: TextStyle(color: Colors.black87, fontSize: 26, fontWeight: FontWeight.w700),),
          SizedBox(
           height: 510,
            child: BusinessList(userId: userId,)
          )
        ],
      ),
    );
  }
}

class BusinessList extends StatelessWidget {
  final String userId;
  const BusinessList({
    super.key, required this.userId,
  });

  @override
  Widget build(BuildContext context) {
      final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance.collection("users").doc(userId).collection("business").snapshots();
        return StreamBuilder<QuerySnapshot>(
      stream: _userStream,
       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return const Center(child: Text("Something went wrong"),);
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
          return const Center(child: Text("No Business found"),);
        }
        var data = snapshot.data!.docs;
        return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
        var businessData = data[index];
        return BusinessDetails(data: businessData);
      });
       });
   
  }
}

class BusinessDetails extends StatelessWidget {
  final dynamic data;
  const BusinessDetails({
    super.key, required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BusinessScreen(data: data)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
       margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 208, 207, 207),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              color: const Color.fromARGB(255, 93, 92, 92).withOpacity(0.09),
              blurRadius: 10,
              spreadRadius: 4
            )
          ]
        ),
        child: ListTile(
            title: Text(data["businessName"], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Rs. ${data["totalCredit"]}", style: TextStyle(color: credit, fontSize: 18),),
                Text("Rs. ${data["totalDebit"]}", style: TextStyle(color: debit, fontSize: 18),),
              ],
            ),
        ),
      ),
    );
  }
}