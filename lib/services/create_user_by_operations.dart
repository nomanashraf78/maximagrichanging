import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maximagri/models/credit_model/dealer_credit_model.dart';
import 'package:maximagri/models/user_profile_model/user_profile_model.dart';
import 'package:maximagri/utilities/user_authentication.dart';
import 'package:maximagri/widgets/show_dialog_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateUserByOperations extends StatefulWidget {
  const CreateUserByOperations({Key? key}) : super(key: key);

  @override
  State<CreateUserByOperations> createState() => _CreateUserByOperationsState();
}

class _CreateUserByOperationsState extends State<CreateUserByOperations> {
  String dropdownUserType = '-SELECT USER ACCOUNT-';
  List<String> userTypeList = [
    '-SELECT USER ACCOUNT-',
    'ZONAL MANAGER',
    'SALES MANAGER',
    'SALES OFFICER',
    'CREATE DEALER',
    'CREATE FRANCHISE'
  ];

  String dropdownZonalManager = '-SELECT ZONAL MANAGER-';
  String dropdownSalesManager = '-SELECT SALES MANAGER-';
  String dropdownSalesOfficer = '-SELECT SALES OFFICER-';

  List<String> zonalManagerList = ['-SELECT ZONAL MANAGER-'];
  List<String> salesManagerList = ['-SELECT SALES MANAGER-'];
  List<String> salesOfficerList = ['-SELECT SALES OFFICER-'];

  List<String> zonalManagerUIDList = ['none'];
  List<String> salesManagerUIDList = ['none'];
  List<String> salesOfficerUIDList = ['none'];

  String dropdownProvince = '-SELECT PROVINCE-';
  String dropdownDistrict = '-SELECT DISTRICT-';
  String dropdownTehsil = '-SELECT TEHSIL-';

  List<String> provinceList = [
    '-SELECT PROVINCE-',
    'Khyber Pakhtunkhwa',
    'Punjab',
    'Baluchistan',
    'Sindh',
    'Islamabad',
    'Gilgit Baltistan',
    'Azad Kashmir',
  ];
  List<String> districtList = ['-SELECT DISTRICT-', 'DISTRICT'];
  List<String> tehsilList = [
    '-SELECT TEHSIL-',
    'Abbottabad',
    'Havelian',
    'Attock',
    'Fateh Jang',
    'Hassan Abdal',
    'Hazro',
    'Jand',
    'Pindi Gheb',
    'Awaran',
    'Gishkore',
    'Jhal Jao',
    'Mashkai',
    'Badin',
    'Golarchi (Shaheed Fazal Rahu)',
    'Matli',
    'Talhar',
    'Tando Bago',
    'Bahawalnagar',
    'Chishtian',
    'Fort Abbas'
        'Haroonabad',
    'Minchinabad',
    'Ahmadpur East',
    'Bahawalpur City',
    'Bahawalpur Saddar',
    'Hasilpur',
    'Khairpur Tamewali',
    'Yazman',
    'Barang',
    'Bar Chamer Kand',
    'Khar Bajaur',
    'Mamund',
    'Nawagai',
    'Salarzai',
    'Utmankhel (Qzafi)',
    'Bannu',
    'Domel',
    'Barkhan',
    'Allai',
    'Batagram',
    'Bhakkar',
    'Darya Khan',
    'Kalur Kot',
    'Mankera',
    'Daggar/Buner',
    'Gagra',
    'Khado Khel',
    'Mandanr',
    'Chagai',
    'Dalbandin',
    'Nokundi',
    'Taftan',
    'Chakwal',
    'Choa Saidan Shah',
    'Kallar Kahar',
    'Lawa',
    'Talagang',
    'Charsadda',
    'Shabqadar',
    'Tangi',
    'Bhawana',
    'Chiniot',
    'Lalian',
    'Chitral',
    'Mastuj',
    'Dadu',
    'Johi',
    'Khairpur Nathan Shah',
    'Mehar',
    'Baiker',
    'Dera Bugti',
    'Loti',
    'Malam',
    'Phelawagh',
    'Pir Koh',
    'Sangsillah',
    'Sui',
    'Fort Munro',
    'Dera Ghazi Khan (D.G. Khan)',
    'Kot Chutta',
    'Taunsa',
    'Daraban',
    'Dera Ismail Khan (D.I. Khan)',
    'Kulachi',
    'Paharpur',
    'Paroa',
    'Chak Jhumra',
    'Faisalabad City',
    'Faisalabad Saddar',
    'Jaranwala',
    'Samundri',
    'Tandlianwala',
    'Daharki',
    'Ghotki',
    'Khangarh',
    'Mirpur Mathelo',
    'Ubauro',
    'Gujranwala City',
    'Gujranwala Saddar',
    'Kamoki',
    'Nowshera Virkan',
    'Wazirabad',
    'Gujrat',
    'Kharian',
    'Sarai Alamgir',
    'Gwadar',
    'Jiwani',
    'Ormara',
    'Pasni',
    'Suntsar',
    'Hafizabad',
    'Pindi Bhattian',
    'Hangu',
    'Tall',
    'Ghazi',
    'Haripur',
    'Harnai',
    'Khoast',
    'Shahrig',
    'Hyderabad',
    'Hyderabad City',
    'Latifabad',
    'Qasimabad',
    'Islamabad',
    'Garhi Khairo',
    'Jacobabad',
    'Thul',
    'Gandhaka',
    'Jhat Pat',
    'Usta Muhammad',
    'Kotri',
    'Manjhand',
    'Sehwan',
    'Thano Bula Khan',
    'Gandawa',
    'Jhal Magsi',
    'Mirpur',
    '18 Hazari',
    'Ahmadpur Sial',
    'Jhang',
    'Shorkot',
    'Dina',
    'Jhelum',
    'Pind Dadan Khan',
    'Sohawa',
    'Balanari',
    'Bhag',
    'Dhadar',
    'Khattan',
    'Mach',
    'Sanni',
    'Gazg',
    'Johan',
    'Kalat',
    'Mangochar',
    'Surab',
    'Gulberg',
    'Liaquatabad',
    'Nazimabad',
    'New Karachi',
    'North Nazimabad',
    'Ferozabad',
    'Gulshan-e-Iqbal',
    'Gulzar-e-Hijri',
    'Jamshed Quarters',
    'Aram Bagh',
    'Civil Line',
    'Garden',
    'Lyari',
    'Saddar',
    'Baldia',
    'Harbour',
    'Mango Pir',
    'Mauripur',
    'Mominabad',
    'Orangi',
    'Sindh Industrial Trading Estate (SITE)',
    'Banda Daud Shah',
    'Karak',
    'Takht-e-Nasriti',
    'Kandhkot',
    'Kashmore',
    'Tangwani',
    'Chunian',
    'Kasur',
    'Kot Radha Kishan',
    'Pattoki',
    'Balnigor',
    'Buleda',
    'Dasht',
    'Hoshab',
    'Kech (Turbat)',
    'Mand',
    'Tump',
    'Zamuran',
    'Faiz Ganj',
    'Gambat',
    'Khairpur',
    'Kingri',
    'Kot Diji',
    'Mirwah',
    'Nara',
    'Sobho Dero',
    'Jehanian',
    'Kabirwala',
    'Khanewal',
    'Mian Channu',
    'Kharan',
    'Sar Kharan',
    'Tohumulk',
    'Khushab',
    'Nowshera',
    'Nurpur',
    'Quaidabad',
    'Aranji',
    'Karakh',
    'Khuzdar',
    'Moola',
    'Nal',
    'Ornach',
    'Saroona',
    'Wadh',
    'Zehri',
    'Chaman',
    'Dobandi',
    'Gulistan',
    'Killa Abdullah',
    'Baddini',
    'Kan Mehtarzai',
    'Killa Saifullah',
    'Loiband',
    'Muslim Bagh',
    'Shinki',
    'Kohat',
    'Lachi',
    'Dassu',
    'Kandia',
    'Palas',
    'Pattan',
    'Grisani',
    'Kahan',
    'Kohlu',
    'Mawand',
    'Tamboo',
    'Korangi',
    'Landhi',
    'Model Colony',
    'Shah Faisal',
    'Central Kurram Frontier Region',
    'Lower Kurram',
    'Upper Kurram',
    'Lahore Cantonment',
    'Lahore City',
    'Model Town',
    'Riawand',
    'Shalimar',
    'Lakki Marwat',
    'Naurang',
    'Bakrani',
    'Dokri',
    'Larkana',
    'Ratodero',
    'Bela',
    'Dureji',
    'Gadani',
    'Hub',
    'Kanraj',
    'Lakhra',
    'Liari',
    'Sonmiani/Winder',
    'Uthal',
    'Chaubara',
    'Karor Lal Esan',
    'Layyah',
    'Dunyapur',
    'Kahror Pacca',
    'Lodhran',
    'Duki',
    'Loralai Bori',
    'Mekhtar',
    'Adenzai',
    'Lal Qilla',
    'Samarbagh (Barwa)',
    'Timergara',
    'Sam Ranizai',
    'Swat Ranizai',
    'Airport',
    'Bin Qasim',
    'Gadap',
    'Ibrahim Hyderi',
    'Murad Memon',
    'Shah Mureed',
    'Malakwal',
    'Mandi Bahauddin',
    'Phalia',
    'Balakot',
    'Mansehra',
    'Oghi',
    'Katlang',
    'Mardan',
    'Takht Bhai',
    'Dasht',
    'Khad Koocha',
    'Kirdgap',
    'Mastung',
    'Hala',
    'Matiari',
    'Saeedabad',
    'Isakhel',
    'Mianwali',
    'Piplan',
    'Digri',
    'Hussain Bux Mari',
    'Jhudo',
    'Kot Ghulam Muhammad',
    'Mirpur Khas',
    'Shujaabad',
    'Sindhri',
    'Halimzai',
    'Pindiali',
    'Pringhar',
    'Safi',
    'Upper Mohmand',
    'Utman Khel (Ambar)',
    'Yake Ghund',
    'Jalalpur Pirwala',
    'Multan City',
    'Multan Saddar',
    'Shujabad',
    'Drug',
    'Kingri',
    'Musakhel',
    'Alipur',
    'Jatoi',
    'Kot Addu',
    'Muzaffargarh',
    'Nankana Sahib',
    'Sangla Hill',
    'Shahkot',
    'Narowal',
    'Shakargarh',
    'Zafarwal',
    'Baba Kot',
    'Chattar',
    'D.M. Jamali',
    'Tamboo',
    'Bhiria',
    'Kandiaro',
    'Mehrabpur',
    'Moro',
    'Naushahro Feroze',
    'Datta Khel',
    'Dossali',
    'Garyum',
    'Ghulam Khan',
    'Mir Ali',
    'Miran Shah',
    'Razmak',
    'Shewa',
    'Spinwam',
    'Jehangira',
    'Nowshera',
    'Pabbi',
    'Nushki',
    'Depalpur',
    'Okara',
    'Renala Khurd',
    'Central',
    'Ismailzai',
    'Lower',
    'Upper',
    'Arifwala',
    'Pakpattan',
    'Gichk',
    'Gowargo',
    'Panjgur',
    'Parome',
    'Peshawar',
    'Barshore',
    'Hurramzai',
    'Karezat',
    'Pishin',
    'Saranan',
    'Kambar Ali Khan',
    'Miro Khan',
    'Nasirabad',
    'Qubo Saeed Khan',
    'Shahdadkot',
    'Sujawal Junejo',
    'Warah',
    'Panj Pai',
    'Quetta City',
    'Quetta Sadar',
    'Khanpur',
    'Liaquatpur',
    'Rahim Yar Khan',
    'Sadiqabad',
    'Jampur',
    'Rajanpur',
    'Rojhan',
    'Gujar Khan',
    'Kahuta',
    'Kallar Sayyedan',
    'Kotli Sattian',
    'Murree',
    'Rawalpindi',
    'Taxila',
    'Chichawatni',
    'Sahiwal',
    'Jam Nawaz Ali',
    'Khipro',
    'Sanghar',
    'Shahdadpur',
    'Sinjhoro',
    'Tando Adam',
    'Bhalwal',
    'Bhera',
    'Kot Momin',
    'Sahiwal',
    'Sargodha',
    'Shahpur',
    'Sillanwali',
    'Daur',
    'Kazi Ahmed (Daulatpur)',
    'Nawabshah',
    'Sakrand',
    'Alpuri',
    'Besham',
    'Puran',
    'Sheerani (Sherani)',
    'Ferozewala',
    'Muridke',
    'Safdarabad',
    'Sharkpur',
    'Sheikhupura',
    'Garhi Yasin',
    'Khanpur',
    'Lakhi',
    'Shikarpur',
    'Daska',
    'Pasrur',
    'Sambrial',
    'Sialkot',
    'Kotmandai',
    'Lehri',
    'Sangan',
    'Sibi',
    'Faridabad',
    'Sanhri',
    'Sohbatpur',
    'Birmal',
    'Ladha',
    'Makin (Charlai)',
    'Sararogha',
    'Sarwekai',
    'Tiarza',
    'Toi Khullah',
    'Wana',
    'Jati',
    'Kharo Chan',
    'Mirpur Bathoro',
    'Shah Bunder',
    'Sujawal',
    'New Sukkur',
    'Pano Aqil',
    'Rohri',
    'Salehpat',
    'Sukkur City',
    'Lahor',
    'Rzzar',
    'Swabi',
    'Topi',
    'Babuzai',
    'Bari Kot',
    'Behrain',
    'Charbagh',
    'Kabal',
    'Khawaza Khela',
    'Matta',
    'Chamber',
    'Jhando Mari',
    'Tando Allahyar',
    'Bulri Shah Karim',
    'Tando Ghulam Hyder',
    'Tando Muhammad Khan',
    'Tank',
    'Chachro',
    'Dahli',
    'Diplo',
    'Islamkot',
    'Kaloi',
    'Mithi',
    'Nagar Parkar',
    'Ghorabari',
    'Keti Bunder',
    'Mirpur Sakro',
    'Thatta',
    'Gojra',
    'Kamalia',
    'Pir Mahal',
    'Toba Tek Singh',
    'Judba',
    'Khander',
    'Kunri',
    'Pithoro',
    'Samaro',
    'Umerkot',
    'Dir',
    'Shringal',
    'Wari',
    'Burewala',
    'Mailsi',
    'Vehari',
    'Besima',
    'Musakhel',
    'Nag',
    'Shahoo Garhi',
    'Washuk',
    'Ashwat',
    'Kashatoo',
    'Qamar Din Karez',
    'Sambaza',
    'Zhob',
    'Sinjawi',
    'Ziarat',
    'Khaplu',
    'Mashabrum',
    'Gultari',
    'Kharmang',
    'Rondu',
    'Shigar',
    'Skardu',
    'Astore',
    'Shounter',
    'Babu Sar',
    'Chilas',
    'Darel',
    'Tangir',
    'Gahkoch',
    'Ishkoman',
    'Punial',
    'Gupis',
    'Yasin',
    'Danyour',
    'Gilgit',
    'Juglot',
    'Ali Abad'
        'Gojal',
    'Nagar-I',
    'Nagar-II',
    'Kotli',
    'Khuiratta',
    'Fatehpur Thakiala',
    'Sehnsa',
    'Charhoi',
    'Duliah Jattan',
    'Dadyal',
    'Mirpur',
    'Bhimber',
    'Barnala',
    'Samahni',
    'Hattian Bala',
    'Chikkar',
    'Leepa',
    'Muzaffarabad',
    'Nasirabad',
    'Athmuqam',
    'Sharda',
    'Bagh',
    'Dhirkot',
    'Hari Ghel',
    'Rera',
    'Birpani',
    'Haveli',
    'Khurshidabad',
    'Mumtazabad',
    'Abbaspur',
    'Hajira',
    'Rawalakot',
    'Thorar',
    'Balouch',
    'Mang',
    'Pallandri',
    'Tarar Khel',
    'Bara',
    'Jamrud',
    'Landi Kotal',
    'Mula Ghori',
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController creditController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ntnController = TextEditingController();
  TextEditingController isFilerController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  getZonalMangersList() async {
    dropdownZonalManager = '-SELECT ZONAL MANAGER-';
    zonalManagerList = ['-SELECT ZONAL MANAGER-'];
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('userProfile')
          .where('userType', isEqualTo: 'zonalManager')
          .get();
      for (int i = 0; i < snapshot.docs.length; i++) {
        final json = snapshot.docs[i].data();
        final userProfile = UserProfile.fromJson(json);
        zonalManagerList.add(userProfile.userName);
        zonalManagerUIDList.add(userProfile.userUID);
      }
      setState(() {});
    } catch (e) {
      showMessageDialog(message: e.toString(), context: context);
    }
  }

  getSalesMangersList(String zonalUID) async {
    salesManagerList = ['-SELECT SALES MANAGER-'];
    salesManagerUIDList = ['none'];
    dropdownSalesManager = '-SELECT SALES MANAGER-';

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('userProfile')
          .where('userType', isEqualTo: 'salesManager')
          .where('zonalManagerUID', isEqualTo: zonalUID)
          .get();
      for (int i = 0; i < snapshot.docs.length; i++) {
        final json = snapshot.docs[i].data();
        final userProfile = UserProfile.fromJson(json);
        salesManagerList.add(userProfile.userName);
        salesManagerUIDList.add(userProfile.userUID);
      }
      setState(() {});
    } catch (e) {
      showMessageDialog(message: e.toString(), context: context);
    }
  }

  getSalesOfficersList(String managerUID) async {
    salesOfficerList = ['-SELECT SALES OFFICER-'];
    salesOfficerUIDList = ['none'];
    dropdownSalesOfficer = '-SELECT SALES OFFICER-';
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('userProfile')
          .where('userType', isEqualTo: 'salesOfficer')
          .where('salesManagerUID', isEqualTo: managerUID)
          .get();
      for (int i = 0; i < snapshot.docs.length; i++) {
        final json = snapshot.docs[i].data();
        final userProfile = UserProfile.fromJson(json);
        salesOfficerList.add(userProfile.userName);
        salesOfficerUIDList.add(userProfile.userUID);
      }
      setState(() {});
    } catch (e) {
      showMessageDialog(message: e.toString(), context: context);
    }
  }

  getProvinceDistricts(String province) {
    districtList = ['-SELECT DISTRICT-', 'DISTRICT'];
    dropdownDistrict = '-SELECT DISTRICT-';
    if (province == 'Khyber Pakhtunkhwa') {
      districtList = [
        '-SELECT DISTRICT-',
        'Abbottabad',
        'Bajaur',
        'Bannu',
        'Batagram',
        'Buner',
        'Charsadda',
        'Chitral',
        'Dera Ismail Khan',
        'Hangu',
        'Haripur',
        'Karak',
        'Kohat',
        'Kohistan (Lower Kohistan - Upper Kohistan)',
        'Kurram',
        'Lakki Marwat',
        'Lower Dir',
        'Malakand Protected Area',
        'Mansehra',
        'Mardan',
        'Mohmand',
        'North Waziristan',
        'Nowshera',
        'Orakzai',
        'Peshawar',
        'Shangla',
        'South Waziristan',
        'Swabi',
        'Swat',
        'Tank',
        'Tor Ghar (Kala Dhaka)',
        'Upper Dir',
        'Khyber'
      ];
    } else if (province == 'Punjab') {
      districtList = [
        '-SELECT DISTRICT-',
        'Attock',
        'Bahawalnagar',
        'Bahawalpur',
        'Bhakkar',
        'Chakwal',
        'Chiniot',
        'Dera Ghazi Khan',
        'Faisalabad',
        'Gujranwala',
        'Gujrat',
        'Hafizabad',
        'Jhang',
        'Jhelum',
        'Kasur',
        'Khanewal',
        'Khushab',
        'Lahore',
        'Layyah',
        'Lodhran',
        'Mandi Bahauddin',
        'Mianwali',
        'Multan',
        'Muzaffargarh',
        'Nankana Sahib',
        'Narowal',
        'Okara',
        'Pakpattan',
        'Rahim Yar Khan',
        'Rajanpur',
        'Rawalpindi',
        'Sahiwal',
        'Sargodha',
        'Sheikhupura',
        'Sialkot',
        'Toba Tek Singh',
        'Vehari',
      ];
    } else if (province == 'Baluchistan') {
      districtList = [
        '-SELECT DISTRICT-',
        'Awaran',
        'Barkhan',
        'Chagai',
        'Dera Bugti',
        'Gwadar',
        'Harnai',
        'Jaffarabad',
        'Jhal Magsi',
        'Kachhi ',
        'Kalat',
        'Kech',
        'Kharan',
        'Khuzdar',
        'Killa Abdullah',
        'Killa Saifullah',
        'Kohlu',
        'Lasbela',
        'Loralai',
        'Mastung',
        'Musakhel',
        'Nasirabad',
        'Nushki',
        'Panjgur',
        'Pishin',
        'Quetta',
        'Sheerani (Sherani)',
        'Sibi',
        'Sohbatpur',
        'Washuk',
        'Zhob',
        'Ziarat',
      ];
    } else if (province == 'Sindh') {
      districtList = [
        '-SELECT DISTRICT-',
        'Badin',
        'Dadu',
        'Ghotki',
        'Hyderabad',
        'Jacobabad',
        'Jamshoro',
        'Karachi Central',
        'Karachi East',
        'Karachi South',
        'Karachi West',
        'Kashmore',
        'Khairpur',
        'Korangi',
        'Larkana',
        'Malir',
        'Matiari',
        'Mirpur Khas',
        'Naushahro Feroze',
        'Qambar Shahdadkot',
        'Sanghar',
        'Shaheed Benazir Abad (Nawabshah)',
        'Shikarpur',
        'Sujawal',
        'Sukkur',
        'Tando Allahyar',
        'Tando Muhammad Khan',
        'Tharparkar',
        'Thatta',
        'Umerkot',
      ];
    } else if (province == 'Islamabad') {
      districtList = [
        '-SELECT DISTRICT-',
        'Islamabad',
      ];
    } else if (province == 'Gilgit Baltistan') {
      districtList = [
        '-SELECT DISTRICT-',
        'Ghanche',
        'Skardu',
        'Astore',
        'Diamir',
        'Darel',
        'Tangir',
        'Ghizer',
        'Gupis-Yasin',
        'Gilgit',
        'Hunza-Nagar',
      ];
    } else if (province == 'Azad Kashmir') {
      districtList = [
        '-SELECT DISTRICT-',
        'Kotli',
        'Mirpur',
        'Bhimber',
        'Hattian Bala',
        'Muzaffarabad',
        'Neelum',
        'Bagh',
        'Haveli',
        'Poonch',
        'Sudhnoti',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'CREATE NEW USER ACCOUNT',
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 27),
          ),
          const SizedBox(height: 15),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'SELECT USER',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          const SizedBox(height: 15),
          DropdownButtonFormField(
            isExpanded: true,
            value: dropdownUserType,
            onChanged: (String? newValue) {
              dropdownUserType = newValue!;

              if (dropdownUserType != '-SELECT USER ACCOUNT-' &&
                  dropdownUserType != 'ZONAL MANAGER') {
                getZonalMangersList();
              }
              setState(() {});
            },
            items: userTypeList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 15),
          dropdownUserType == 'SALES MANAGER' ||
                  dropdownUserType == 'SALES OFFICER' ||
                  dropdownUserType == 'CREATE DEALER'
              ? const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'SELECT MANAGER',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                )
              : const SizedBox(),
          dropdownUserType == 'SALES MANAGER' ||
                  dropdownUserType == 'SALES OFFICER' ||
                  dropdownUserType == 'CREATE DEALER'
              ? DropdownButtonFormField(
                  isExpanded: true,
                  value: dropdownZonalManager,
                  onChanged: (String? newValue) {
                    dropdownZonalManager = newValue!;
                    if (dropdownUserType != '-SELECT USER ACCOUNT-' &&
                        dropdownUserType != 'ZONAL MANAGER' &&
                        dropdownUserType != 'SALES MANAGER' &&
                        dropdownZonalManager != '-SELECT ZONAL MANAGER-') {
                      for (int i = 0; i < zonalManagerList.length; i++) {
                        if (zonalManagerList[i] == dropdownZonalManager) {
                          getSalesMangersList(zonalManagerUIDList[i]);
                        }
                      }
                    }
                    setState(() {});
                  },
                  items: zonalManagerList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          (dropdownUserType == 'SALES OFFICER' ||
                      dropdownUserType == 'CREATE DEALER') &&
                  dropdownZonalManager != '-SELECT ZONAL MANAGER-'
              ? DropdownButtonFormField(
                  isExpanded: true,
                  value: dropdownSalesManager,
                  onChanged: (String? newValue) {
                    dropdownSalesManager = newValue!;
                    if (dropdownUserType != '-SELECT USER ACCOUNT-' &&
                        dropdownUserType != 'ZONAL MANAGER' &&
                        dropdownUserType != 'SALES MANAGER' &&
                        dropdownUserType != 'SALES OFFICER' &&
                        dropdownSalesManager != '-SELECT SALES MANAGER-') {
                      for (int i = 0; i < salesManagerList.length; i++) {
                        if (salesManagerList[i] == dropdownSalesManager) {
                          getSalesOfficersList(salesManagerUIDList[i]);
                        }
                      }
                    }
                    setState(() {});
                  },
                  items: salesManagerList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          dropdownUserType == 'CREATE DEALER' &&
                  dropdownSalesManager != '-SELECT SALES MANAGER-'
              ? DropdownButtonFormField(
                  isExpanded: true,
                  value: dropdownSalesOfficer,
                  onChanged: (String? newValue) {
                    dropdownSalesOfficer = newValue!;
                    setState(() {});
                  },
                  items: salesOfficerList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'PROFILE INFORMATION',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'USER NAME',
              fillColor: Colors.green,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'USER EMAIL',
              fillColor: Colors.green,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: cnicController,
            decoration: const InputDecoration(
              labelText: 'USER CNIC',
              fillColor: Colors.green,
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(13),
              MaskTextInputFormatter(mask: '#####-#######-#'),
            ],
          ),
          const SizedBox(height: 15),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: 'USER PHONE NO',
              fillColor: Colors.green,
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
          ),
          const SizedBox(height: 15),
          dropdownUserType == 'CREATE DEALER'
              ? TextField(
                  controller: creditController,
                  decoration: const InputDecoration(
                    labelText: 'CREDIT LIMIT',
                    fillColor: Colors.green,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                )
              : const SizedBox(),
          dropdownUserType == 'CREATE DEALER'
              ? const SizedBox(height: 15)
              : const SizedBox(),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'USER ADDRESS',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          const SizedBox(height: 15),
          DropdownButtonFormField(
            isExpanded: true,
            value: dropdownProvince,
            onChanged: (String? newValue) {
              dropdownProvince = newValue!;
              if (dropdownProvince != '-SELECT PROVINCE-') {
                getProvinceDistricts(dropdownProvince);
              }
              setState(() {});
            },
            items: provinceList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 15),
          dropdownProvince != '-SELECT PROVINCE-'
              ? DropdownButtonFormField(
                  isExpanded: true,
                  value: dropdownDistrict,
                  onChanged: (String? newValue) {
                    dropdownDistrict = newValue!;
                    setState(() {});
                  },
                  items: districtList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          dropdownDistrict != '-SELECT DISTRICT-'
              ? DropdownButtonFormField(
                  isExpanded: true,
                  value: dropdownTehsil,
                  onChanged: (String? newValue) {
                    dropdownTehsil = newValue!;
                    setState(() {});
                  },
                  items:
                      tehsilList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'SET PASSWORD',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'ENTER PASSWORD',
              fillColor: Colors.green,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            obscureText: true,
            controller: confirmPasswordController,
            decoration: const InputDecoration(
              labelText: 'CONFIRM PASSWORD',
              fillColor: Colors.green,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                // check user hierarchy
                if (dropdownUserType == '-SELECT USER ACCOUNT-') {
                  showMessageDialog(
                      message: 'Please select user type first.',
                      context: context);
                } else if (dropdownUserType == 'SALES MANAGER' &&
                    dropdownZonalManager == '-SELECT ZONAL MANAGER-') {
                  showMessageDialog(
                      message: 'Please select Zonal Manager for this user!',
                      context: context);
                } else if (dropdownUserType == 'SALES OFFICER' &&
                    dropdownZonalManager == '-SELECT ZONAL MANAGER-') {
                  showMessageDialog(
                      message: 'Please select Zonal Manager for this user!',
                      context: context);
                  if (dropdownSalesManager == '-SELECT SALES MANAGER-') {
                    showMessageDialog(
                        message: 'Please select Sales Manager for this user!',
                        context: context);
                  }
                } else if (dropdownUserType == 'SALES OFFICER' &&
                    dropdownSalesManager == '-SELECT SALES MANAGER-') {
                  showMessageDialog(
                      message: 'Please select Sales Manager for this user!',
                      context: context);
                } else if (dropdownUserType == 'CREATE DEALER' &&
                    dropdownZonalManager == '-SELECT ZONAL MANAGER-') {
                  showMessageDialog(
                      message: 'Please select Zonal Manager for this user!',
                      context: context);
                  if (dropdownSalesManager == '-SELECT SALES MANAGER-') {
                    showMessageDialog(
                        message: 'Please select Sales Manager for this user!',
                        context: context);
                  } else if (dropdownSalesOfficer == '-SELECT SALES OFFICER-') {
                    showMessageDialog(
                        message: 'Please select Sales Officer for this user!',
                        context: context);
                  }
                } else if (dropdownUserType == 'CREATE DEALER' &&
                    dropdownSalesManager == '-SELECT SALES MANAGER-') {
                  showMessageDialog(
                      message: 'Please select Sales Manager for this user!',
                      context: context);
                } else if (dropdownUserType == 'CREATE DEALER' &&
                    dropdownSalesOfficer == '-SELECT SALES OFFICER-') {
                  showMessageDialog(
                      message: 'Please select Sales Officer for this user!',
                      context: context);
                }

                // check user profile data
                else if (nameController.text == '') {
                  showMessageDialog(
                      message: 'Please enter user name!', context: context);
                } else if (!EmailValidator.validate(emailController.text)) {
                  showMessageDialog(
                      message:
                          'Invalid email! Please enter a valid email address!',
                      context: context);
                } else if (cnicController.text == '') {
                  showMessageDialog(
                      message: 'Please enter user cnic number!',
                      context: context);
                } else if (phoneController.text == '') {
                  showMessageDialog(
                      message: 'Please enter user mobile number!',
                      context: context);
                } else if (cnicController.text.length != 15) {
                  showMessageDialog(
                      message:
                          'User CNIC is incomplete. Please enter 13 digits user cnic number!',
                      context: context);
                } else if (phoneController.text.length != 11) {
                  showMessageDialog(
                      message:
                          'User phone number is incorrect. Please enter 11 digits user mobile number!',
                      context: context);
                } else if (creditController.text == '' &&
                    dropdownUserType == 'CREATE DEALER') {
                  showMessageDialog(
                      message: 'Please enter dealers credit limit!',
                      context: context);
                } else if (dropdownProvince == '-SELECT PROVINCE-') {
                  showMessageDialog(
                      message: 'Please select province for user address.',
                      context: context);
                } else if (dropdownDistrict == '-SELECT DISTRICT-') {
                  showMessageDialog(
                      message: 'Please select district for user address.',
                      context: context);
                } else if (dropdownTehsil == '-SELECT TEHSIL-') {
                  showMessageDialog(
                      message: 'Please select tehsil for user address.',
                      context: context);
                } else if (passwordController.text == '' ||
                    confirmPasswordController.text == '') {
                  showMessageDialog(
                      message:
                          'Password or Confirm Password is empty! Please try again with strong password.',
                      context: context);
                } else if (passwordController.text !=
                    confirmPasswordController.text) {
                  showMessageDialog(
                      message:
                          'Password & Confirm Password do not match! Please try again.',
                      context: context);
                } else if (passwordController.text.length < 7 ||
                    confirmPasswordController.text.length < 7) {
                  showMessageDialog(
                      message:
                          'Password or Confirm Password length is less than 7 letters! Please try again with strong password.',
                      context: context);
                } else {
                  createNewUserAccount();
                }
              },
              child: const Text('CREATE USER'))
        ],
      ),
    );
  }

  void createNewUserAccount() async {
    String userType = 'dealer';
    final operationsUID = FirebaseAuth.instance.currentUser?.uid;
    String zonalManagerUID = 'none';
    String salesManagerUID = 'none';
    String salesOfficerUID = 'none';
    String franchiseeUID =  'none';
    for (int i = 0; i < zonalManagerList.length; i++) {
      if (dropdownZonalManager == zonalManagerList[i]) {
        zonalManagerUID = zonalManagerUIDList[i];
      }
    }
    for (int i = 0; i < salesManagerList.length; i++) {
      if (dropdownSalesManager == salesManagerList[i]) {
        salesManagerUID = salesManagerUIDList[i];
      }
    }
    for (int i = 0; i < salesOfficerList.length; i++) {
      if (dropdownSalesOfficer == salesOfficerList[i]) {
        salesOfficerUID = salesOfficerUIDList[i];
      }
    }

    if (dropdownUserType == 'ZONAL MANAGER') {
      userType = 'zonalManager';
    } else if (dropdownUserType == 'SALES MANAGER') {
      userType = 'salesManager';
    } else if (dropdownUserType == 'SALES OFFICER') {
      userType = 'salesOfficer';
    } else if (dropdownUserType == 'CREATE DEALER') {
      userType = 'dealer';
    }

    try {
      FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      confirmUserCreationAndRedirect();
    } catch (e) {
      showMessageDialog(message: e.toString(), context: context);
    }

    UserProfile newUserProfile = UserProfile(
        userUID: FirebaseAuth.instance.currentUser!.uid,
        userName: nameController.text,
        userCNIC: cnicController.text,
        ntn: ntnController.text,
        isFiler: isFilerController.text == "true" ? true : false,
        creditLimit: double.parse(creditController.text),
        availableCredit: double.parse(creditController.text),
        userType: UserType.dealer,
        userMobile: phoneController.text,
        userStatus: true,
        province: dropdownProvince,
        district: dropdownDistrict,
        tehsil: dropdownTehsil,
        operationsUID: operationsUID!,
        zonalManagerUID: zonalManagerUID,
        salesManagerUID: salesManagerUID,
        salesOfficerUID: salesOfficerUID,
        franchiseeUID: franchiseeUID);

    uploadUserProfileToFirebase(newUserProfile);
  }

  void uploadUserProfileToFirebase(UserProfile userProfile) async {
    try {
      await FirebaseFirestore.instance
          .collection('userProfile')
          .add(userProfile.toJson());
      if (dropdownUserType == 'CREATE DEALER') {
        DealersCredit dealersCredit = DealersCredit(
            dealerUID: FirebaseAuth.instance.currentUser!.uid,
            creditLimit: double.parse(creditController.text),
            availableCredit: double.parse(creditController.text)
        );

        await FirebaseFirestore.instance
            .collection('dealersCredit')
            .add(dealersCredit.toJson());
      }
    } catch (e) {
      showMessageDialog(message: e.toString(), context: context);
    }
  }

  void createFirebaseAuthUser() async {
    try {
      FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      confirmUserCreationAndRedirect();
    } catch (e) {
      showMessageDialog(message: e.toString(), context: context);
    }
  }

  confirmUserCreationAndRedirect() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'CONGRATULATIONS!\n',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
          const Text(
            'New user account is created. Please proceed to check new user account!',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const Text('\n'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserAuthentication())),
                  child: const Text('CANCEL')),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserAuthentication())),
                child: const Text('OKAY'),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
