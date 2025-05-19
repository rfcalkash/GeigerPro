#ifndef GASPAINTER_H
#define GASPAINTER_H

#include "particlepainter.h"
#include <QMutex>
#include <QObject>
#include <QPainter>
#include <QQuickItem>
#include <QQuickPaintedItem>
#include <QRandomGenerator>
#include <QTimer>

struct Particle {
    QVector2D velocity;
    QPointF position;
    Q_DISABLE_COPY_MOVE(Particle)
    Particle(QVector2D velocity, QPointF position)
        : velocity(velocity)
        , position(position)
    {
    }
};

class GasPainter : public QQuickPaintedItem {
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(bool hitWalls READ hitWalls WRITE setHitWalls NOTIFY hitWallsChanged FINAL)
    Q_PROPERTY(int particlesAmount READ particlesAmount WRITE setParticlesAmount NOTIFY particlesAmountChanged FINAL)
    Q_PROPERTY(QColor particlesColor READ particlesColor WRITE setParticlesColor NOTIFY particlesColorChanged FINAL)
    Q_PROPERTY(float speed READ speed WRITE setSpeed NOTIFY speedChanged FINAL)
    Q_PROPERTY(float particleSize READ particleSize WRITE setParticleSize NOTIFY particleSizeChanged FINAL)
    Q_PROPERTY(bool running READ running WRITE setRunning NOTIFY runningChanged FINAL)

public:
    GasPainter();
    bool hitWalls() const;
    void setHitWalls(bool newHitWalls);
    int particlesAmount() const;
    void setParticlesAmount(int newParticlesAmount);

    QColor particlesColor() const;
    void setParticlesColor(const QColor& newParticlesColor);

    float speed() const;
    void setSpeed(float newSpeed);

signals:
    void hitWallsChanged();
    void particlesAmountChanged();

    void particlesColorChanged();

    void speedChanged();

    void particleSizeChanged();

    void runningChanged();

private:
    QMutex m_listMutex;
    bool m_hitWalls = true;
    int m_particlesAmount = 200;
    QColor m_particlesColor = "grey";
    float m_speed = 1;
    float m_particleSize = 0.03;

    QSharedPointer<Particle> initParticle();
    QList<QSharedPointer<Particle>> m_particles;

    bool m_running = true;

    QTimer m_timer;

private slots:
    void updateParticles();
    void initParticles();

public:
    void paint(QPainter* painter) override;
    float particleSize() const;
    void setParticleSize(float newParticleSize);
    bool running() const;
    void setRunning(bool newRunning);
};

#endif // GASPAINTER_H
