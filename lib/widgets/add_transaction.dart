import 'package:digital_ledger/services/storage_services.dart';
import 'package:digital_ledger/utils/utils.dart';
import 'package:digital_ledger/utils/validator.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  final String businessId;
  const AddTransaction({super.key, required this.businessId});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   final TextEditingController transactionController = TextEditingController();

   final TextEditingController amountController = TextEditingController();

   var type = "credit";
    bool isLoading = false;

  void _submitForm() async{
    if(_formKey.currentState!.validate()){
        setState(() {
          isLoading = true;
        });
        var transactionData = {
          "businessId" : widget.businessId,
          "transactionName" : transactionController.text,
          "amount" : amountController.text,
          "type" : type,
          "datePublished": DateTime.now(),
        };
      //  var data = businessController.text;
        String res = await StorageServices().storeNewTransaction(transactionData);
        setState(() {
          isLoading = false;
          Navigator.of(context).pop();
        });
        if(res == "success"){
          showSnackbar(res, context);
        }
        else{
          showSnackbar(res, context);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Transaction Name"
              ),
              controller: transactionController,
              validator: Validator().emptyValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 20,),
                TextFormField(
              decoration: const InputDecoration(
                hintText: "Amount",
              ),
              controller: amountController,
              validator: Validator().emptyValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
            ),
             const SizedBox(height: 20,),
            DropdownButtonFormField(
              value: "credit",
              items: const [
                DropdownMenuItem(value: "credit",child: Text("Credit"),),
                DropdownMenuItem(value: "debit",child: Text("Debit"),),
              ],
             onChanged: (value){
              if(value != null){
                setState(() {
                  type = value;
                });
              }
             },
             ),
             const SizedBox(height: 30,),
              Material(
              color: textSmall,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
              onTap: _submitForm,
                splashColor: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  //margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)),
                  child: isLoading?const Center(child: CircularProgressIndicator(color: Colors.blueAccent,),) :const Text(
                    "Add Transaction",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        ),
        ),
    );
  }
}