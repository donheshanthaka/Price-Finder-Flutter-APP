<h1 align="center">
	<img width="500" src="https://user-images.githubusercontent.com/61963664/197162109-e3681c0c-bb93-4e1d-90c1-06f8d8911871.png" alt="Price Finder">
	<br>

</h1>

![price_finder_mockup](https://user-images.githubusercontent.com/61963664/197163864-abb2d9f9-4b11-428f-8adf-a8114c3dbcdc.png)


Price Finder is a mobile application developed using Flutter framework to identify the current market price of vehicles in Sri Lanka. It is capable of predicting vehicle models based on image inputs from the device camera and gallery with an accuracy of 97.26%. The image recognition feature is powered by a [vehicle image classification model](https://github.com/donheshanthaka/Price-Finder-Deep-Learning-Model) based on convolutional neural network (CNN) trained using a custom dataset created specifically for Sri Lankan vehicle market. The CNN model is hosted in Google Cloud Platform (GCP) using a [Flask API](https://github.com/donheshanthaka/Price-Finder-Flask-API) which acts as the backend for the price finder application. It also holds the capability to perform a market search based on the identified vehicle model and return the current market price along with the vehicle model details to the user through an API call. Currently the application is in beta release which only includes identification up to 4 vehicle models.

## 🔬 Overview of the tasks achieved within this project

* Implementation of **MVC architecture pattern** to structure the code base which separates internal representations of information from the UI modules.
* Effectively handled exceptions to inform the user of on conflicting situations without crashing the program.
* Comprehensive **UI/UX design** of the application to provide **seamless user experience** and interaction with **unique custom made graphics and animations**.
* Implementation of **API calls** for the demanding computational tasks, thus reducing the performance requirements per device and **increasing the range of devices** capable of running the application without lags.
* **Modular project structure** according to industry standards which increases the scalability of the application with minimal breaking changes.
* Integration of **environment configuration** to easily switch between development and production environments during development.


## 🧱 Tech Stack

|      Framework / Package      |
|:-----------------------------:|
|            Flutter            |
|     image_picker: 0.8.5+3     |
|     path_provider: 2.0.11     |
|          http: 0.13.4         |
|       mvc_pattern: 8.110      |
|          rive: 0.9.0          |
| flutter_image_compress: 1.0.0 |
|      flutter_icons: 1.1.0     |


| Backend Technologies               | Project Repository |
|------------------------------------|--------------------|
| Price Finder API                   |[Github-Repo](https://github.com/donheshanthaka/Price-Finder-Flask-API) |
| Vehicle Image Classification Model |[Github-Repo](https://github.com/donheshanthaka/Price-Finder-Deep-Learning-Model)|

## 📱 Demonstration

📍 Note: *Beta version could take up to 40 seconds due to server limitations.*

![54654_low](https://user-images.githubusercontent.com/61963664/197308888-d1dec8e5-4d34-43a9-913e-3ffaeea1bc14.gif)

## ⚙ Setup Instructions

*Prerequisites:*

* [Dart](https://dart.dev/get-dart)
* [Flutter](https://docs.flutter.dev/get-started/install)
* [Android studio](https://developer.android.com/studio)

**Clone the repository**

* Navigate to a folder in which you would like to setup the project.
* Open up a terminal in that folder and enter the command below to clone the repository.

```cmd
    git clone https://github.com/donheshanthaka/Price-Finder-Flutter-APP.git
```

* Navigate to the project folder

**Get the dependencies**

* Run the command mentioned below in the root of the project to get the dependencies.

```cmd
	flutter pub get
```

**Setup the price finder API**

In order to run this application on the local machine, an instance of the backend api should be available as well. It handles the core functionality of the application to identify vehicles and retrieve current market price.

📌 *To setup the backend api locally follow the documentation of the repository mentioned bellow before continuing further on the setup process.*

* [Price Finder API](https://github.com/donheshanthaka/Price-Finder-Flask-API)

**Create environment configuration files**

* A sample configuration file has been provided under assets folder.

`assets/config/app_config_example.json`

example:

```json
{
    "API_URL": "YOUR_API_URL"
}
```

* Create a new json file named `app_config_dev.json` in the same location as the sample.
* Copy the content of the example json file and change the `API_URL` value to the ip address used in setting up the API.
* Do the same if you are making a production server as well and name that file `app_config_prod.json` and add the production `API_URL`.


## 🖥 Run Locally

📌 *Instructions provided for VS Code*

**Run the API server locally**

* Instructions provided on the [Price Finder API - Run Locally](https://github.com/donheshanthaka/Price-Finder-Flask-API#-run-locally) section on documentation.

**Start the android emulator**

* Press ctrl + shift + p
* select `Flutter: Select Device` and select the android device.
* Go to `Run and Debug` menu and from the dropdown in top left corner select `price_finder_dev`.
* press ▶ start debugging button and the app will start running on the emulator.

📍 Note: *Since Android emulator doesn't come with the vehicle images needed to test the full functionality, custom images can be added to the emulator by going to the gallery and performing a drag and drop from the computer to the emulated device. The added images will not appear instantly therefore, a cold boot is required after a few seconds the images have been copied.*

## 📡 Usage / Examples

The application's functionality can be tested by scanning the sample images given below.
Scanning each image will provide you with the identified model details along with the current market price of the respective model in Sri Lanka.

📍 Note: *Beta version could take up to 40 seconds due to server limitations.*

| Toyota Aqua 2014      |
|-----------------------|
|![Toyota Aqua 2014](https://user-images.githubusercontent.com/61963664/189027885-bab0d3f1-0fb9-46ac-aced-399ee1e248db.jpg)|

| Alto 2015             |
|-----------------------|
|![Alto 2015](https://user-images.githubusercontent.com/61963664/189027432-f2097048-98e4-4d99-bb48-51346430d5ce.jpg)|

| Hero Dash 2016        |
|-----------------------|
|![Hero Dash 2016](https://user-images.githubusercontent.com/61963664/189027704-d84a3b68-47b0-4f5c-8e41-1d7f95d3dfc0.jpg)|

| Wagon R Stingray 2018 |
|-----------------------|
|![Wagon R Stingray 2018](https://user-images.githubusercontent.com/61963664/189027996-e0f54463-deab-44d2-8aad-d6da64b6be25.jpg)|

## 🚀 Deployment (Google Play Store)

To be added....