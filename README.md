# Currency Exchange App
### License
Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg

## About
This is a simple currency exchange app that shows you the exchange rate of different currencies. 

The app is built using the [Flutter](https://flutter.dev/) framework.

## Getting Started

To run the app, you need to have Flutter installed on your machine. You can find instructions on how to install Flutter [here](https://flutter.dev/docs/get-started/install).

Once you have Flutter installed, you can run the app on your device or emulator by running the following command:

```bash
flutter run \
--dart-define=CURRENCY_SERVICE_TO_USE=random \
```

Currently there is only one currency service that can be used:
- `random`: This service returns random exchange rates for the currencies that are supported by the app. In order to use this service, you need to run the app with the `--dart-define=CURRENCY_SERVICE_TO_USE=random` flag. You also need to clone this repository and run the [currency-service](https://github.com/cuidtech/developers/tree/main) from the `mobile/task/server` directory. You can find instructions on how to run the currency service [here](https://github.com/cuidtech/developers/tree/main/mobile/task).

## Screenshots
<img width="300" alt="Curex App - Screenshot 1" src="https://github.com/rafaelortizzableh/curex/assets/57945332/2da0b110-546c-4185-b6a7-7bb75d58d4aa">

<img width="300" alt="Curex App - Screenshot 2" src="https://github.com/rafaelortizzableh/curex/assets/57945332/40253ae3-b921-4cd7-838e-a006b8b3be1d">

<img width="300" alt="Curex App - Screenshot 3" src="https://github.com/rafaelortizzableh/curex/assets/57945332/fe5c5c35-118c-4f95-83c1-6ff92dbe54fb">

<img width="300" alt="Curex App - Screenshot 4" src="https://github.com/rafaelortizzableh/curex/assets/57945332/7b0f141a-8494-493e-b746-da8954f32ad8">

<img width="300" alt="Curex App - Screenshot 5" src="https://github.com/rafaelortizzableh/curex/assets/57945332/6dcdd30d-8699-4e9c-9fdb-245ca1d2731c">
