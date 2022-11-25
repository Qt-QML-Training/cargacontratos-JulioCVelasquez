#ifndef TEMPLATEHANDLER_H
#define TEMPLATEHANDLER_H

#include <QObject>
#include <QFile>
#include <QMap>
#include <QtPrintSupport/QPrinter>
#include <QTextDocument>

class TemplateHandler : public QObject
{
    Q_OBJECT
public:
    explicit TemplateHandler(QObject *parent = nullptr);

    bool abrirPlantilla(const QString &path);
    QStringList obtenerCampos();
    void completarCampo(const QString &campo, const QString &contenido);
    void guardarPDF(const QString &file);

private:
    QStringList partesPlantilla;
    QStringList tagsCampos;
    QMap <QString, QString> campos;

signals:

};

#endif // TEMPLATEHANDLER_H
