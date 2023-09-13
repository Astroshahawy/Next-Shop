import 'package:flutter/material.dart';

class AboutTile extends StatelessWidget {
  const AboutTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      title: Text(
        'About',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.grey[600],
        ),
      ),
      leading: Icon(
        Icons.info_outline_rounded,
        color: Colors.orange.shade600,
        size: 30.0,
      ),
      trailing: const Icon(Icons.arrow_right),
      onTap: () async {
        Navigator.pop(context);
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    const Positioned(
                      top: -70.0,
                      height: 80.0,
                      width: 80.0,
                      child: CircleAvatar(
                        radius: 40.0,
                        foregroundImage: AssetImage('assets/icon.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Next Shop',
                            style: TextStyle(
                              fontSize: 26.0,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Next Shop is a fake online shop based on a fakeStoreApi REST API that you can use whenever you need Pseudo-real data for your e-commerce or shopping website without running any server-side code. It\'s awesome for teaching purposes, sample codes, tests, etc. ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
