const String tableContact = 'tbl_contact';
const String tblContactColId = 'id';
const String tblContactColCompany = 'company';
const String tblContactColemail = 'email';
const String tblContactColname = 'name';
const String tblContactColmobile = 'mobile';
const String tblContactColaddress = 'address';
const String tblContactColdesignation = 'designation';
const String tblContactColwebsite = 'website';
const String tblContactColimage = 'image';
const String tblContactColfavorite = 'favorite';

class ContactModel {
  int id;
  String name;
  String mobile;
  String address;
  String company;
  String designation;
  String website;
  String image;
  bool favorite;
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
    this.favorite = false,
    this.email = '',
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblContactColname: name,
      tblContactColCompany: company,
      tblContactColemail: email,
      tblContactColdesignation: designation,
      tblContactColimage: image,
      tblContactColwebsite: website,
      tblContactColfavorite: favorite ? 1 : 0,
    };
    if (id > 0) {
      map[tblContactColId] = id;
    }
    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> toMap) => ContactModel(
    name: toMap[tblContactColname],
    mobile: toMap[tblContactColmobile],
    address: toMap[tblContactColaddress],
    company: toMap[tblContactColCompany],
    designation: toMap[tblContactColdesignation],
    email: toMap[tblContactColemail],
    website: toMap[tblContactColCompany],
    image: toMap[tblContactColimage],
    favorite: toMap[tblContactColfavorite] == 1 ? true : false,
  );
}
