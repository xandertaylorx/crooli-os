/* Slides shown while Crooli OS installs. */
import QtQuick 2.15
import calamares.slideshow 1.0

Presentation {
    id: presentation

    property var slides: [
        { title: "Welcome to Crooli OS", body: "A calm, fast desktop that stays out of your way." },
        { title: "Apps in one place", body: "Open the App Store to install thousands of free apps with one click." },
        { title: "Updates look after themselves", body: "Security fixes install quietly in the background. No nagging." },
        { title: "Private by default", body: "No tracking, no ads, no account needed. Your computer is yours." },
        { title: "Almost done", body: "When it finishes, restart and take out the USB stick." }
    ]
    property int current: 0

    function nextSlide() { current = (current + 1) % slides.length }

    Timer {
        interval: 6000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: presentation.nextSlide()
    }

    Rectangle {
        anchors.fill: parent
        color: "#0A0A0A"

        Image {
            id: mark
            source: "logo.png"
            width: 72; height: 72
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: title.top
            anchors.bottomMargin: 28
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: title
            text: presentation.slides[presentation.current].title
            color: "#FFFFFF"
            font.family: "Crooli Sans"
            font.pixelSize: 30
            font.weight: Font.DemiBold
            anchors.centerIn: parent
        }

        Text {
            text: presentation.slides[presentation.current].body
            color: "#A1A1A1"
            font.family: "Crooli Sans"
            font.pixelSize: 16
            width: parent.width * 0.6
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: title.bottom
            anchors.topMargin: 14
        }

        Row {
            spacing: 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 32
            Repeater {
                model: presentation.slides.length
                Rectangle {
                    width: 6; height: 6; radius: 3
                    color: index === presentation.current ? "#3291FF" : "#333333"
                }
            }
        }
    }

    function onActivate() { current = 0 }
    function onLeave() {}
}
