import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

ApplicationWindow {
    id: root
    visible: true
    width: 360
    height: 640
    title: "Счетчик Гейгера"

    property double radiationLevel: 0.2 // Начальный уровень радиации (от 0.0 до 1.0)
    property int clicksPerMinute: Math.floor(radiationLevel * 200) + 10 // От 10 до 210 щелчков в минуту
    property int msBetweenClicks: clicksPerMinute > 0 ? 60000 / clicksPerMinute : 6000

    // Функция для рандомизации времени между щелчками в пределах ±10%
    function getRandomInterval() {
        // Вычисляем ±10% от базового интервала
        var variation = msBetweenClicks * 0.5;
        var min = msBetweenClicks - variation;
        var max = msBetweenClicks + variation;
        // Генерируем случайное значение в этом диапазоне
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    Rectangle {
        anchors.fill: parent
        color: "#F0F0F0"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            Item { Layout.fillHeight: true } // Верхний отступ

            // Круг с изменяющимся цветом
            Rectangle {
                id: radiationCircle
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: Math.min(parent.width - 40, 300)
                Layout.preferredHeight: Layout.preferredWidth
                radius: width / 2
                border.width: 3
                border.color: "#222222"

                // Градиент от зеленого к красному в зависимости от уровня радиации
                color: {
                    if (radiationLevel < 0.3) {
                        return Qt.rgba(0.2, 0.8, 0.2, 1.0); // Зеленый
                    } else if (radiationLevel < 1.2) {
                        return Qt.rgba(0.8, 0.8, 0.2, 1.0); // Желтый
                    } else if (radiationLevel < 10) {
                        return Qt.rgba(0.8, 0.5, 0.2, 1.0); // Оранжевый
                    } else {
                        return Qt.rgba(0.8, 0.2, 0.2, 1.0); // Красный
                    }
                }

                // Плавная анимация изменения цвета
                Behavior on color {
                    ColorAnimation { duration: 500 }
                }

                // Текст со значением радиации
                Text {
                    anchors.centerIn: parent
                    text: (radiationLevel).toFixed(1) + " μSv/h"
                    font.pixelSize: parent.width / 10
                    font.bold: true
                    color: "#222222"
                }

                // // Дополнительная информация
                // Text {
                //     anchors.horizontalCenter: parent.horizontalCenter
                //     anchors.top: parent.verticalCenter
                //     anchors.topMargin: 30
                //     text: clicksPerMinute + " щелчков/мин"
                //     font.pixelSize: parent.width / 15
                //     color: "#333333"
                // }
            }

            Item { Layout.fillHeight: true } // Средний отступ

            // Ползунок для изменения уровня радиации
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                Text {
                    text: "Уровень радиации:"
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignHCenter
                }

                Slider {
                    id: radiationSlider
                    Layout.fillWidth: true
                    from: 0.0
                    to: 10.0
                    value: radiationLevel

                    onValueChanged: {
                        radiationLevel = value;
                        clicksPerMinute = Math.min(2000,Math.floor(radiationLevel * 200) + 10);
                        msBetweenClicks = clicksPerMinute > 0 ? 60000 / clicksPerMinute : 2000;
                        // Сразу обновляем интервал таймера с учетом рандомизации
                        clickTimer.interval = getRandomInterval();
                    }
                }
            }

            Item { Layout.fillHeight: true } // Нижний отступ
        }
    }

    // Звуки щелчков счетчика Гейгера
    // Repeater{
    //     id: soundsR
    //     model:5
    //     delegate: SoundEffect {
    //         source: "qrc:/sounds/click"+index+".wav"
    //     }
    // }

    property var soundArray: []

    Component.onCompleted: {
        // Создаем SoundEffect динамически
        for (var i = 0; i < 5; i++) {
            var soundEffect = Qt.createQmlObject(
                'import QtMultimedia; SoundEffect { source: "qrc:/sounds/click'+i+'.wav"}',
                root,
                "dynamicSound" + i
            )
            soundArray.push(soundEffect)
        }
    }

    // Таймер для генерации щелчков
    Timer {
        id: clickTimer
        interval: getRandomInterval() // Начальный интервал с рандомизацией
        running: true
        repeat: true

        onTriggered: {
            var sounds = []
            for (let i = 0; i < 5; i++) {
                if(!soundArray[i].playing){
                    sounds.push(i)
                }
            }
            var sound;
            if(sounds.length===0){
                const randomIndex = Math.floor(Math.random() * soundArray.length);
                sound= soundArray[randomIndex];
            } else {
                const randomIndex = Math.floor(Math.random() * sounds.length);
                sound = soundArray[sounds[randomIndex]];
            }
            sound.volume=Math.random()*0.2+0.8;
            sound.play();

            // Устанавливаем новый случайный интервал при каждом срабатывании
            interval = getRandomInterval();
        }
    }
}
