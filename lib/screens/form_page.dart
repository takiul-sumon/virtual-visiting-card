import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_visiting_card/models/contact_model.dart';
import 'package:virtual_visiting_card/provider/contact_provider.dart';
import 'package:virtual_visiting_card/utils/helper_function.dart';

class FormPage extends StatefulWidget {
  static final String name = 'form-page';
  final ContactModel contactModel;
  const FormPage({super.key, required this.contactModel});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    companyController.dispose();
    designationController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    assignValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contactModel.name),
        actions: [
          IconButton(
            onPressed: () {
              saveContact();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 10,
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Proper Name';
                  }
                  return null;
                },
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

  void saveContact() async {
    if (_formkey.currentState!.validate()) {
      widget.contactModel.name = nameController.text;
      widget.contactModel.company = companyController.text;
      widget.contactModel.designation = designationController.text;
      widget.contactModel.email = emailController.text;
      widget.contactModel.mobile = mobileController.text;
      widget.contactModel.address = addressController.text;
    }
    Provider.of<ContactProvider>(context, listen: false)
        .insertContact(widget.contactModel)
        .then((value) {
          if (value > 0) {
            showMessage(context, 'saved');
          }
        })
        .catchError((error) {
          showMessage(context, 'Failed to Save');
        });
  }
}
