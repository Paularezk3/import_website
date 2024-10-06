import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../widgets/defaults/default_submit_button.dart';
import '../../../../widgets/defaults/default_text_form_field.dart';
import '../../../main/controllers/main_home_controller.dart';
import '../../widgets/clickable_text.dart';

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
    var form = Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondaryColor(context), // Unique background color for the form
        borderRadius:
            BorderRadius.circular(15.0), // Rounded corners for a special look
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Soft shadow for depth
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0), // Padding inside the form container
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text("Enter Your Inquiry".tr, style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20
            ),),
            const SizedBox(height: 10),
            DefaultTextFormField(
              color: AppColors.notBlackAndWhiteColor(context),
              controller: nameTextController,
              hintText: "Enter your Name".tr,
              keyboardType: TextInputType.name,
              labelText: "Name".tr,
              validator: (value) {
                if (value == "") return "Enter your Name".tr;
                return null;
              },
            ),
            const SizedBox(height: 10),
            DefaultTextFormField(
              color: AppColors.notBlackAndWhiteColor(context),
              controller: emailTextController,
              hintText: "Enter your email".tr,
              keyboardType: TextInputType.emailAddress,
              labelText: "Email".tr,
              validator: (value) {
                if (value == "") return "Enter your email".tr;
                if (value != "" && !value!.contains("@")) {
                  return "Enter a correct email".tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            DefaultTextFormField(
              color: AppColors.notBlackAndWhiteColor(context),
              controller: descriptionTextController,
              hintText: "Enter any description".tr,
              keyboardType: TextInputType.text,
              labelText: "Description".tr,
              validator: (value) {
                if (value == "") return "Enter any description".tr;
                return null;
              },
            ),
            const SizedBox(height: 20),
            Obx(() {
              return DefaultSubmitButton(
                isLoading: Get.find<MainHomeController>().isSubmitted.value,
                text: "Submit Your Inquiry".tr,
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
      ),
    );

    // Overall layout
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "contact al masria team".tr,
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
                      "Get in touch for inquiries about our recycling machines and services. We are here to assist you with your needs."
                          .tr,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w200,
                          color: AppColors.notBlackAndWhiteColor(context)
                              .withAlpha(200)),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "connect".tr,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    CopyableText(),
                    const SizedBox(height: 15),
                    Text(
                      "support".tr,
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
                            "Hi! I'm interested to Work with Each other.".tr);

                        Uri emailUri = Uri.parse(
                            "mailto:$recipientEmail?subject=$emailSubject&body=$emailBody");

                        if (await canLaunchUrl(emailUri)) {
                          await launchUrl(emailUri);
                        } else {
                          throw 'Could not launch email app'.tr;
                        }
                      },
                      child: SelectableText('elmasrya2008@gmail.com',
                          style: Theme.of(context).textTheme.bodySmall),
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
