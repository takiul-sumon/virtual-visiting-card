// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContactModel {
  int id;
  String name;
  String mobile;
  String address;
  String company;
  String designation;
  String website;
  String image;
  String favorite;
  String email;
  ContactModel({
    this.id = -1,
    required this.name,
    required this.mobile,
    this.address = '',
    this.company = '',
    this.designation = '',
    this.website = '',
    this.image = '',
    this.favorite = '',
    this.email = '',
  });
}
