# E-Commerce App

## Introduction

This code is written with the help of clean architecture with domain, 
data and ui layer implementations to create the app and libraries used are 
Riverpod, Shared Preferences, FirebaseAuth, FirebaseStorage.

The key feature of app is to add/update/delete the product items in cart and
search the product by name and product id. The app displays a list of Products 
from the local database if internet connection is not available otherwise 
it fetches the data from the server. and also added animations.



## Features
```sh
• Authentication : Users can login and signup with email and password.
• Product List: Display Products in a list, add, remove product in cart and search by name and id.
• Product Details : Display product details.
• Cart : Add and remove product in cart.
• Order Checkout :Display order summary and place order.

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

## The core directory contains all the required files.

## common layer 

• common folder contains common files for all the layers.

## domain layer

• Domain layer contains interface and model to structure the app in proper way.

## data layer

• Data layer contains auth, firebase, offline_data and product repository, it is responsible for fetching data from the server and local database.

## provider layer

• Provider layer contains all the required providers for the app.

## util layer.

• Util layer contains all the required utils for the app.



## The features directory contains all the required features of the application.

## auth layer

• Auth folder contains login and signup feature.


## cart layer

• Cart folder contains cart feature with cart screen, cart notifier and cart state.

## order_checkout layer

• Order_checkout folder contains order checkout feature with order checkout screen.

## product layer

• Product folder contains product feature with product screen and product vm.

## product_details layer

• Product_details folder contains product_details feature with product_details screen.


## To run app -> flutter build  command









