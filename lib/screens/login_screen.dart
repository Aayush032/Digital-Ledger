import 'package:digital_ledger/screens/dashboard_screen.dart';
import 'package:digital_ledger/screens/sign_up_screen.dart';
import 'package:digital_ledger/services/auth_services.dart';
import 'package:digital_ledger/utils/utils.dart';
import 'package:digital_ledger/utils/validator.dart';
import 'package:digital_ledger/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Validator validate = Validator();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPass = true;
  bool isLoading = false;

  void _submitForm() async{
    if(_formKey.currentState!.validate()){
      setState(() {
        isLoading = true;
      });
      var data = {
         "email": emailController.text,
        "password": passwordController.text,
      };
      String res = await AuthServices().loginUser(data, context);
      if(res == "success"){
        setState(() {
          isLoading = false;
        });
        showSnackbar(res, context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> DashboardScreen()));
      }
      else{
         setState(() {
          isLoading = false;
        });
        showSnackbar(res, context);
      }
    }
  }

  void showPassword(){
   setState(() {
     isPass = !isPass;
   });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "D I G I - L E D G E R",
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
                //const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(bottom:18.0, top: 8),
                  child: Text("Login to your account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
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
                    icon: isPass? Icons.visibility_off : Icons.visibility,
                    editingController: passwordController,
                    type: TextInputType.text,
                    validator: validate.passwordValidator,
                    isPass: isPass,),
                    //const SizedBox(height: 10,),
                 TextButton(onPressed: showPassword, child: isPass?const Text("Show Password"): const Text("Hide Password")),
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
                      child: isLoading?
                      const Center(child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 4, 103, 184),
                      ),)
                      :const Center(
                          child: Text(
                        "Login",
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                      )),
                    ),
                  ),
                ),
                 
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?", style: TextStyle(fontSize: 18),),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SignUpScreen()));
                    },
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
