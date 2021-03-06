import QtQuick 2.2
import QtQuick.Layouts 1.2

import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.appearance 1.0 as Appearance
import org.kde.plasma.private.bluetooth 1.0 as PlasmaBt

RowLayout {
    spacing: 12

    PlasmaComponents.ToolButton {
        id: bluetoothSwitch
        Layout.alignment: Qt.AlignHCenter
        iconSource: "network-bluetooth"

        checked: btManager.bluetoothOperational
        enabled: btManager.bluetoothBlocked || btManager.adapters.length
        onClicked: {
            checked = !checked
            var enable = !btManager.bluetoothOperational;
            btManager.bluetoothBlocked = !enable;

            for (var i = 0; i < btManager.adapters.length; ++i) {
                var adapter = btManager.adapters[i];
                adapter.powered = enable;
            }
        }
    }

    PlasmaComponents.ToolButton {
        id: darkModeSwitch
        Layout.alignment: Qt.AlignHCenter
        iconSource: "widget-control-dark-theme"

        property var darkModeIndex : -1;
        property var previousIndex : -1;
        enabled: darkModeIndex  != -1
        checked: Appearance.LookAndFeel.current == darkModeIndex
        onClicked: {
            if (checked)
                Appearance.LookAndFeel.current = previousIndex
            else {
                previousIndex = Appearance.LookAndFeel.current
                Appearance.LookAndFeel.current  = darkModeIndex
            }
        }

        Repeater {
            model: Appearance.LookAndFeel

            Component {
                Item {
                    Component.onCompleted: {
                        if (name == "Breeze Dark") {
                            darkModeSwitch.darkModeIndex = index;
                        }
                    }
                }
            }
        }
    }

    PlasmaComponents.ToolButton {
        id: wirelessSwitch
        Layout.alignment: Qt.AlignHCenter
        iconSource: "widget-control-wireless"

        checked: enabled && enabledConnections.wirelessEnabled;
        enabled: !airplaneModeSwitch.airplaneModeEnabled && enabledConnections.wirelessHwEnabled  && availableNetworkDevices.wirelessDeviceAvailable;
        onClicked: networkHandler.enableWireless(!checked);
    }

    PlasmaComponents.ToolButton {
        id: airplaneModeSwitch
        property bool airplaneModeEnabled: false

        Layout.alignment: Qt.AlignHCenter
        checked: airplaneModeEnabled
        iconSource: "widget-control-airplane-mode"

        onClicked: {
            airplaneModeEnabled = !airplaneModeEnabled;
            networkHandler.enableAirplaneMode(airplaneModeEnabled);
        }
    }
}
