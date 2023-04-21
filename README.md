# meteo_front_end

## Getting Started

1. Environnement de développement
    - Flutter (stable, 3.3.2)
    - macOS (M1, 12.5)
    - Xcode (13.4)/iOS 13
    - Android Studio (version 2021.2)/Android toolchain - develop for Android devices (Android SDK version 33.0.0)

2. Exécutez la commande suivante sur le terminal pour installer la bibliothèque dépendante.

    ```ruby
    cd meteo_front_end/
    fluter clean
    #安装依赖
    flutter pub get
    ```
3. Compiler et exécuter : ([IDE facultatif en cours d'exécution](https://docs.flutter.dev/get-started/editor))

    ```ruby
    cd meteo_front_end/
    # S'il est exécuté sur un appareil Apple
    cd ios/
    rm -rf Pods/
    rm -f Podfile.lock
    pod update 
    
    #Compiler et exécuter
    flutter run
    ```

    ## L'interface du l'application 

![Alt text](https://cdn.discordapp.com/attachments/1032261521625067592/1098647762154836028/simulator_screenshot_18B01876-A0A6-4199-A2DE-BAF3A53F0B36.png?raw=true "Page d'accueil")
![Alt text](images/p1_2.png?raw=true "Maps")
![Alt text](images/p1_3.png?raw=true "Site web")
![Alt text](images/p1_4.png?raw=true "Images ")
![Alt text](images/p1_5.png?raw=true "Profile ")
![Alt text](images/p1_6.png?raw=true "Services")