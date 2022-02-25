import 'package:get/get.dart';
import 'package:ketemaa/core/language/language_string.dart';

enum LanguageType { ENG, BAN, ARB, LI }

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          AppLanguageString.APPNAME: 'Vemate',
          AppLanguageString.GOOGLE_LOGIN: 'Continue with Google',
          'Facebook_Login': 'Continue with Facebook',
          'Apple_Login': 'Continue with Apple',
          'Email_Login': 'Continue with Email',
          'Create_Account': 'Don\'t have any account? Create One',
          'Accept_TnC': 'By signing up I agree with the ',
          'Terms_Condition': 'Terms and Conditions',
          'Privacy_Policy': 'Privacy Policy',
          'Sign_Up_To': 'Sign up to',
          'Log_In_With_Email': 'Log in with email',
          'Name': 'Name',
          'Email': 'Email',
          AppLanguageString.PASSWORD: 'Password',
          AppLanguageString.CONFIRMPASSWORD: 'Confirm Password',
          'Sign_Up': 'Sign Up',
          'Log_In': 'Log In',
          'and': "and",
          AppLanguageString.USERNAME: 'Username',
          AppLanguageString.SEARCH_HINT: 'What are you looking for?',
          AppLanguageString.POPULAR_IN: 'Popular in',
          AppLanguageString.RESIDENTIAL_FOR_RENT: 'Residential for Rent',
          AppLanguageString.SELECT_CITY: 'Select a City',
          AppLanguageString.PLACEYOURADD: 'Where should we place your ad?',
          AppLanguageString.SELECT_CATEGORY: 'What are you listing?',
          AppLanguageString.MATCH_CATEGORY:
              'Choose the category that your ad fits into.',
          AppLanguageString.PLACE_A_ADD: 'Place an Ad',
          AppLanguageString.PROPERTY_ADD_TITLE:
              'First, enter a short title to describe you listing',
          AppLanguageString.PROPERTY_ADD_DISCRIPTION:
              'Make your title informative and attractive.',
          AppLanguageString.PROPERTY_ADD_TITLE_HINT:
              'e.g. Studio apt. available for monthly rent',
          AppLanguageString.LETS_GO: 'Let\'s Go',
          AppLanguageString.PROPERTY_AGENT_TITLE:
              'Are you a landlord or an agent?',
          AppLanguageString.PROPERTY_LANDLORD: 'Landlord',
          AppLanguageString.PROPERTY_AGENT: 'Agent',
          AppLanguageString.PROPERTY_LISTFORM_TITLE: 'You\'re almost there',
          AppLanguageString.PROPERTY_LISTFORM_DES:
              'Include as much details and pictures as possible, and set the right price',
          AppLanguageString.OPTIONAL: '*Optional',
          AppLanguageString.TITLE: 'Title',
          AppLanguageString.TOUR360: '360 Tour URL',
          AppLanguageString.YOUTUBE: 'Youtube URL',
          AppLanguageString.PHONE: 'Phone number',
          AppLanguageString.PRICE: 'Price per year',
          AppLanguageString.PHONE: 'Describe your property',
          AppLanguageString.SIZE: 'Size',
          AppLanguageString.BEDROOM: 'Bedrooms',
          AppLanguageString.PR_REF_ID: 'Property Reference ID',
          AppLanguageString.RERA_LANDLORD: 'RERA Landlord Name',
          AppLanguageString.RERA_DEED_NUMBER: 'RERA title deed number',
          AppLanguageString.RERA_PRE_REG: 'RERA pre registration number',
          AppLanguageString.CNT_PER: 'RERA Contact Period (in months)',
          AppLanguageString.NOTICE: 'Notice Period (in months)',
          AppLanguageString.MAINTAIN_FEE: 'Maintenance Fee',
          AppLanguageString.BUILDING: 'Building',
          AppLanguageString.NEIGHBOUR: 'Neighbourhood',
          AppLanguageString.LOCATION: 'Location',
          AppLanguageString.PROPERTY_INFO: 'Property Info',
          AppLanguageString.SHOWMORE: 'Show More Details',
          AppLanguageString.SHOWLESS: 'Show Less Details',
          AppLanguageString.AGENCY: 'Agency Profile',
          AppLanguageString.PROPERTYDESCRIPTION: 'Description',
          AppLanguageString.SCHEDULEVIEW: 'Schedule Viewing',
          AppLanguageString.SCHEDULEVIEWDES: 'When are you free? Suggest a viewing time.',
        },
        'bd_BD': {},
      };
}
