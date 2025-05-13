#include "animatedframeitem.h"

AnimatedFrameItem::AnimatedFrameItem(QQuickItem* parent)
    : QQuickPaintedItem(parent)
    , m_frameNumber(0)
{
    setAntialiasing(true);
}

void AnimatedFrameItem::paint(QPainter* painter)
{
    if (m_frameNumber >= 0 && m_frameNumber < m_imageReader.size() && !m_imageReader.at(m_frameNumber).isNull()) {
        painter->drawImage(QRect(0, 0, width(), height()), m_imageReader.at(m_frameNumber));
    }
}

void AnimatedFrameItem::setSource(const QString& source)
{
    m_imageReader.clear();
    QDirIterator it(source);
    QStringList names;
    while (it.hasNext()) {
        names << it.next();
    }
    names.sort(Qt::CaseSensitive);
    m_totalFrames = names.count();
    if (m_totalFrames > 0) {
        foreach (const auto& name, names) {
            m_imageReader.append(QImage(name));
        }
        m_frameNumber = 0;
        update();
    }
}

int AnimatedFrameItem::frameNumber() const
{
    return m_frameNumber;
}

void AnimatedFrameItem::setFrameNumber(int frameNumber)
{
    if (m_frameNumber != frameNumber) {
        m_frameNumber = qBound(0, frameNumber, m_totalFrames - 1);
        update();
        emit frameNumberChanged();
    }
}

int AnimatedFrameItem::totalFrames() const
{
    return m_totalFrames;
}
