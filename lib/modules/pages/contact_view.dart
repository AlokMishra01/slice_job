import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '/packages/panara_dialogs/panara_dialogs.dart';
import '../../constants/app_colors.dart';
import '../../controllers/general_controller.dart';

class ContactView extends StatefulWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final Completer<GoogleMapController> _controller = Completer();

  static const _kSliceJob = CameraPosition(
    target: LatLng(27.726511, 85.330446),
    zoom: 18,
  );

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _mobile = TextEditingController();
  final _message = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _mobile.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final contact = context.watch<GeneralController>().contactUs;
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('Contact Us'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 10.0,
          ),
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text(
                        'Your Name',
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: AppColors.white.withOpacity(0.8),
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (((value ?? '').isEmpty)) {
                        return 'Please enter your name.';
                      }
                      return null;
                    },
                    controller: _name,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text(
                        'Your Email',
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: AppColors.white.withOpacity(0.8),
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      bool b = RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value ?? '');
                      if (!b) {
                        return 'Please enter valid email address';
                      }
                      return null;
                    },
                    controller: _email,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text(
                        'Your Contact Number',
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: AppColors.white.withOpacity(0.8),
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                    ),
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _mobile,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text(
                        'Your Message',
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: AppColors.white.withOpacity(0.8),
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 5,
                    validator: (value) {
                      if (((value ?? '').isEmpty)) {
                        return 'Please enter your message.';
                      }
                      return null;
                    },
                    controller: _message,
                  ),
                  const SizedBox(height: 10.0),
                  MaterialButton(
                    onPressed: _sendMessage,
                    child: Text(
                      'Send Message',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: double.infinity,
                    height: 56.0,
                    elevation: 0.0,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Material(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: HtmlWidget(
                    contact?.data?.contact ?? '',
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: width,
                height: width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    zoomGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    myLocationEnabled: false,
                    tiltGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                    scrollGesturesEnabled: false,
                    initialCameraPosition: _kSliceJob,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: {
                      const Marker(
                        markerId: MarkerId('SliceJob'),
                        position: LatLng(27.726511, 85.330446),
                        infoWindow: InfoWindow(
                          title: 'Slicejob Dot Com Pvt Ltd',
                          snippet: 'Baluwatar, Kathmandu',
                        ),
                      ),
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }

  _sendMessage() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_name.text.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Name",
        message: "Please enter your name.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    bool b = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(_email.text);
    if (!b) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Email",
        message: "Please enter your email address.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_message.text.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Message",
        message: "Please enter your message.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    final String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<GeneralController>().contactSend(
              name: _name.text.trim(),
              email: _email.text.trim(),
              number: _mobile.text.trim(),
              message: _message.text.trim(),
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      Navigator.pop(context);
    } else {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Failed",
        message: result,
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }
  }
}
