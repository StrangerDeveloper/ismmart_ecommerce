import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/common_function.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../custom_snackbar.dart';
import 'bottomsheet_item.dart';

class PickImage {
  File? selectedImage;

  //////////////////////////////////////////////////////////////////
  ////////////////////////// Single Image //////////////////////////
  //////////////////////////////////////////////////////////////////

  Future<File?> pickSingleImage() async {
    await showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      'Pick Image',
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              BottomSheetItemRow(
                title: "Gallery",
                icon: Icons.browse_gallery_outlined,
                isDisabled: false,
                onTap: () async {
                  selectedImage = await imgFromGallery();
                  //Navigator.of(context).pop();
                  Get.back();
                },
              ),
              BottomSheetItemRow(
                title: 'Camera',
                icon: Icons.camera_alt_outlined,
                isDisabled: false,
                onTap: () async {
                  selectedImage = await imgFromCamera();
                  // Navigator.of(context).pop();
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
    return selectedImage;
  }

  Future<File?> imgFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return await compressSingleImage(pickedFile);
    }
    return null;
  }

  Future<File?> imgFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return await compressSingleImage(pickedFile);
    }
    return null;
  }

  Future<File?> compressSingleImage(XFile image) async {
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/$timeStamp.jpg';

    final result =
        await FlutterImageCompress.compressAndGetFile(image.path, targetPath,
            minHeight: 1080, //you can play with this to reduce siz
            minWidth: 1080,
            quality: 100);

    double length = await checkImageSize(result!);

    if (length > 2) {
      CommonFunction.showSnackBar(
          title: 'Error', message: "Image Size must be less than 2MB");
      return null;
    }

    File file = File(result.path);
    return file;
  }

  //////////////////////////////////////////////////////////////////
  ////////////////////// / Multiple Image //////////////////////////
  //////////////////////////////////////////////////////////////////

  List<File> imageList = <File>[];

  Future<List<File>> pickMultipleImage() async {
    await showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Pick Image",
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              BottomSheetItemRow(
                title: 'Gallery',
                icon: Icons.image,
                isDisabled: false,
                onTap: () async {
                  imageList.addAll(await multipleImgFromGallery());
                  // Navigator.of(context).pop();
                  Get.back();
                },
              ),
              BottomSheetItemRow(
                title: 'Camera',
                icon: Icons.camera_alt_outlined,
                isDisabled: false,
                onTap: () async {
                  selectedImage = await imgFromCamera();
                  if (selectedImage != null) {
                    imageList.add(selectedImage!);
                  }
                  //Navigator.of(context).pop();
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
    return imageList;
  }

  Future<List<File>> multipleImgFromGallery() async {
    List<XFile> pickedFile = await ImagePicker().pickMultiImage();

    if (pickedFile.isNotEmpty) {
      return await compressMultipleImage(pickedFile);
    } else {
      return [];
    }
  }

  Future<List<File>> compressMultipleImage(List<XFile> images) async {
    List<File> tempList = <File>[];
    if (images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
        final dir = await path_provider.getTemporaryDirectory();
        final targetPath = '${dir.absolute.path}/$timeStamp.jpg';

        final result = await FlutterImageCompress.compressAndGetFile(
          images[i].path, targetPath,
          minHeight: 1080, //you can play with this to reduce siz
          minWidth: 1080,
          quality: 100,
        );

        double length = await checkImageSize(result!);

        if (length > 2) {
          CommonFunction.showSnackBar(
            title: "Error",
            message: "image size should be less then 2MB",
          );
        } else {
          File file = File(result.path);
          tempList.add(file);
        }
      }

      return tempList;
    } else {
      return [];
    }
  }

  Future<double> checkImageSize(XFile file) async {
    final data = await file.readAsBytes();
    final newKb = data.length / 1024;
    final newMb = newKb / 1024;
    return newMb;
  }
}
