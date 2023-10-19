import 'package:alif_ios/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthDialog extends StatefulWidget {
  const AuthDialog({Key? key}) : super(key: key);

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  bool showOtp = false;
  String? error;
  final regNumExp = RegExp(r'(^(?:[+0]9)?[0-9]{7,12}$)');
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Sign In"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  hintText: "Mobile Number",
                  prefixText: "+91",
                ),
                validator: (value) =>
                    value!.length < 7 || !regNumExp.hasMatch(value)
                        ? "This is required"
                        : null,
              ),
            ),
            if (showOtp)
              ListTile(
                title: TextFormField(
                  controller: otpController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    hintText: "OTP",
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? "This is required" : null,
                ),
              ),
            ListTile(
              title: Center(
                child: isLoading
                    ? const SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: FloatingActionButton(
                            child: Icon(showOtp
                                ? Icons.check
                                : Icons.arrow_forward_rounded),
                            onPressed: () async {
                              try {
                                error = null;
                                setState(() {});
                                if (!showOtp) {
                                  //verify
                                  final sentOtp = await AuthService.instance
                                      .sendOtp("+91${phoneController.text}");
                                  if (sentOtp) {
                                    showOtp = true;
                                  }
                                  setState(() {});
                                } else {
                                  // send otp
                                  final verifyOtp = await AuthService.instance
                                      .verifyOtp(otpController.text);
                                  if (verifyOtp) {
                                    Navigator.pop(context);
                                  }
                                }
                              } catch (e) {
                                error = e.toString();
                                setState(() {});
                              }
                            },
                          ),
                          onLongPress: () {
                            AuthService.instance.createUser(phoneController.text);
                          },
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
      actions: [
        if (error != null)
          ListTile(
            title: Text(
              error.toString(),
              style: const TextStyle(color: Colors.redAccent),
            ),
          )
      ],
    );
  }
}
