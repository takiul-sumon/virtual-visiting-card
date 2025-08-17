import 'package:flutter/material.dart';
import 'package:virtual_visiting_card/models/contact_model.dart';

class FormPage extends StatefulWidget {
  static final String name = 'form-page';
  final ContactModel contactModel;
  const FormPage({super.key, required this.contactModel});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  GlobalKey _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  void assignValue() {
    nameController.text = widget.contactModel.name;
    emailController.text = widget.contactModel.email;
    mobileController.text = widget.contactModel.mobile;
    companyController.text = widget.contactModel.company;
    designationController.text = widget.contactModel.designation;
    addressController.text = widget.contactModel.address;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    companyController.dispose();
    designationController.dispose();
    addressController.dispose();
  }

  @override
  void initState() {
    super.initState();
    assignValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.contactModel.name)),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 10,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(borderSide: BorderSide(width: 3)),
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderSide: BorderSide(width: 3)),
                ),
              ),
              TextFormField(
                controller: mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile',
                  border: OutlineInputBorder(borderSide: BorderSide(width: 3)),
                ),
              ),
              TextFormField(
                controller: companyController,
                decoration: InputDecoration(
                  labelText: 'Company',
                  border: OutlineInputBorder(borderSide: BorderSide(width: 3)),
                ),
              ),
              TextFormField(
                controller: designationController,
                decoration: InputDecoration(
                  labelText: 'Designation',
                  border: OutlineInputBorder(borderSide: BorderSide(width: 3)),
                ),
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 3)),
                  labelText: 'Address',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
