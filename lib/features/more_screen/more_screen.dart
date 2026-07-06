import 'package:flutter/material.dart';

import '../../core/constants/profiles.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              //todo - logged in profile should be larger than others
              /// Profiles
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.22,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: profiles.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: index == profiles.length
                                ? Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white30),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          profiles[index]['image']!,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          index == profiles.length
                              ? ''
                              : profiles[index]['name']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: Colors.white70, size: 16),
                  SizedBox(width: 6),
                  Text(
                    "Manage Profiles",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Netflix Share Card
              Container(
                width: double.infinity,
                color: const Color(0xff1A1A1A),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.smart_display, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Tell friends about Netflix.",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur "
                      "adipiscing elit. Sit quam dui, vivamus "
                      "bibendum ut. A morbi mi tortor ut felis.",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        color: Colors.white54,
                        decoration: TextDecoration.underline,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: Container(height: 40, color: Colors.black),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            child: const Text("Copy Link"),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.whatshot, color: Colors.green, size: 32),
                        Icon(Icons.facebook, color: Colors.blue, size: 32),
                        Icon(Icons.mail, color: Colors.white, size: 32),
                        Column(
                          children: [
                            Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                              size: 32,
                            ),
                            Text(
                              "More",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              /// My List
              Container(
                color: const Color(0xff1A1A1A),
                padding: const EdgeInsets.all(16),
                child: const Row(
                  children: [
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "My List",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              _menuTile("App Settings"),
              _menuTile("Account"),
              _menuTile("Help"),
              _menuTile("Sign Out"),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _menuTile(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () {},
    );
  }
}
