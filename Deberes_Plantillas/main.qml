import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs

import mi.clase

ApplicationWindow {
    id: ventana
    width: 640
    height: 480
    visible: true
    title: "Generador de contratos"

    color: "lightgrey"

    ListModel {
        id: listaModel
    }

    Rectangle {
        id: rectanguloPlantilla

        color: "white"

        height: parent.height / 3
        width: parent.width

        anchors.bottom: botonCargar.top
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.margins: 10

        radius: 5

        ListView {
            id: listaView

            anchors.fill: parent

            spacing: 10

            clip: true

            visible: false

            delegate: CampoInput {
                width: rectanguloPlantilla.width

                label: labelModel

                input: model.input

                onRectanguloCampoInputText: (texto) => {
                                                model.input = texto;
                                            }
            }
        }
    }

    Boton {
        id: botonCargar

        anchors.bottom: parent.bottom
        anchors.right: botonGenerar.left


        anchors.margins: 5

        texto: "Cargar plantilla"

        onClicked: {
            cargarPlantilla.open();

        }
    }

    Boton {
        id: botonGenerar

        anchors.bottom: parent.bottom
        anchors.right: parent.right

        anchors.margins: 5

        texto: "Generar PDF"

        onClicked: {
            for (var i = 0; i < listaModel.count; i++) {
                miHandler.completarCampo(listaModel.get(i).labelModel, listaModel.get(i).input);
            }
            miHandler.guardarPDF(guardarFileDialog.url);
            Qt.quit();
        }
    }

    FileDialog {
        id: cargarPlantilla

        title: "Seleccione su plantilla"

        nameFilters: ["*.cont"]

        onAccepted: {
            var url = cargarPlantilla.selectedFile.toString();
            url = url.replace(/^(file:\/{3})/,"");

            miHandler.abrirPlantilla(url);

            var labels = miHandler.obtenerCampos();

            listaView.visible = true

            for (var i = 0; i < labels.length; i++) {
                listaModel.append({labelModel: labels[i], input: ""});
            }

            listaView.model = listaModel;
        }
    }

    FileDialog {
        id: guardarFileDialog

        nameFilters: ["*.pdf"]

        fileMode: FileDialog.SaveFile

        onAccepted: {
           var url = guardarFileDialog.selectedFile();
        }
    }

    Handler {
        id: miHandler
    }
}
