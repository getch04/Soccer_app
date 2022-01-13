import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('soccer final app test', () {
    //signin - fixture
    final emailField = find.byValueKey('email_login');
    final passwordField = find.byValueKey('password_login');
    final loginButton = find.byValueKey('login_button');
    final signupButton = find.byValueKey('signup_button');
    final adminFixAdd = find.byValueKey('float_button');
    final firstClub = find.byValueKey('first_club');
    final firstClubItem = find.byValueKey('value');
    final secondClub = find.byValueKey('second_club');

    //Admin fixture detail
    final adminFixUpdate = find.byValueKey('item_0_fixture');
    final resultClub1 = find.byValueKey('result_club1_add');
    final resultClub2 = find.byValueKey('result_club2_add');
    final resultSave = find.byValueKey('result_save_button');
    //Result tab
    final resultTab = find.byValueKey('result_tab');

    //signup
    final fullNameSignup = find.byValueKey('name_signup');
    final emailSignup = find.byValueKey('email_signup');
    final phoneSignup = find.byValueKey('phone_signup');
    final passwordSignup = find.byValueKey('password_signup');
    final signUpButton1 = find.byValueKey('signup_button_1');

    //admin_fixture_add
    final add_icon = find.byValueKey('fix_add');
    final club_one = find.byValueKey('city');
    final club_two = find.byValueKey('united');
    final date_time_picker = find.byValueKey('date_time');
    final stadium = find.byValueKey('stadium_text');
    final latitude = find.byValueKey('lat_text');
    final longitude = find.byValueKey('log_text');
    final icon_btn = find.byValueKey('save_icon_btn');

    //addfixture

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() {
      if (driver != null) {
        driver.close();
      }
    });

    test('login + result add', () async {
      await driver.tap(emailField);
      await driver.enterText('di@email.com');
      await driver.tap(passwordField);
      await driver.enterText('123456');
      await driver.tap(loginButton);
      await driver.tap(adminFixUpdate);
      await driver.tap(resultClub1);
      await driver.enterText('3');
      await driver.tap(resultClub2);
      await driver.enterText('2');
      await driver.tap(resultSave);
    });

    // test('signup', () async {
    //   await driver.tap(signupButton);
    //   await driver.tap(fullNameSignup);
    //   await driver.enterText('Yosef Endale');
    //   await driver.tap(emailSignup);
    //   await driver.enterText('getch@email.com');
    //   await driver.tap(phoneSignup);
    //   await driver.enterText('0989121345');
    //   await driver.tap(passwordSignup);
    //   await driver.enterText('yosefendale');
    //   await driver.tap(signUpButton1);
    // });

    // test('login + fixture delete', () async {
    //   await driver.tap(emailField);
    //   await driver.enterText('g@email.com');
    //   await driver.tap(passwordField);
    //   await driver.enterText('123457');
    //   await driver.tap(loginButton);
    //   await driver.tap(adminFixUpdate);
    // });
    //

    // test('login + fixture add', () async {
    //   await driver.tap(emailField);
    //   await driver.enterText('g@email.com');
    //   await driver.tap(passwordField);
    //   await driver.enterText('123457');
    //   await driver.tap(loginButton);
    //   await driver.tap(add_icon);
    //   await driver.tap(club_one);
    //   await driver.tap(club_two);
    //   await driver.tap(date_time_picker);
    //   await driver.enterText('3 March, 2021 - 10:54 PM');
    //   await driver.tap(stadium);
    //   await driver.enterText('oltraford');
    //   await driver.tap(latitude);
    //   await driver.enterText('23.0');
    //   await driver.tap(longitude);
    //   await driver.enterText('45.0');
    //   await driver.tap(icon_btn);
    // });
  });
}
