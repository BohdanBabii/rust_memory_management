.. _ch:Generische_Datentypen:

Generische Datentypen
=====================

.. _ch:Einfuehrung_generische_Datentypen:

Einführung
----------

* Generische Datentypen abstrahieren von zugrundeliegenden Datentypen und ermöglichen die Formulierung von verarbeitenden Algorithmen unabhängig vom konkreten Datentyp.

|
|
|

**Warum Generische Typen?**

* **Bekannte Konzepte:** 
    
    Generische Datentypen sind bereits aus anderen Programmiersprachen bekannt und dienen als elegantes Mittel zur Verallgemeinerung von Datenstrukturen und zugehörigen Implementierungen.

* **Typparameter:** 
    
    Ein Typparameter repräsentiert einen beliebigen Datentyp (oder Datentypen), über den erst später im Code entschieden wird.

|
|
|

**Unterschiede zu anderen Sprachen:**

* **Type Erasure in anderen Sprachen:** 
    
    Viele Programmiersprachen verwenden Type Erasure, bei dem Teile der Typinformation zur Laufzeit verloren gehen. Rust geht hierbei einen entgegengesetzten Weg.

* **Rust's Ansatz:** 
    
    Rust erzeugt für generische Funktionen spezifische Funktionen für jeden verwendeten Datentyp. Dies führt zu einem geringfügig größeren ausführbaren Programm, ermöglicht jedoch eine extrem effiziente Typprüfung und -verarbeitung zur Laufzeit.

|
|
|

.. _ch:Typparameter_in_Datenstrukturen:

**Typparameter in Rust:**

* **Verwendung in der Signatur:** 
    
    Typparameter werden in der Signatur von strukturierten Datentypen und von Funktionen angegeben.

* **Notation:** 
    
    Die Notation von Typparametern ähnelt der in Java. 
    
    .. code-block:: rust
        
        <T>
        <T, U, ...>

|
|
|

**Turbofish-Operator**

* In den meisten Fällen können Typparameter direkt auf den Namen folgen.
* **Problem:** 
    
    Selten kann der Compiler das einleitende Kleinerzeichen nicht korrekt interpretieren.

* Einführung des Turbofish-Operators zur Unterstützung des Compilers.

**Turbofish - Fehlerbehebung**

* Bei Schwierigkeiten meldet der Compiler einen Fehler.

|
|
|

* **Lösung:** 
    
    Platzierung eines Pfadtrenners (::) zwischen Name und Typ.

* Erläuterung der Typhierarchie.

* Unterstützt den Compiler bei der korrekten Interpretation von Werten zwischen den Größer- und Kleinerzeichen.

**Gültigkeitsbereich der Typparameter**

* Typparameter sind lokal auf den Gültigkeitsbereich des Datentyps oder der Funktion beschränkt.
* Wiederverwendung des gleichen Namens in aufeinanderfolgenden Definitionen hat keinen semantischen Zusammenhang zwischen den Typparametern.

|
|
|

Typparameter in Datenstrukturen
-------------------------------

.. code-block:: rust
    :linenos:

    struct Point<T> {
        x: T,
        y: T
    }

**Erinnerung Beispiel S53:** 
    
    Unsere erste Datenstruktur, die zweidimensionale Koordinaten speichert, verwendet bisher fest definierte Datentypen für X- und Y-Koordinaten (Typ i32). Dies begrenzt jedoch unsere Implementierungsmöglichkeiten.

* **Lösung:** 
    
    Wir können dies verbessern, indem wir einen Typparameter zur Verallgemeinerung verwenden. Dies erlaubt uns, die gleiche Datenstruktur flexibel für verschiedene Datentypen zu nutzen.

|
|
|

**Beispiel: Typparameter in Datenstruktur**

.. code-block:: rust
    :linenos:
    :emphasize-lines: 7

    fn main() {
        struct Point<T> {
            x: T,
            y: T
        }

        //let origin = Point { x: 0, y: 0.0 }; // Fehler
        let origin = Point(x: 0, y: 0);
        let tfish: Point::<i32> = Point { x: 0, y:0 };
        let fp_point = Point { x: 3.141_f32, y: 2.718 };
        println!("{}, {}", origin.x, fp_point.y);
    }

* **Datenstruktur Point<T>:**
    
    Wir definieren eine Datenstruktur Point<T> mit einem Typparameter T. Innerhalb der Struktur verwenden wir diesen generischen Typ für alle Elemente, deren Datentyp wir generisch gestalten wollen.

* **Instanziierung mit Typparameter:** 

    Der Compiler leitet den konkreten Typ für den Typparameter T aus den übergebenen Parametern ab. Fehlermeldungen treten auf, wenn die übergebenen Parameter unterschiedliche konkrete Typen für denselben Typparameter haben.

* **Turbofish-Operator:** 
    
    In der Variable tfish zeigen wir die Verwendung des Turbofish-Operators ::<i32>, um explizit den konkreten Typ anzugeben. Dies ist zwar in diesem Fall überflüssig, aber syntaktisch korrekt.

* **Explizite Typangabe:** 
    
    Bei der Definition der Variable fp_point mit einem Typparameter f32 wird der Typparameter durch die explizite Angabe des Typs ausgewählt.

|
|
|

.. _ch:Typparameter_in_Funktionen:

Typparameter in Funktionen
--------------------------

* **Notation für Typparameter in Funktionen:** 
    
    Wie bei Datenstrukturen verwenden wir die bekannte Notation, um Typparameter in Funktionen zu kennzeichnen.

* **Flexibilität durch Typparameter:**
    
    Typparameter in Funktionen ermöglichen uns, generische Funktionen zu erstellen, die mit verschiedenen Datentypen arbeiten können.

|
|
|

**Rust's Funktionsweise mit Typparametern:**

* **Auswahl der Implementierung:** 
    
    Rust wählt zur Laufzeit die korrekte Implementierung einer Funktion basierend nicht nur auf den Parametern, sondern auch auf dem Rückgabetyp. 
    Es werden spezifische Funktionen für jeden auftretenden konkreten Datentyp generiert.

* **Rückgabetyppolymorphismus:**

    Der erwartete Rückgabetyp im Quelltext beeinflusst die Auswahl der spezifischen Funktionsausprägung.

|
|
|

**Beispiel: Typparameter in Funktionen**

.. code-block:: rust

    struct Point<T> {
        x: T,
        y: T
    }

    fn create_point<T>(x: T, y: T) -> Point<T> {
        Point { x, y }
    }

    fn main() {
        let origin = create_point(0, 0);
        let fp_point = create_point(3.141, 2.718);
        println!("{}, {}", origin.x, fp_point.y);
    }

* **Funktionsdefinition:** 
    
    Die Funktion create_point<T>() erstellt eine Instanz von Point<T> mit dem konkreten Typ der übergebenen Argumente und gibt diese zurück.

* **Typparameter in Aktion:** 

    Der Typparameter T wird in der Parameterliste, im Rückgabewert und im Anweisungsblock der Funktion verwendet.

* **Turbofish-Notation:** 
    
    Die Turbofish-Notation (z.B., Point::<T>) kann optional verwendet werden, ist aber in Rust nicht notwendig, solange der Compiler den Quelltext korrekt interpretieren kann.

.. _ch:Typparameter_in_Aufzaehlungstypen:

|
|
|

Typparameter in Aufzählungstypen
--------------------------------

* **Flexibilität durch Typparameter:** 
    
    Aufzählungstypen in Rust profitieren von Typparametern, was ihnen eine enorme Flexibilität und Eleganz verleiht.

* **Zentrale Verwendung in Rust:** 
    
    Rust nutzt diese Kombination an vielen zentralen Stellen, wie z.B. beim Aufzählungstyp Option (für das Ausschließen von Null-Pointern als Rückgabewerte) oder beim Aufzählungstyp Result (zum flexiblen Rückgeben von Ergebnissen oder Fehlern aus Funktionen).

|
|
|

**Beispiel: Typparameter in Aufzählungstypen**

.. code-block:: rust
    :linenos:
    :emphasize-lines: 31

    use std::process::exit;

    enum MyOption<T> {
        None,
        Some(T)
    }

    fn is_none<T>(opt: &MyOption<T>) -> bool {
        if let MyOption::<T>::None = opt {
            return true;
        } else {
            return false;
        }
    }

    fn expect <T>(opt: MyOption<T>) -> T {
        match opt {
            MyOption:: None => {
                    println!("Wir haben ein Problem...");
                    exit(1);
            }
            MyOption::Some( x ) => x
        }
    }

    fn main() {
        let opt = MyOption::Some(3.141);
        let val = expect(opt);
        println!("{}", val);

        //let opt = MyOption::None;         // Fehler
        let opt = MyOption::<i32>::None;
        if is_none(&opt) {
            println!("Enthält keinen Wert");
        }
        let val = expect(opt);
    }

**Funktionsweise der Funktionen:**

* **is_none<T> Funktion:** 
    
    Diese Funktion gibt true zurück, wenn eine übergebene MyOption<T> den Wert None enthält. Der Typparameter T wird in der Parameterliste verwendet.

* **expect<T> Funktion:** 

    Diese Funktion konsumiert eine Instanz von MyOption<T> und gibt die enthaltene Instanz zurück. Im Fehlerfall, wenn MyOption::None erhalten wird, wird eine Fehlermeldung ausgegeben und das Programm beendet.

**Verwendung in der main()-Funktion:**

* **Instanziierung von MyOption:** 

    In der main()-Funktion erstellen wir eine Variable opt mit einer Instanz von MyOption::Some(3.141).

* **Aufruf der Funktion expect:** 
    
    Wir verwenden die Funktion expect, um den Wert aus MyOption zu extrahieren und weisen diesen der Variable val zu.

* **Weitere Verwendung von MyOption::None:** 
    
    Wir definieren eine Variable opt mit einer Instanz von MyOption::<i32>::None. Die Funktionen is_none und expect werden auf diese Instanz angewendet.

* **Ausgaben des Programms:** 

    Die Ausgaben des Programms sind "3.141", "Enthält keinen Wert" und "Wir haben ein Problem..." je nach Verwendung von MyOption::Some und MyOption::None.