#ifndef JSONFINDER_H
#define JSONFINDER_H

#include <QDir>
#include <QFileSystemWatcher>
#include <QObject>
#include <QSettings>

class JSONFinder : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList model READ model NOTIFY modelChanged)
    Q_PROPERTY(QString directory READ directory WRITE setDirectory NOTIFY directoryChanged)
public:
    explicit JSONFinder(QObject *parent = nullptr);
    QString directory() { return m_dir.path(); }
    QStringList model() { return m_model; }

signals:
    void directoryChanged();
    void modelChanged();

public slots:
    void deleteFile(QString filename);
    void scan();
    void setDirectory(QString dir);

private:
     QDir m_dir;
     QSettings m_settings;
     QFileSystemWatcher m_watcher;
     QStringList m_model;
};

#endif // JSONFINDER_H
