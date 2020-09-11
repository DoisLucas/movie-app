## MovieApp

### About:

Application that will consume The Movie Database (TMDb) where you can view upcoming movies and search for movies by text.

### Clean Architecture:

**Robert C. Martin** states that, to be considered "clean", an architecture must have at least 4 main and independent layers. They are:

1. Enterprise Business Rules
2. Application Business Rules
3. Interface Adapters
4. Frameworks & Drivers (External)

<img src="readme_imgs/img3.png" width="600">

### Clean Dart

<img src="readme_imgs/img1.png" width="600">


By using Flutter as an example, we have four layers, keeping the "plugin architecture", with the main focus on the Application Domain. In this layer inhabits the two main business rules, the **entities** and the **usecases**.

<img src="readme_imgs/img2.png" width="600">

### Packages used:

#### [Dio:](https://pub.dev/packages/dio)
> A powerful Http client for Dart, which supports Interceptors, Global configuration, FormData, Request Cancellation, File downloading, Timeout etc.

#### [RxDart:](https://pub.dev/packages/rxdart)
> RxDart is a reactive functional programming library for Google Dart, based on ReactiveX.

#### [GetIt:](https://pub.dev/packages/get_it)
> This is a simple Service Locator for Dart and Flutter projects with some additional goodies highly inspired by Splat. It can be used instead of InheritedWidget or Provider to access objects e.g. from your UI.

#### [transparent_image:](https://pub.dev/packages/transparent_image)
> A simple transparent image. Represented as a Uint8List, which was originally extracted from the Flutter codebase (was private in the test package).

