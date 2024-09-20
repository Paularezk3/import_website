import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:import_website/modules/home/controller/home_controller.dart';
import 'package:import_website/widgets/defaults/default_submit_button.dart';
import 'package:import_website/widgets/defaults/default_text_form_field.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../main/controllers/main_home_controller.dart';

class PageTailSection extends StatefulWidget {
  final bool isMobile;
  const PageTailSection({required this.isMobile, super.key});

  @override
  _PageTailSectionState createState() => _PageTailSectionState();
}

class _PageTailSectionState extends State<PageTailSection> {
  final myController = Get.find<HomeController>();
  final emailTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 11, 61, 145),
      alignment: AlignmentDirectional.centerStart,
      padding: const EdgeInsets.all(16.0), // Optional: Add padding if needed
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.isMobile ? mobile(context) : laptop(context),
      ),
    );
  }

  Column mobile(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          'Innovative',
          textAlign: TextAlign.left,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.blackAndWhiteLightMode,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Quality recycling machines since 2008 in Egypt.',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        // First row of images
        Row(
          children: [
            IconButton(
              onPressed: () {
                // Replace the URL below with the actual Facebook profile link
                const String facebookProfileUrl =
                    'https://www.facebook.com/profile.php?id=61565374994630';
                // Open the URL in a web browser
                launchUrl(Uri.parse(facebookProfileUrl));
              },
              icon: const Icon(
                Icons.facebook_rounded,
                color: AppColors.blackAndWhiteLightMode,
              ),
            ),

            const SizedBox(width: 8), // Space between images
            IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.instagram),
              color: AppColors.blackAndWhiteLightMode,
            ),
            // const SizedBox(width: 8), // Space between images
            // IconButton(
            //     onPressed: () {}, icon: const Icon(Icons.facebook_rounded)),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Contact Us',
          textAlign: TextAlign.left,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.blackAndWhiteLightMode,
            ),
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.phone_rounded,
              color: AppColors.blackAndWhiteLightMode,
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () async {
                const phoneNumber =
                    'tel://01015811730'; // Phone number with "tel://" prefix
                if (await canLaunchUrl(Uri.parse(phoneNumber))) {
                  await launchUrl(Uri.parse(phoneNumber));
                } else {
                  // Handle error when the dialer cannot be opened
                  throw 'Could not launch $phoneNumber';
                }
              },
              child: Text(
                '01015811730',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackAndWhiteLightMode,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5), // Add some spacing between rows
        // WhatsApp row
        Row(
          children: [
            const Icon(
              FontAwesomeIcons.whatsapp,
              color: AppColors.blackAndWhiteLightMode,
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () async {
                const whatsappUrl =
                    'https://wa.me/201015811730'; // WhatsApp URL with country code
                if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                  await launchUrl(Uri.parse(whatsappUrl));
                } else {
                  // Handle error when WhatsApp cannot be opened
                  throw 'Could not launch $whatsappUrl';
                }
              },
              child: Text(
                'Contact via WhatsApp',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackAndWhiteLightMode,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 5), // Add some spacing between rows
        Row(
          children: [
            const Icon(
              Icons.email,
              color: AppColors.blackAndWhiteLightMode,
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () async {
                String recipientEmail =
                    Uri.encodeComponent("elmasrya2008@gmail.com");
                String emailSubject = Uri.encodeComponent("Hello from Website");
                String emailBody = Uri.encodeComponent(
                    "Hi! I'm interested to Work with Each other.");

                Uri emailUri = Uri.parse(
                    "mailto:$recipientEmail?subject=$emailSubject&body=$emailBody");

                if (await canLaunchUrl(emailUri)) {
                  await launchUrl(emailUri);
                } else {
                  // Handle the case when the email app cannot be opened
                  throw 'Could not launch email app';
                }
              },
              child: Text(
                'elmasrya2008@gmail.com',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackAndWhiteLightMode,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 25),
        Text(
          'Get All The Updates',
          textAlign: TextAlign.left,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.blackAndWhiteLightMode,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Form(
          key: _formKey,
          child: Column(
            children: [
              DefaultTextFormField(
                controller: nameTextController,
                hintText: "Enter your name",
                keyboardType: TextInputType.name,
                labelText: "Name",
                validator: (value) {
                  if (value == "") return "Enter your Name";
                  return null;
                },
              ),
              DefaultTextFormField(
                controller: emailTextController,
                hintText: "Enter your email",
                keyboardType: TextInputType.emailAddress,
                labelText: "Email",
                validator: (value) {
                  if (value == "") return "Enter your Email";
                  if (value != "" && value!.contains("@")) {
                    return "Enter a correct email";
                  }
                  return null;
                },
              ),
              DefaultSubmitButton(
                  text: "Submit",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.find<MainHomeController>().submitEmail(
                          nameTextController.text.trim(),
                          emailTextController.text.trim());
                    }
                  })
            ],
          ),
        ),
      ],
    );
  }

  Column laptop(BuildContext context) {
    var children = [
      Text(
        'Contact Us',
        textAlign: TextAlign.left,
        style: GoogleFonts.openSans(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blackAndWhiteLightMode,
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      // Phone contact
      Row(
        children: [
          const Icon(
            Icons.phone_rounded,
            color: AppColors.blackAndWhiteLightMode,
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () async {
              const phoneNumber = 'tel://01015811730';
              if (await canLaunchUrl(Uri.parse(phoneNumber))) {
                await launchUrl(Uri.parse(phoneNumber));
              } else {
                throw 'Could not launch $phoneNumber';
              }
            },
            child: Text(
              '01015811730',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackAndWhiteLightMode,
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      // WhatsApp row
      Row(
        children: [
          const Icon(
            FontAwesomeIcons.whatsapp,
            color: AppColors.blackAndWhiteLightMode,
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () async {
              const whatsappUrl = 'https://wa.me/201015811730';
              if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                await launchUrl(Uri.parse(whatsappUrl));
              } else {
                throw 'Could not launch $whatsappUrl';
              }
            },
            child: Text(
              'Contact via WhatsApp',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackAndWhiteLightMode,
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      // Email row
      Row(
        children: [
          const Icon(
            Icons.email,
            color: AppColors.blackAndWhiteLightMode,
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () async {
              String recipientEmail =
                  Uri.encodeComponent("elmasrya2008@gmail.com");
              String emailSubject = Uri.encodeComponent("Hello from Website");
              String emailBody = Uri.encodeComponent(
                  "Hi! I'm interested to Work with Each other.");

              Uri emailUri = Uri.parse(
                  "mailto:$recipientEmail?subject=$emailSubject&body=$emailBody");

              if (await canLaunchUrl(emailUri)) {
                await launchUrl(emailUri);
              } else {
                throw 'Could not launch email app';
              }
            },
            child: Text(
              'elmasrya2008@gmail.com',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackAndWhiteLightMode,
                ),
              ),
            ),
          ),
        ],
      )
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Innovative',
          textAlign: TextAlign.start,
          style: GoogleFonts.openSans(
            color: AppColors.blackAndWhiteLightMode,
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.blackAndWhiteLightMode,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Quality recycling machines since 2008 in Egypt.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                // First row of icons
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        const String facebookProfileUrl =
                            'https://www.facebook.com/profile.php?id=61565374994630';
                        launchUrl(Uri.parse(facebookProfileUrl));
                      },
                      icon: const Icon(
                        Icons.facebook_rounded,
                        color: AppColors.blackAndWhiteLightMode,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.instagram),
                      color: AppColors.blackAndWhiteLightMode,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (MediaQuery.of(context).size.width <= 900) ...children
              ],
            ),
            if (MediaQuery.of(context).size.width > 900) ...[
              const Spacer(
                flex: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [...children],
              )
            ],
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Get All The Updates',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackAndWhiteLightMode,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double
                              .infinity, // Ensure full width for TextField
                          child: DefaultTextFormField(
                            controller: nameTextController,
                            hintText: "Enter your name",
                            keyboardType: TextInputType.name,
                            labelText: "Name",
                            validator: (value) {
                              if (value == "") return "Enter your Name";
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double
                              .infinity, // Ensure full width for TextField
                          child: DefaultTextFormField(
                            controller: emailTextController,
                            hintText: "Enter your email",
                            keyboardType: TextInputType.emailAddress,
                            labelText: "Email",
                            validator: (value) {
                              if (value == "") return "Enter your Email";
                              if (value != "" && !value!.contains("@")) {
                                return "Enter a correct email";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        DefaultSubmitButton(
                          text: "Submit",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Get.find<MainHomeController>().submitEmail(
                                  nameTextController.text.trim(),
                                  emailTextController.text.trim());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ],
    );
  }
}
