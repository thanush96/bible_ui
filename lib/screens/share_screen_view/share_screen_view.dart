import 'package:flutter/material.dart';
import 'package:flutter_app/values/app-font.dart';
import 'package:flutter_app/values/values.dart';
import 'package:flutter_app/widgets/reader_header.dart';
import 'package:flutter_svg/svg.dart';

class ShareScreenView extends StatefulWidget {
  const ShareScreenView({super.key});

  @override
  State<ShareScreenView> createState() => _ShareScreenViewState();
}

class _ShareScreenViewState extends State<ShareScreenView> {
  final List<bool> _selectedProfiles = List.filled(items.length, false);
  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ReaderHeader(
                onBackPressed: () => Navigator.pop(context),
                isPlaying: isPlaying,
                onPlayOpen: () {
                  // showModalBottomSheet(
                  //   backgroundColor: Colors.transparent,
                  //   context: context,
                  //   builder: (context) => const PopupMusicPlayer(),
                  // );

                  // setState(() {
                  //   isPlaying = !isPlaying;
                  // });
                },
              ),
              Divider(
                color: AppColors.titleDivider,
                thickness: 2,
                endIndent: 15,
                indent: 15,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/whatsapp.svg"),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Share Link with whatsapp",
                      style: TextStyle(
                        fontSize: AppFont.textSize16,
                        color: AppColors.greyTitle,
                        fontWeight: AppFont.fw400,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/email.svg"),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Share Link with email",
                      style: TextStyle(
                        fontSize: AppFont.textSize16,
                        color: AppColors.greyTitle,
                        fontWeight: AppFont.fw400,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/link.svg"),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Copy link",
                      style: TextStyle(
                        fontSize: AppFont.textSize16,
                        color: AppColors.greyTitle,
                        fontWeight: AppFont.fw400,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const HeaderDivider(
                headerCount: "52",
                headerText: "Admin",
              ),
              AppSpaces.verticalSpace20,
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedProfiles[index];
                    final item = items[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // Toggle the selection state
                          _selectedProfiles[index] = !_selectedProfiles[index];
                        });
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  child: SvgPicture.asset(item['imageUrl']!),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 8,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: isSelected
                                        ? AppColors.greyTitle
                                        : AppColors.greyTitle,
                                    child: Icon(
                                      isSelected ? Icons.check : Icons.add,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['name']!,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              AppSpaces.verticalSpace10,
              const HeaderDivider(
                headerCount: "52",
                headerText: "participants",
              ),
              AppSpaces.verticalSpace20,
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedProfiles[index];
                    final item = items[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // Toggle the selection state
                          _selectedProfiles[index] = !_selectedProfiles[index];
                        });
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  child: SvgPicture.asset(item['imageUrl']!),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 8,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: isSelected
                                        ? AppColors.greyTitle
                                        : AppColors.greyTitle,
                                    child: Icon(
                                      isSelected ? Icons.check : Icons.add,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['name']!,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderDivider extends StatelessWidget {
  final String headerText;
  final String headerCount;

  const HeaderDivider({
    super.key,
    required this.headerText,
    required this.headerCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$headerText ($headerCount)",
                style: TextStyle(
                  fontSize: AppFont.textSize20,
                  fontWeight: AppFont.fw400,
                  color: AppColors.greyTitle,
                ),
              ),
              GestureDetector(
                child: const Icon(
                  Icons.arrow_forward,
                  size: 30,
                ),
              )
            ],
          ),
          Container(
            height: 2,
            color: AppColors.titleDivider,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> items = [
  {'imageUrl': 'assets/svg/user.svg', 'name': 'Item 1'},
  {'imageUrl': 'assets/svg/user.svg', 'name': 'Item 2'},
  {'imageUrl': 'assets/svg/user.svg', 'name': 'Item 3'},
  {'imageUrl': 'assets/svg/user.svg', 'name': 'Item 4'},
  {'imageUrl': 'assets/svg/user.svg', 'name': 'Item 5'},
  {'imageUrl': 'assets/svg/user.svg', 'name': 'Item 6'},
  {'imageUrl': 'assets/svg/user.svg', 'name': 'Item 7'},
  {'imageUrl': 'assets/svg/user.svg', 'name': 'Item 8'},
];
