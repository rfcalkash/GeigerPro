#include "gaspainter.h"

GasPainter::GasPainter()
{
    // initParticles();
    m_timer.setInterval(1000 / 30);
    m_timer.setSingleShot(false);
    connect(&m_timer, &QTimer::timeout, this, &GasPainter::updateParticles, Qt::QueuedConnection);
    connect(this, &GasPainter::widthChanged, this, &GasPainter::initParticles, Qt::QueuedConnection);
    connect(this, &GasPainter::heightChanged, this, &GasPainter::initParticles, Qt::QueuedConnection);
    if (m_running) {
        m_timer.start();
    }
}

bool GasPainter::hitWalls() const
{
    return m_hitWalls;
}

void GasPainter::setHitWalls(bool newHitWalls)
{
    if (m_hitWalls == newHitWalls)
        return;
    m_hitWalls = newHitWalls;
    emit hitWallsChanged();
}

int GasPainter::particlesAmount() const
{
    return m_particlesAmount;
}

void GasPainter::setParticlesAmount(int newParticlesAmount)
{
    if (m_particlesAmount == newParticlesAmount)
        return;
    m_particlesAmount = newParticlesAmount;
    {
        QMutexLocker locker(&m_listMutex);
        if (m_particles.size() > m_particlesAmount) {
            m_particles.resize(m_particlesAmount);
        } else {
            while (m_particles.size() < m_particlesAmount) {
                m_particles.append(initParticle());
            }
        }
    }
    emit particlesAmountChanged();
}

QColor GasPainter::particlesColor() const
{
    return m_particlesColor;
}

void GasPainter::setParticlesColor(const QColor& newParticlesColor)
{
    if (m_particlesColor == newParticlesColor)
        return;
    m_particlesColor = newParticlesColor;
    emit particlesColorChanged();
}

float GasPainter::speed() const
{
    return m_speed;
}

void GasPainter::setSpeed(float newSpeed)
{
    if (qFuzzyCompare(m_speed, newSpeed))
        return;
    m_speed = newSpeed;
    {
        QMutexLocker locker(&m_listMutex);
        foreach (const auto& particle, m_particles) {
            particle->velocity = QVector2D(0.5 - QRandomGenerator::global()->generateDouble(), 0.5 - QRandomGenerator::global()->generateDouble()).normalized() * m_speed;
        }
    }
    emit speedChanged();
}

void GasPainter::initParticles()
{
    QMutexLocker locker(&m_listMutex);
    m_particles.clear();
    m_particles.reserve(m_particlesAmount);
    for (int i = 0; i < m_particlesAmount; ++i) {
        m_particles.append(initParticle());
    }
}

QSharedPointer<Particle> GasPainter::initParticle()
{
    return QSharedPointer<Particle>(new Particle(QVector2D(0.5 - QRandomGenerator::global()->generateDouble(), 0.5 - QRandomGenerator::global()->generateDouble()).normalized() * m_speed,
        QPointF(QRandomGenerator::global()->generateDouble() * width(), QRandomGenerator::global()->generateDouble() * height())));
}

void GasPainter::updateParticles()
{
    const auto multiplier = qSqrt(float(width()) * float(height()));
    const auto radius = multiplier * m_particleSize / 2;
    QMutexLocker locker(&m_listMutex);
    foreach (const auto& particle, m_particles) {
        auto newpos = particle->position + particle->velocity.toPointF() * radius;
        if (!m_hitWalls) {
            if (!boundingRect().contains(newpos)) {
                newpos.setX(std::fmod(newpos.x(), width()));
                if (newpos.x() < 0) {
                    newpos.setX(newpos.x() + width());
                }
                newpos.setY(std::fmod(newpos.y(), height()));
                if (newpos.y() < 0) {
                    newpos.setY(newpos.y() + height());
                }
            }
        } else {
            const QRectF rect(newpos - QPointF(radius, radius), newpos + QPointF(radius, radius));
            if (!boundingRect().contains(rect)) {
                const auto newX = qBound(radius, newpos.x(), width() - radius);
                const auto newY = qBound(radius, newpos.y(), height() - radius);
                if (newX != newpos.x()) {
                    particle->velocity.setX(-particle->velocity.x());
                }
                if (newY != newpos.y()) {
                    particle->velocity.setY(-particle->velocity.y());
                }
                newpos.setX(newX);
                newpos.setY(newY);
            }
        }
        particle->position = newpos;
    }
    update();
}

void GasPainter::paint(QPainter* painter)
{
    const auto radius = qSqrt(width() * height()) * m_particleSize / 2;
    QMutexLocker locker(&m_listMutex);
    painter->setBrush(ParticlePainter::getGradient(m_particlesColor));
    painter->setPen("transparent");
    foreach (const auto& particle, m_particles) {
        painter->drawEllipse(particle->position, radius, radius);
    }
}

float GasPainter::particleSize() const
{
    return m_particleSize;
}

void GasPainter::setParticleSize(float newParticleSize)
{
    if (qFuzzyCompare(m_particleSize, newParticleSize))
        return;
    m_particleSize = newParticleSize;
    emit particleSizeChanged();
}

bool GasPainter::running() const
{
    return m_running;
}

void GasPainter::setRunning(bool newRunning)
{
    if (m_running == newRunning)
        return;
    m_running = newRunning;
    if (m_running) {
        m_timer.start();
    } else {
        m_timer.stop();
    }
    emit runningChanged();
}
