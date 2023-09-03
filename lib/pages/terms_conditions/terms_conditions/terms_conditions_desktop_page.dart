import 'package:flutter/material.dart';

class TermsAndConditionsDesktopPage extends StatefulWidget {
  final Widget pageDrawer;
  const TermsAndConditionsDesktopPage({Key? key, required this.pageDrawer})
      : super(key: key);

  @override
  State<TermsAndConditionsDesktopPage> createState() =>
      _TermsAndConditionsDesktopPageState();
}

class _TermsAndConditionsDesktopPageState
    extends State<TermsAndConditionsDesktopPage> {
  String aboutUs =
      "Founded in 2009, with a passion to contribute to Pakistan’s livestock and agriculture sector, Maxim Agri s the fastest-growing agri company.\n\nMaxim’s primary objective is to provide trusted animal feeds, fodder seeds, and customized nutrition solutions to help maximize the performance of small and commercial farmers.\n\nWe have developed strong strategic alliances with global leaders in the feed and seed industry over the years strengthening our business profile. We work closely with industry pioneers like World Wide Sires (WWS), Artex, Selected Seeds, and more. As our profile grows, so does our outreach, Maxim is aggressively expanding its export interests in the Asian and Middle East Markets.\n\nWe occupy a unique position across the agri industry of Pakistan. Our focus is to improve the economic well-being of our local farmers, enhance the sustainability of food production, add value along that chain, and drive profit for our partners. We do this by investing in new sciences, pushing the use of technology, using data to deliver insight, and driving real-time improvements. Our Quality assurance department plays a pivotal role. Central to our business, the quality assurance team ensures that all raw material to be used, as well as the feed which is produced, conforms to the company’s nutritional and physical specifications.";
  String aboutUs2 =
      "Maxim’s quality assurance program follows a comprehensive approach that encompasses the people, policies, and procedures involved in each stage of production. Extensive testing is performed on our inputs, intermediate product as well as final output. Our research and quality staff consist of highly qualified veterinary professionals and microbiologists who keep a close eye on all aspects. The Quality Assurance team at Maxim strives to ensure that no bag leaves our premises till the stipulated standards are met.\n\nMaxim’s biggest test has been to challenge the conventional feed practices in the country. While we continue to face resistance, we are proud to stand firm in our stance against aflatoxin and blood meal content in animal feed. Maxim continues to educate farmers about the dangers to both animals and humans of using these contents in feed. We are the fastest-growing agricultural company in Pakistan, and we’re expanding our local footprint to become a key player.\n\nOur biggest strength has been our unique blend of highly motivated and skilled professionals in sales, quality assurance, supply chain, production, and more. This relatively young and dynamic team of professionals has allowed Maxim to inculcate a fresh perspective and move ahead with fervor in the industry. It is our human resource that has allowed us the competitive advantage that no one else in the industry enjoys.\n\n";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms And Conditions'),
      ),
      body: Row(
        children: [
          Expanded(flex: 1, child: widget.pageDrawer),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'TERMS & CONDITIONS\n',
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
                            style:
                                const TextStyle(fontSize: 17, letterSpacing: 1),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            aboutUs2.toUpperCase(),
                            style:
                                const TextStyle(fontSize: 17, letterSpacing: 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
