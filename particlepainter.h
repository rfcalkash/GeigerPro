#ifndef PARTICLEPAINTER_H
#define PARTICLEPAINTER_H

#include <QObject>
#include <QPainter>
#include <QQuickItem>
#include <QQuickPaintedItem>

class ParticlePainter : public QQuickPaintedItem {
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)
public:
    ParticlePainter();

    // QQuickPaintedItem interface

    static QRadialGradient getGradient(const QColor& color);

public:
    void paint(QPainter* painter) override;
    QColor color() const;
    void setColor(const QColor& newColor);
signals:
    void colorChanged();

private:
    QColor m_color;
};

#endif // PARTICLEPAINTER_H
