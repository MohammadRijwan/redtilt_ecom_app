# E-Commerce App

A mobile application for users to track and manage personal expenses.


## Features
```sh
• Add Expense : Users can input the amount, date, and a brief description.
• View Expenses: Display expenses in a list, sorted and filterable by date.
• Edit/Delete Expense : Modify or remove expense entries.
• Expense Summary : Show summaries categorized by type, on a weekly or monthly basis.
• Reminder Notifications: Set up reminders for users to record their daily expenses.
```

## Libraries used
```sh
• Riverpod: used for state management
• Shared Preferences: used for local database.
• FirebaseAuth: used for user Authentication.
• FirebaseStorage: used for storing user information.
```

## Project Structure and Architecture

This code uses clean architecture with domain, data and ui layer implementations to create the app. The key feature of app is to add/update/delete the product items in cart and
search the product by name and its id. The app displays a list of Products from the local database if internet connection is not available otherwise it fetches the data from the server.

## Directory Structure
```sh
lib->
main.dart
splash_screen.dart
    src->
        core->
              common->
                    cache_network_widget.dart
                    flutter_toast.dart
                    spinkit_widget.dart
                    waiting_screen.dart
              data->
                        auth_repo->
                            auth_repo.dart
                        firebase_db->
                            firebase_db.dart
                        offline_data_repo->
                            offline_data_repo.dart
                        product_repo->
                            product_repo.dart
              domain->
                        interface->
                                i_auth_repo->
                                        i_auth_repo.dart
                                i_db->
                                        i_db.dart
                                i_product_repo->
                                        i_product_repo.dart                            
                        models->
                                product.dart
                                user.dart   
              provider->
                        app_providers.dart                                            
              util->
                        app_router.dart

        feature->
                auth->
                        login->
                                login_screen.dart
                                login_vm.dart
                        signup->
                                signup_screen.dart
                                signup_vm.dart
                cart->
                        cart_screen.dart
                        cart_notifier.dart
                        cart_state.dart
                        
                order_checkout->
                        presentation->
                                order_checkout_screen.dart
                product->
                        presentation->
                                product_screen.dart
                                product_vm.dart
                                widgets->
                                      add_remove_button.dart
                                      cart_item.dart
                                      product_card.dart
                product_details->
                        presentation->
                                product_details_screen.dart                                      

```
## The app is organized into layers, with the each having its own responsibilities

• main.dart file at the top, entry point for application.

• splash.dart file, which initializes the app.


## The features directory contains all the required features of the application.

## auth layer (auth folder includes)

• Displays the UI for add expense, expense list and view summary of expenses.

• Presentation folder also includes screens and view models. View Model is responsible to displaying the data in the screen and maintain the state.


## domain layer contains interface and model

• Domain layer contains interface and model to structure the app in proper way.

## data layer contains repository which fetches products from api or local database.

Data layer contains auth, firebase, offline_data and product repository, it is responsible for fetching data from the server and local database.


## To run app -> flutter build  command









