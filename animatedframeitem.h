#ifndef ANIMATEDFRAMEITEM_H
#define ANIMATEDFRAMEITEM_H

#include <QDirIterator>
#include <QFileInfo>
#include <QImage>
#include <QImageReader>
#include <QMovie>
#include <QObject>
#include <QPainter>
#include <QQuickItem>
#include <QQuickPaintedItem>

class AnimatedFrameItem : public QQuickPaintedItem {
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int frameNumber READ frameNumber WRITE setFrameNumber NOTIFY frameNumberChanged)
public:
    explicit AnimatedFrameItem(QQuickItem* parent = nullptr);
    ~AnimatedFrameItem() {};

    void paint(QPainter* painter) override;

    Q_INVOKABLE void setSource(const QString& source);

    int frameNumber() const;
    void setFrameNumber(int frameNumber);

    Q_INVOKABLE int totalFrames() const;

signals:
    void frameNumberChanged();

private:
    int m_totalFrames = 0;
    int m_frameNumber;
    QList<QImage> m_imageReader;
};

#endif // ANIMATEDFRAMEITEM_H
