// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "general": {
    "back": "Back",
    "next": "Next",
    "step": "Step",
    "finish": "Finish",
    "in_progress": "In progress...",
    "of": "of",
    "search": "Search here..."
  },
  "exceptions": {
    "canceled": "Request canceled!",
    "timedOut": "Request timedOut!",
    "responseError": "Server response error!",
    "noInternet": "Check your internet connection!",
    "serverError": "Server Error!",
    "unknown": "Unexpected error occurred!"
  },
  "validations": {
    "required": "This is required!",
    "user_name": "Enter your user name or phone number!",
    "password": "Enter a password!",
    "phone_number": "Enter a valid phone number!",
    "full_name": "Enter your full name!",
    "business_name": "Enter your business name!",
    "address": "Select your address!"
  },
  "splash": {
    "text": "Enjoy the orders notification tone"
  },
  "user": {
    "password": "password",
    "phone_number": "Phone Number",
    "welcome": {
      "headline": "Stand out from\nyour competitors",
      "sub_title": "Gain a wider range of knowledge, and let\npeople know all about your dishes and\n offerings"
    },
    "sign_up": {
      "title": "Sign Up",
      "headline": "Hello!, Sign up\nto get started",
      "have_account": "Are you have an account?",
      "country_code": "Choose the country code",
      "full_name": "Full name",
      "business_name": "Business name",
      "address": "Business address line"
    },
    "login": {
      "title": "Login",
      "logging": "Logging in...",
      "headline": "Hello again!\nWe missed you!",
      "have_account": "Not have an account?",
      "forget": "Forget password?",
      "user_name": "Phone number / Username"
    },
    "Verification": {
      "title": "Verification code",
      "headline": "We have sent you a message with the activation to\n{}",
      "did_not_receive_code": "Didn't receive code?",
      "resend": "Resend",
      "user_name": "Phone number / Username"
    },
    "complete_information": {
      "title": "Complete Information",
      "working_time_title": "Working days and hours",
      "contact_title": "Contact Information",
      "work_days": "Work days",
      "work_hours": "Work hours",
      "main_category_title": "Main category",
      "sub_category_title": "Popular food lists categories"
    }
  }
};
static const Map<String,dynamic> ar = {
  "splash": {
    "text": "Enjoy the orders notification tone"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ar": ar};
}
