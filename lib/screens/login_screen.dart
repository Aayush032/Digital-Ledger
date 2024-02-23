import 'package:digital_ledger/utils/colors.dart';
import 'package:digital_ledger/utils/validator.dart';
import 'package:digital_ledger/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Validator validate = Validator();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "L O G I N",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical:8, horizontal: 12),
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                CustomTextField(
                    label: "Username",
                    icon: Icons.person,
                    editingController: usernameController,
                    type: TextInputType.text,
                    validator: validate.usernameValidator),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    label: "Password",
                    icon: Icons.lock,
                    editingController: passwordController,
                    type: TextInputType.text,
                    validator: validate.passwordValidator),
                const SizedBox(
                  height: 50,
                ),
                Material(
                  color: textSmall, 
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: (){},
                    splashColor: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                       
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                          child: Text(
                        "Login",
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                      )),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?", style: TextStyle(fontSize: 18),),
                    TextButton(onPressed: (){},
                     child: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),))
                  ],
                ),
                const Spacer(flex: 2,)
              ],
            ),
          )),
    );
  }
}
