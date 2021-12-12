# Icebox Freezer Manager

An Android app allowing you to better manage the contents of your freezer.

## Building

## Publishing (Local)

To prepare a build for deployment on a local device (for testing). Run the following:

    flutter build apk --split-per-abi

Then, attach the desired device to the computer using a USB cable, and run:

    flutter install

You may have to select the target device if more than one is attached.

## Publishing (Play Store)

To prepare a build for publishing on the Google Play Store, first ensure that your version information is up-to-date:

Ensure that the `pubspec.yml` and `about_app.dart` files have the correct desired version specified. When this is ready, 
run:

    flutter build appbundle

Then upload it to the desired product track in the store.

## Attributions

Chest
https://www.flaticon.com/free-icon/freezer_3939926
https://www.flaticon.com/premium-icon/refrigerator_4665345

Upright
https://www.flaticon.com/premium-icon/freezer_938041
https://www.flaticon.com/premium-icon/freezer_938092

Drawer
https://www.flaticon.com/premium-icon/freezer_3387449
https://www.flaticon.com/premium-icon/freezer_2944682

app
https://www.flaticon.com/free-icon/ice-cubes_2996063

Publishing 
Need to setup build keys key.properties file - see https://docs.flutter.dev/deployment/android