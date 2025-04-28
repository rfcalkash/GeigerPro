import QtQuick 2.15

QtObject {
    // Russian articles
    readonly property string radiationArticleRu: Text.MarkdownText {
        text: "# Радиация и её влияние

Радиация, или ионизирующее излучение, представляет собой форму энергии, которая распространяется в виде невидимых лучей или частиц, исходящих из различных источников, как природных, так и созданных человеком. Её особенность заключается в способности проникать глубоко и даже проходить сквозь твёрдые предметы.

## Основные характеристики
- Безопасная годовая доза: до 1 мЗв
- Максимальная годовая доза: 5 мЗв
- Средний природный фон: 2,4 мЗв/год

## Защита от радиации
1. **Укрытие и изоляция**
   - Использование подвалов и внутренних помещений
   - Герметизация помещений
   - Регулярная влажная уборка

2. **Защита органов дыхания**
   - Использование респираторов
   - Ватно-марлевые повязки
   - Подручные средства защиты

3. **Защита кожи и одежды**
   - Максимально закрытая одежда
   - Регулярная смена одежды
   - Использование защитных средств

4. **Правила безопасности**
   - Употребление герметично упакованных продуктов
   - Использование бутилированной воды
   - Следование инструкциям спасательных служб"
    }

    readonly property string geigerArticleRu: Text.MarkdownText {
        text: "# Счетчик Гейгера: принцип работы

## Как работает счетчик Гейгера?
Счетчик Гейгера – это прибор, способный обнаруживать невидимую радиацию. В его основе лежит герметичная трубка, наполненная специальным газом (аргоном или неоном).

### Основные компоненты:
- Анод (положительный заряд)
- Катод (отрицательный заряд)
- Источник высокого напряжения

### Принцип действия:
1. Радиация попадает в трубку
2. Происходит ионизация газа
3. Образуется электрический импульс
4. Прибор регистрирует излучение"
    }

    // English articles
    readonly property string radiationArticleEn: Text.MarkdownText {
        text: "# Radiation and Its Effects

Radiation, or ionizing radiation, is a form of energy that spreads in the form of invisible rays or particles emanating from various sources, both natural and man-made. Its distinctive feature is the ability to penetrate deeply and even pass through solid objects.

## Key Characteristics
- Safe annual dose: up to 1 mSv
- Maximum annual dose: 5 mSv
- Average natural background: 2.4 mSv/year

## Protection from Radiation
1. **Shelter and Isolation**
   - Use of basements and interior rooms
   - Room sealing
   - Regular wet cleaning

2. **Respiratory Protection**
   - Use of respirators
   - Gauze masks
   - Improvised protection means

3. **Skin and Clothing Protection**
   - Maximally covered clothing
   - Regular clothing changes
   - Use of protective equipment

4. **Safety Rules**
   - Consumption of hermetically packaged products
   - Use of bottled water
   - Following rescue service instructions"
    }

    readonly property string geigerArticleEn: Text.MarkdownText {
        text: "# Geiger Counter: How It Works

## How does a Geiger Counter work?
A Geiger counter is a device capable of detecting invisible radiation. At its core is a sealed tube filled with a special gas (argon or neon).

### Main Components:
- Anode (positive charge)
- Cathode (negative charge)
- High voltage source

### Operating Principle:
1. Radiation enters the tube
2. Gas ionization occurs
3. An electrical impulse is generated
4. The device registers the radiation"
    }

    // German articles
    readonly property string radiationArticleDe: Text.MarkdownText {
        text: "# Strahlung und ihre Auswirkungen

Strahlung oder ionisierende Strahlung ist eine Form von Energie, die sich in Form unsichtbarer Strahlen oder Teilchen aus verschiedenen Quellen ausbreitet, sowohl natürlichen als auch vom Menschen geschaffenen. Ihre Besonderheit liegt in der Fähigkeit, tief einzudringen und sogar durch feste Gegenstände zu gelangen.

## Hauptmerkmale
- Sichere Jahresdosis: bis zu 1 mSv
- Maximale Jahresdosis: 5 mSv
- Durchschnittlicher natürlicher Hintergrund: 2,4 mSv/Jahr

## Strahlenschutz
1. **Unterkunft und Isolierung**
   - Nutzung von Kellern und Innenräumen
   - Raumabdichtung
   - Regelmäßige Nassreinigung

2. **Atemschutz**
   - Verwendung von Atemschutzmasken
   - Mullbinden
   - Improvisierte Schutzmittel

3. **Haut- und Kleidungsschutz**
   - Maximale Körperbedeckung
   - Regelmäßiger Kleidungswechsel
   - Verwendung von Schutzausrüstung

4. **Sicherheitsregeln**
   - Verzehr hermetisch verpackter Produkte
   - Verwendung von Flaschenwasser
   - Befolgung der Anweisungen der Rettungsdienste"
    }

    readonly property string geigerArticleDe: Text.MarkdownText {
        text: "# Geigerzähler: Funktionsweise

## Wie funktioniert ein Geigerzähler?
Ein Geigerzähler ist ein Gerät, das unsichtbare Strahlung nachweisen kann. Im Kern befindet sich eine versiegelte Röhre, die mit einem speziellen Gas (Argon oder Neon) gefüllt ist.

### Hauptkomponenten:
- Anode (positive Ladung)
- Kathode (negative Ladung)
- Hochspannungsquelle

### Funktionsprinzip:
1. Strahlung tritt in die Röhre ein
2. Gasionisation erfolgt
3. Ein elektrischer Impuls wird erzeugt
4. Das Gerät registriert die Strahlung"
    }

    // French articles
    readonly property string radiationArticleFr: Text.MarkdownText {
        text: "# Rayonnement et ses effets

Le rayonnement, ou rayonnement ionisant, est une forme d'énergie qui se propage sous forme de rayons ou de particules invisibles provenant de diverses sources, naturelles et artificielles. Sa particularité réside dans sa capacité à pénétrer profondément et même à traverser les objets solides.

## Caractéristiques principales
- Dose annuelle sûre : jusqu'à 1 mSv
- Dose annuelle maximale : 5 mSv
- Fond naturel moyen : 2,4 mSv/an

## Protection contre les rayonnements
1. **Abri et isolement**
   - Utilisation des sous-sols et pièces intérieures
   - Étanchéité des locaux
   - Nettoyage humide régulier

2. **Protection respiratoire**
   - Utilisation de respirateurs
   - Masques de gaze
   - Moyens de protection improvisés

3. **Protection de la peau et des vêtements**
   - Vêtements couvrants au maximum
   - Changement régulier des vêtements
   - Utilisation d'équipements de protection

4. **Règles de sécurité**
   - Consommation de produits hermétiquement emballés
   - Utilisation d'eau en bouteille
   - Suivi des instructions des services de secours"
    }

    readonly property string geigerArticleFr: Text.MarkdownText {
        text: "# Compteur Geiger : fonctionnement

## Comment fonctionne un compteur Geiger ?
Un compteur Geiger est un appareil capable de détecter les rayonnements invisibles. À sa base se trouve un tube scellé rempli d'un gaz spécial (argon ou néon).

### Composants principaux :
- Anode (charge positive)
- Cathode (charge négative)
- Source de haute tension

### Principe de fonctionnement :
1. Le rayonnement pénètre dans le tube
2. Ionisation du gaz
3. Génération d'une impulsion électrique
4. L'appareil enregistre le rayonnement"
    }

    // Ukrainian articles
    readonly property string radiationArticleUk: Text.MarkdownText {
        text: "# Радіація та її вплив

Радіація, або іонізуюче випромінювання, є формою енергії, яка поширюється у вигляді невидимих променів або частинок, що виходять з різних джерел, як природних, так і створених людиною. Її особливість полягає в здатності проникати глибоко і навіть проходити крізь тверді предмети.

## Основні характеристики
- Безпечна річна доза: до 1 мЗв
- Максимальна річна доза: 5 мЗв
- Середній природний фон: 2,4 мЗв/рік

## Захист від радіації
1. **Сховище та ізоляція**
   - Використання підвалів та внутрішніх приміщень
   - Герметизація приміщень
   - Регулярне вологе прибирання

2. **Захист органів дихання**
   - Використання респіраторів
   - Ватно-марлеві пов'язки
   - Підручні засоби захисту

3. **Захист шкіри та одягу**
   - Максимально закритий одяг
   - Регулярна зміна одягу
   - Використання засобів захисту

4. **Правила безпеки**
   - Вживання герметично упакованих продуктів
   - Використання бутильованої вода
   - Дотримання інструкцій рятувальних служб"
    }

    readonly property string geigerArticleUk: Text.MarkdownText {
        text: "# Лічильник Гейгера: принцип роботи

## Як працює лічильник Гейгера?
Лічильник Гейгера – це прилад, здатний виявляти невидиме випромінювання. В його основі лежить герметична трубка, наповнена спеціальним газом (аргоном або неоном).

### Основні компоненти:
- Анод (позитивний заряд)
- Катод (негативний заряд)
- Джерело високої напруги

### Принцип дії:
1. Випромінювання потрапляє в трубку
2. Відбувається іонізація газу
3. Утворюється електричний імпульс
4. Прилад реєструє випромінювання"
    }

    // Simplified Chinese articles
    readonly property string radiationArticleZh: Text.MarkdownText {
        text: "# 辐射及其影响

辐射或电离辐射是一种以看不见的射线或粒子形式传播的能量，来自自然和人工的各种来源。其特点在于能够深入穿透甚至穿过固体物体。

## 主要特征
- 安全年剂量：高达1 mSv
- 最大年剂量：5 mSv
- 平均自然本底：2.4 mSv/年

## 辐射防护
1. **掩蔽和隔离**
   - 使用地下室和内部房间
   - 房间密封
   - 定期湿式清洁

2. **呼吸防护**
   - 使用呼吸器
   - 纱布口罩
   - 临时防护措施

3. **皮肤和衣物防护**
   - 最大程度覆盖身体的衣物
   - 定期更换衣物
   - 使用防护设备

4. **安全规则**
   - 食用密封包装食品
   - 使用瓶装水
   - 遵循救援服务指示"
    }

    readonly property string geigerArticleZh: Text.MarkdownText {
        text: "# 盖革计数器：工作原理

## 盖革计数器如何工作？
盖革计数器是一种能够检测看不见的辐射的仪器。其核心是一个充满特殊气体（氩气或氖气）的密封管。

### 主要组件：
- 阳极（正电荷）
- 阴极（负电荷）
- 高压电源

### 工作原理：
1. 辐射进入管子
2. 气体发生电离
3. 产生电脉冲
4. 仪器记录辐射"
    }

    // Japanese articles
    readonly property string radiationArticleJa: Text.MarkdownText {
        text: "# 放射線とその影響

放射線、または電離放射線は、自然および人工的な様々な源から発せられる目に見えない放射線や粒子の形で広がるエネルギーの形態です。その特徴は、固体物を貫通し、深く浸透する能力にあります。

## 主な特徴
- 安全な年間線量：1 mSvまで
- 最大年間線量：5 mSv
- 平均自然放射線量：2.4 mSv/年

## 放射線防護
1. **避難と隔離**
   - 地下室や内部部屋の使用
   - 部屋の気密性確保
   - 定期的な湿式清掃

2. **呼吸器防護**
   - 防塵マスクの使用
   - ガーゼマスク
   - 簡易防護具

3. **皮膚と衣服の防護**
   - 最大限に体を覆う衣服
   - 定期的な衣服の交換
   - 防護具の使用

4. **安全規則**
   - 密封包装された食品の摂取
   - ボトル入り水の使用
   - 救助サービスの指示に従う"
    }

    readonly property string geigerArticleJa: Text.MarkdownText {
        text: "# ガイガーカウンター：動作原理

## ガイガーカウンターはどのように動作するか？
ガイガーカウンターは、目に見えない放射線を検出できる装置です。その中心には、特殊なガス（アルゴンまたはネオン）が充填された密封管があります。

### 主要コンポーネント：
- 陽極（正電荷）
- 陰極（負電荷）
- 高電圧源

### 動作原理：
1. 放射線が管内に入る
2. ガスの電離が発生
3. 電気パルスが生成される
4. 装置が放射線を記録"
    }
} 