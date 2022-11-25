#include "templatehandlerinterface.h"

TemplateHandlerInterface::TemplateHandlerInterface(QObject *parent)
    : QObject{parent}
{

}

bool TemplateHandlerInterface::abrirPlantilla(const QString &path)
{
    return handler.abrirPlantilla(path);
}

QStringList TemplateHandlerInterface::obtenerCampos()
{
    return handler.obtenerCampos();
}

void TemplateHandlerInterface::completarCampo(const QString &campo, const QString &contenido)
{
    handler.completarCampo(campo, contenido);
}

void TemplateHandlerInterface::guardarPDF(const QString &file)
{
    handler.guardarPDF(file);
}
