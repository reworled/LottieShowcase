#include "jsonfinder.h"

#include <QFile>
#include <QSettings>

JSONFinder::JSONFinder(QObject *parent) : QObject(parent)
  , m_settings("qt.io", "LottieShowcase")
  , m_watcher(this)
{
    m_dir = QDir(m_settings.value("dir", QDir::homePath()).toString());
    m_watcher.addPath(m_dir.absolutePath());
    connect(&m_watcher, &QFileSystemWatcher::directoryChanged, this, &JSONFinder::scan);
    scan();
}

void JSONFinder::deleteFile(QString filename)
{
    QFile f(m_dir.absolutePath() + QDir::separator() + filename);
    if (f.exists())
    {
        f.remove();
    }
}

void JSONFinder::scan()
{
    m_model = m_dir.entryList(QStringList() << "*.json", QDir::NoFilter, QDir::Time);
    emit modelChanged();
}

void JSONFinder::setDirectory(QString dir)
{
    QDir newDir(dir);
    if (newDir != m_dir)
    {
        m_settings.setValue("dir", dir);
        m_dir = dir;
        scan();
        // probably not needed, but hey
        emit directoryChanged();
    }
}
