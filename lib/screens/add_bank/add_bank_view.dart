import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_ecommerce/screens/add_bank/add_bank_viewmodel.dart';

import '../../helpers/validator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loader_view.dart';

class AddBankView extends StatelessWidget {
  AddBankView({super.key});

  final AddBankViewModel viewModel = Get.put(AddBankViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar2(
        title: viewModel.isEdit ? 'Edit Bank Details' : 'Add Bank Details',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: viewModel.addBankFormKey,
              child: Column(
                children: [
                  creditCard(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: [
                        accountTitleTxtField(),
                        accountNumberTxtField(),
                        ibanNumberTxtField(),
                        bankNameTxtField(),
                        expiryDateTxtField(),
                        cvvTxtField(),
                        CustomTextBtn(
                          title: viewModel.isEdit ? 'Update' : 'Save & Create',
                          onPressed: () {
                            // viewModel.saveAndCreateBtn();
                          },
                        ),
                        const SizedBox(height: 5),
                        CustomTextBtn(
                          title: 'Discard',
                          backgroundColor: Colors.black,
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget creditCard() {
    return FlipCard(
      controller: viewModel.flipCardController,
      front: Container(
        padding: const EdgeInsets.fromLTRB(40, 100, 15, 42),
        width: double.infinity,
        height: Get.height * 0.32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/card_bg.png'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                viewModel.accountNumber.value,
                maxLines: 1,
                style: GoogleFonts.metrophobic(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: Get.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => cardItem(
                      title: 'Card Holder Name',
                      value: viewModel.accountTitle.value,
                    ),
                  ),
                  Obx(
                    () => cardItem(
                      title: 'Expiry Date',
                      value: viewModel.expiryDate.value,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      back: Container(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        height: Get.height * 0.23,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 26),
        decoration: BoxDecoration(
          color: const Color(0xFF222222),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              color: Colors.black,
            ),
            Container(
              color: Colors.white.withOpacity(0.2),
              margin: const EdgeInsets.only(top: 13),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 30,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Obx(
                      () => Text(
                        viewModel.cvv.value,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardItem({required String title, required String value}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: 'Metropolis',
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Metropolis',
            ),
          )
        ],
      ),
    );
  }

  Widget accountTitleTxtField() {
    return CustomTextField1(
      controller: viewModel.accountTitleController,
      title: 'Account Title',
      hintText: 'Ashar Atique',
      onTap: () {
        if (!viewModel.flipCardController.state!.isFront) {
          viewModel.flipCardController.toggleCard();
        }
      },
      onChanged: (value) {
        viewModel.accountTitle.value = value;
        if (value.isEmpty) {
          viewModel.accountTitle.value = 'Card Holder';
        }
      },
      validator: (value) {
        return Validator.validateDefaultField(value,
            errorMessage: 'Account Title is required');
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget accountNumberTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextField1(
        controller: viewModel.accountNumberController,
        title: 'Account Number',
        hintText: '0029 3103 1091 0553',
        onTap: () {
          if (!viewModel.flipCardController.state!.isFront) {
            viewModel.flipCardController.toggleCard();
          }
        },
        onChanged: (value) {
          viewModel.accountNumber.value = value;
          if (value.isEmpty) {
            viewModel.accountNumber.value = '0000 0000 0000 0000';
          }
        },
        inputFormatters: [
          // CreditCardNumberInputFormatter(),
          MaskedInputFormatter(
            "0000 0000 0000 0000",
            allowedCharMatcher: RegExp(r'[0-9]+'),
          ),
        ],
        keyboardType: TextInputType.number,
        validator: (value) {
          return Validator.validateDefaultField(value,
              errorMessage: 'Account Number is required');
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget ibanNumberTxtField() {
    return CustomTextField1(
      controller: viewModel.ibanController,
      title: 'IBAN Number',
      hintText: 'PKMEZN00293103109103',
    );
  }

  Widget bankNameTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextField1(
        controller: viewModel.bankNameController,
        title: 'Bank Name',
        hintText: 'Meezan Bank',
        // onChanged: (value) {
        //   viewModel.bankName.value = value;
        //   if (value.isEmpty) {
        //     viewModel.bankName.value = 'Meezan Bank';
        //   }
        // },
        validator: (value) {
          return Validator.validateDefaultField(value,
              errorMessage: 'Bank Name is required');
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget expiryDateTxtField() {
    return CustomTextField1(
      controller: viewModel.expiryDateController,
      title: 'Expiry Date',
      hintText: '00/00',
      onTap: () {
        if (!viewModel.flipCardController.state!.isFront) {
          viewModel.flipCardController.toggleCard();
        }
      },
      onChanged: (value) {
        viewModel.expiryDate.value = value;
        if (value.isEmpty) {
          viewModel.expiryDate.value = '00/00';
        }
      },
      inputFormatters: [
        CreditCardExpirationDateFormatter(),
      ],
      keyboardType: TextInputType.number,
    );
  }

  Widget cvvTxtField() {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 30),
      child: CustomTextField1(
        controller: viewModel.cvvController,
        title: 'CVV',
        hintText: '000',
        onTap: () {
          if (viewModel.flipCardController.state!.isFront) {
            viewModel.flipCardController.toggleCard();
          }
        },
        onChanged: (value) {
          viewModel.cvv.value = value;
          if (value.isEmpty) {
            viewModel.cvv.value = '000';
          }
        },
        inputFormatters: [
          CreditCardCvcInputFormatter(),
        ],
        keyboardType: TextInputType.number,
      ),
    );
  }
}
