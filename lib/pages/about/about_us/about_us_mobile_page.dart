import 'package:flutter/material.dart';

class AboutUsMobilePage extends StatefulWidget {
  final Widget pageDrawer;
  final Widget pageNavigation;
  const AboutUsMobilePage(
      {Key? key, required this.pageDrawer, required this.pageNavigation})
      : super(key: key);

  @override
  State<AboutUsMobilePage> createState() => _AboutUsMobilePageState();
}

class _AboutUsMobilePageState extends State<AboutUsMobilePage> {
  String aboutUs =
      "Founded in 2009, with a passion to contribute to Pakistan’s livestock and agriculture sector, Maxim Agri s the fastest-growing agri company.\n\nMaxim’s primary objective is to provide trusted animal feeds, fodder seeds, and customized nutrition solutions to help maximize the performance of small and commercial farmers.\n\nWe have developed strong strategic alliances with global leaders in the feed and seed industry over the years strengthening our business profile. We work closely with industry pioneers like World Wide Sires (WWS), Artex, Selected Seeds, and more. As our profile grows, so does our outreach, Maxim is aggressively expanding its export interests in the Asian and Middle East Markets.\n\nWe occupy a unique position across the agri industry of Pakistan. Our focus is to improve the economic well-being of our local farmers, enhance the sustainability of food production, add value along that chain, and drive profit for our partners. We do this by investing in new sciences, pushing the use of technology, using data to deliver insight, and driving real-time improvements. Our Quality assurance department plays a pivotal role. Central to our business, the quality assurance team ensures that all raw material to be used, as well as the feed which is produced, conforms to the company’s nutritional and physical specifications. \n\nMaxim’s quality assurance program follows a comprehensive approach that encompasses the people, policies, and procedures involved in each stage of production. Extensive testing is performed on our inputs, intermediate product as well as final output. Our research and quality staff consist of highly qualified veterinary professionals and microbiologists who keep a close eye on all aspects. The Quality Assurance team at Maxim strives to ensure that no bag leaves our premises till the stipulated standards are met.\n\nMaxim’s biggest test has been to challenge the conventional feed practices in the country. While we continue to face resistance, we are proud to stand firm in our stance against aflatoxin and blood meal content in animal feed. Maxim continues to educate farmers about the dangers to both animals and humans of using these contents in feed. We are the fastest-growing agricultural company in Pakistan, and we’re expanding our local footprint to become a key player.\n\nOur biggest strength has been our unique blend of highly motivated and skilled professionals in sales, quality assurance, supply chain, production, and more. This relatively young and dynamic team of professionals has allowed Maxim to inculcate a fresh perspective and move ahead with fervor in the industry. It is our human resource that has allowed us the competitive advantage that no one else in the industry enjoys.\n\n";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Maxim Agri'),
      ),
      drawer: widget.pageDrawer,
      bottomNavigationBar: widget.pageNavigation,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'ABOUT MAXIM AGRI (PVT) LTD\n',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                      ),
                    ),
                  ),
                ),
                Text(
                  aboutUs.toUpperCase(),
                  style: const TextStyle(fontSize: 17, letterSpacing: 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class AboutUsMobilePage extends StatefulWidget {
//   final Widget pageDrawer;
//   final Widget pageNavigation;
//   const AboutUsMobilePage(
//       {Key? key, required this.pageDrawer, required this.pageNavigation})
//       : super(key: key);
//
//   @override
//   State<AboutUsMobilePage> createState() => _AboutUsMobilePageState();
// }
//
// class _AboutUsMobilePageState extends State<AboutUsMobilePage> {
//   String dropdownValue = 'Dog';
//   List<String> animalList = ['Dog', 'Cat', 'Tiger', 'Lion', 'Lion'];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('AboutUsMobilePage'),
//       ),
//       drawer: widget.pageDrawer,
//       bottomNavigationBar: widget.pageNavigation,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(50.0),
//           child: DropdownButtonFormField(
//             // decoration: const InputDecoration(
//             //   enabledBorder: OutlineInputBorder(
//             //     borderSide: BorderSide(
//             //         color: Colors.amberAccent, width: 2), //<-- SEE HERE
//             //   ),
//             //   focusedBorder: OutlineInputBorder(
//             //     borderSide: BorderSide(
//             //         color: Colors.amberAccent, width: 2), //<-- SEE HERE
//             //   ),
//             //   filled: true,
//             //   fillColor: Colors.greenAccent,
//             // ),
//             //dropdownColor: Colors.greenAccent,
//             value: dropdownValue,
//             onChanged: (String? newValue) {
//               setState(() {
//                 dropdownValue = newValue!;
//               });
//             },
//             items: animalList.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(
//                   value,
//                   //style: const TextStyle(fontSize: 20),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
