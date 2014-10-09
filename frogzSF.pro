# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = frogzSF

CONFIG += sailfishapp

SOURCES += src/frogzSF.cpp

OTHER_FILES += qml/frogzSF.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/frogzSF.spec \
    rpm/frogzSF.yaml \
    frogzSF.desktop \
    qml/pages/ThirdPage.qml \
    qml/pages/content/bomb-action.wav \
    qml/pages/content/logic.js

