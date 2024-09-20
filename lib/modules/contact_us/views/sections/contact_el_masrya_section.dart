import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../widgets/defaults/default_submit_button.dart';
import '../../../../widgets/defaults/default_text_form_field.dart';
import '../../../main/controllers/main_home_controller.dart';

class ContactElMasryaSection extends StatelessWidget {
  final bool isMobile;
  const ContactElMasryaSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();
    final nameTextController = TextEditingController();
    final descriptionTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    // Form widget for text fields
    var form = Form(
      key: formKey,
      child: Column(
        children: [
          DefaultTextFormField(
            color: AppColors.notBlackAndWhiteColor(context),
            controller: nameTextController,
            hintText: "Enter your name",
            keyboardType: TextInputType.name,
            labelText: "Name",
            validator: (value) {
              if (value == "") return "Enter your Name";
              return null;
            },
          ),
          const SizedBox(height: 10),
          DefaultTextFormField(
            color: AppColors.notBlackAndWhiteColor(context),
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
          const SizedBox(height: 10),
          DefaultTextFormField(
            color: AppColors.notBlackAndWhiteColor(context),
            controller: descriptionTextController,
            hintText: "Enter any Description",
            keyboardType: TextInputType.text,
            labelText: "Description",
            validator: (value) {
              if (value == "") return "Enter any Description";
              return null;
            },
          ),
          const SizedBox(height: 20),
          Obx(() {
            return DefaultSubmitButton(
              isLoading: Get.find<MainHomeController>().isSubmitted.value,
              text: "Submit Your Inquiry",
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Get.find<MainHomeController>().submitInquiry(
                    nameTextController.text.trim(),
                    emailTextController.text.trim(),
                    descriptionTextController.text.trim(),
                  );
                }
              },
            );
          }),
        ],
      ),
    );

    // Overall layout
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Al Masria Team",
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColors.notBlackAndWhiteColor(context)),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Get in touch for inquiries about our recycling machines and services. We are here to assist you with your needs.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w200,
                          color: AppColors.notBlackAndWhiteColor(context).withAlpha(200)),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Connect",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "01015811730 - 01206120110",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Support",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () async {
                        String recipientEmail =
                            Uri.encodeComponent("elmasrya2008@gmail.com");
                        String emailSubject =
                            Uri.encodeComponent("Hello from Website");
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
                        style: Theme.of(context).textTheme.bodySmall
                      ),
                    ),
                    const SizedBox(height: 15),
                    if (isMobile) form
                  ],
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 25),
                Expanded(child: form)
              ],
            ],
          ),
        ],
      ),
    );
  }
}