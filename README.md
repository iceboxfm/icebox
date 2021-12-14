# Icebox Freezer Manager

An Android app allowing you to better manage the contents of your freezer.

## Key Configuration (Once)

In order to build publishable app artifacts, the `android/key.properties` file should have the form as below:

    storePassword=<password from previous step>
    keyPassword=<password from previous step>
    keyAlias=upload
    storeFile=<location of the key store file, such as /Users/<user name>/upload-keystore.jks>

> WARNING: This configuration file should NOT be checked into source control with populated information.

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

Then upload the `./build/app/outputs/bundle/release/app-release.aab` file to the desired product track in the store.

## Attributions

This application contains icons from the [flaticon](https://www.flaticon.com) repository, created by the following authors: 
[justicon](https://www.flaticon.com/authors/justicon), [Freepik](https://www.freepik.com), 
[iconixar](https://www.flaticon.com/authors/iconixar), [surang](https://www.flaticon.com/authors/surang), 
[Pixelmeetup](https://www.flaticon.com/authors/pixelmeetup), [mynamepong](https://www.flaticon.com/authors/mynamepong), 
[Backwoods](https://www.flaticon.com/authors/backwoods)
