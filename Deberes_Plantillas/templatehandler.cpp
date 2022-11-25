#include "templatehandler.h"

TemplateHandler::TemplateHandler(QObject *parent)
    : QObject{parent}
{

}

bool TemplateHandler::abrirPlantilla(const QString &path)
{
    QFile plantilla(path);

    if (plantilla.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QString textoLeido = plantilla.readAll();

        partesPlantilla = textoLeido.split("###");

        int campoParaCompletar = 1;

        for (; campoParaCompletar < partesPlantilla.size(); campoParaCompletar += 2) {

            if (!tagsCampos.contains(partesPlantilla[campoParaCompletar])) {
                tagsCampos.append(partesPlantilla[campoParaCompletar]);

                campos[partesPlantilla[campoParaCompletar]] = "";
            }
        }
        return true;
    }
    else return false;
}

QStringList TemplateHandler::obtenerCampos()
{
    return tagsCampos;
}

void TemplateHandler::completarCampo(const QString &campo, const QString &contenido)
{
    if (tagsCampos.contains(campo)) {
        campos[campo] = contenido;
    }
}

void TemplateHandler::guardarPDF(const QString &file)
{
    for (int i = 1; i < partesPlantilla.size(); i += 2) {
        partesPlantilla[i] = campos[partesPlantilla[i]];
    }

    QString html = partesPlantilla.join("");

    html.replace("\r", "<br>");
    html.replace("\n", "<br>");

    QTextDocument documento;
    documento.setHtml(html);

    QPrinter impresora(QPrinter::HighResolution);
    impresora.setOutputFormat(QPrinter::PdfFormat);
    impresora.setOutputFileName(file);
    impresora.setPageMargins(QMargins(10, 20, 10, 15));

    documento.print(&impresora);
}
