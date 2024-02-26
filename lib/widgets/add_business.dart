import 'package:digital_ledger/services/storage_services.dart';
import 'package:digital_ledger/utils/utils.dart';
import 'package:digital_ledger/utils/validator.dart';
import 'package:flutter/material.dart';

class AddBusiness extends StatefulWidget {
  const AddBusiness({super.key});

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController businessController = TextEditingController();
  bool isLoading = false;

  void _submitForm() async{
    if(_formKey.currentState!.validate()){
        setState(() {
          isLoading = true;
        });
        var data = {
          "businessName": businessController.text,
          "totalCredit" : 0,
          "totalDebit" : 0,
        };
        String res = await StorageServices().storeNewBusiness(data);
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
                  hintText: "Business Name", hintStyle: TextStyle(fontSize: 20),),
                  controller: businessController,
                  validator: Validator().emptyValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(
              height: 40,
            ),
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
                  child: isLoading? const Center(child: CircularProgressIndicator(
                    color: Colors.green,
                  ),):const Text(
                    "Add Business",
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
