import QtQuick

Item {
    id: campo

    property alias color: rectanguloCampo.color
    property alias label: rectanguloCampoLabel.text
    property alias input: rectanguloCampoInput.text

    height: rectanguloCampo.height

    signal rectanguloCampoInputText(text:string)

    Rectangle {
        id: rectanguloCampo

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.margins: 5

        height: 65

        radius: 5

        color: "lightgrey"

        Text {
            id: rectanguloCampoLabel

            text: ""

            height: 20

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 5

            verticalAlignment: TextInput.AlignVCenter

        }

        Rectangle {
            width: parent.width
            height: 30

            anchors.top: rectanguloCampoLabel.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 5

            radius: 5

            TextInput {
                id: rectanguloCampoInput

                anchors.fill: parent
                anchors.leftMargin: 5

                verticalAlignment: TextInput.AlignVCenter

                persistentSelection: true

                onTextChanged: {
                    campo.rectanguloCampoInputText(rectanguloCampoInput.text)
                }

            }
        }
    }
}
