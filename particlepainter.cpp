#include "particlepainter.h"
#include <qbrush.h>

ParticlePainter::ParticlePainter()
{
    connect(this, &ParticlePainter::widthChanged, this, &QQuickItem::update);
    connect(this, &ParticlePainter::heightChanged, this, &QQuickItem::update);
}

QRadialGradient ParticlePainter::getGradient(const QColor& color)
{
    QRadialGradient radialGradient({ 0.3, 0.3 }, 0.5);
    radialGradient.setCoordinateMode(QGradient::ObjectMode);
    radialGradient.setColorAt(0.0, "white");
    radialGradient.setColorAt(1.0, color);
    return radialGradient;
}

void ParticlePainter::paint(QPainter* painter)
{
    painter->setBrush(getGradient(m_color));
    painter->setPen("transparent");
    painter->drawEllipse(QRectF(0, 0, width(), height()));
}

QColor ParticlePainter::color() const
{
    return m_color;
}

void ParticlePainter::setColor(const QColor& newColor)
{
    if (m_color == newColor)
        return;
    m_color = newColor;
    update();
    emit colorChanged();
}
