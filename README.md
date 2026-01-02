# buymed_test

A project for testing round at Buymed

This project using Flutter framework (version `3.38.5`), and BLoC for state management. 

## How to run

After checking out the repo, run the commands below in the root of this project by order:

```
dart pub get
```

```
dart run build_runner build -d
```

```
flutter run
```

## More about this project

Because this is a simple test project, I used the simple approaches to implement, but still keep the separation of concerns:
**Presentation, Domain and Data** and **layer-first structure**, **repository pattern** (without abstraction).

Using BLoC for State Management may create more boilerplate code, but it help separating UI and Logic code, also achieve a good UX in this app: Debounce the search event.

### Things to improve: 
| Description                                                | Note                             |
|------------------------------------------------------------|----------------------------------|
| localization                                               | currently hardcode               |
| custom, centralized theme                                  | currently fixed, separated theme |
| allow set a specific quantity instead of increase/decrease | not implemented                  |
| load data from remote source                               | not implemented                  |
| pull to refresh                                            | not implemented                  |
| paging/load more                                           | not implemented                  |
| abstraction repository                                     | not implemented                  |
| widget/unit test                                           | not implemented                  |
