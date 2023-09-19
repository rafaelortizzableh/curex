# Currency Exchange App

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

Currently there are is only one currency service that can be used:
- `random`: This service returns random exchange rates for the currencies that are supported by the app. In order to use this service, you need to run the app with the `--dart-define=CURRENCY_SERVICE_TO_USE=random` flag. You also need to clone this repository and run the [currency-service](https://github.com/cuidtech/developers/tree/main) from the `mobile/task/server` directory. You can find instructions on how to run the currency service [here](https://github.com/cuidtech/developers/tree/main/mobile/task).

## Screenshots
<img width="300" alt="Curex App - Screenshot 1" src="https://github.com/rafaelortizzableh/curex/assets/UPDATE_ME_1">

<img width="300" alt="Curex App - Screenshot 2" src="https://github.com/rafaelortizzableh/curex/assets/UPDATE_ME_2">

<img width="300" alt="Curex App - Screenshot 3" src="https://github.com/rafaelortizzableh/curex/assets/UPDATE_ME_3">

<img width="300" alt="Curex App - Screenshot 4" src="https://github.com/rafaelortizzableh/curex/assets/UPDATE_ME_4">

<img width="300" alt="Curex App - Screenshot 5" src="https://github.com/rafaelortizzableh/curex/assets/UPDATE_ME_5">