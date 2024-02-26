import "package:digital_ledger/screens/login_screen.dart";
import "package:digital_ledger/services/auth_services.dart";
import 'package:digital_ledger/utils/utils.dart';
import "package:digital_ledger/utils/validator.dart";
import "package:digital_ledger/widgets/custom_textfield.dart";
import "package:flutter/material.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final Validator validate = Validator();

  bool isPass = true;
  bool isLoading = false;

  void showPassword() {
    setState(() {
      isPass = !isPass;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var data = {
        "username": usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "totalBalance": 0,
        "totalCredit" : 0,
        "totalDebit" : 0,
      };
      String res = await AuthServices().createUser(data, context);
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackbar(res, context);
      } else {
         setState(() {
          isLoading = false;
        });
        showSnackbar(res, context);
       
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S I G N - U P"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "Create a new account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
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
                    label: "Email",
                    icon: Icons.email,
                    editingController: emailController,
                    type: TextInputType.emailAddress,
                    validator: validate.emailValidator),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  label: "Password",
                  icon: isPass ? Icons.visibility_off : Icons.visibility,
                  editingController: passwordController,
                  type: TextInputType.text,
                  validator: validate.passwordValidator,
                  isPass: isPass,
                ),

                TextButton(
                    onPressed: showPassword,
                    child: isPass
                        ? const Text("Show Password")
                        : const Text("Hide Password")),
                const SizedBox(
                  height: 10,
                ),
                Material(
                  color: textSmall,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: _submitForm,
                    splashColor: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 4, 103, 184),
                              ),
                            )
                          : const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ))
                  ],
                ),
                // const Spacer(flex: 2,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
