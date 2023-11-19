.. _ch:Einfuehrung_in_das_speichermodell:

Einführung in das Speichermodell
================================

.. _ch:Einfuehrung_Einfuehrung_in_das_speichermodell:

Einführung
----------

* **Einfluss auf Verwendung der Sprache:** 
    
    Das Speichermodell von Rust beeinflusst die Sprachnutzung maßgeblich – Sicherheit im Speichermanagement und Geschwindigkeit werden harmonisch kombiniert.

* **Vorbestimmte Nutzungszeit:**

    Die Nutzung des Speichers kann im Normalfall bereits zur Übersetzungszeit vorbestimmt werden, was zu einer effizienten Ausführung führt.

|
|
|

* **Gültigkeitsbereich für Variablen** 

* **Freigabe von lokalen Variablen** 

* **Begriff des Eigentums (Ownership)** 

* **Compiler-basierte Bestimmung der Gültigkeit**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

|
|
|

.. _ch:Grundlagen:

Grundlagen
----------

* **Verschiedene Speicherabstraktionen:** 

    Der Hauptspeicher kann durch verschiedene Abstraktionen verwaltet werden, wobei Stack und Heap grundlegende Konzepte darstellen.

* **Balance zwischen Geschwindigkeit und Platzbedarf:** 

    Die Wahl zwischen Stack und Heap beeinflusst die Geschwindigkeit und den Platzbedarf unserer Programme.

|
|
|

Heap
^^^^

* Kontinuierlicher Hauptspeicher 
* Erlaubt Daten an Speicheradressen abzulegen, zu modifizieren und später wieder zu lesen

|
|
|

Stack
^^^^^

* **Ursprung des Stack:** 

    Die Abstraktion des Stapels stammt aus der Notwendigkeit, Unterprogrammaufrufe effizient zu gestalten.

* **Funktionsweise des Stacks:** 

    Lokale Variablen werden auf einem Stapel abgelegt. Die Implementierung erfolgt oft über den Stackpointer, ein spezielles Prozessorregister.

|
|
|

* **Beim Betreten eines Gültigkeitsbereichs:** 

    Beim Betreten eines neuen Gültigkeitsbereichs, z.B. einer Funktion, wird die Rückkehradresse auf den Stack gelegt, und Platz für lokale Variablen wird geschaffen.

* **Beim Verlassen des Gültigkeitsbereichs:** 

    Beim Verlassen wird der belegte Stack-Bereich durch Anpassen des Stackpointers freigegeben, und die Rückkehradresse wird für den Rücksprung verwendet.

|
|
|

Speicherverwaltung 
^^^^^^^^^^^^^^^^^^

* **Funktion:** 
    
    Freigabe von Speicher um Mehrfachbelegung und Fragmentierung zu verhindern.

* **Implementierung in anderen Sprechen:**

    Garbage Collector, der automatisch nicht mehr erreichbare Objekte freigibt und den Speicher defragmentiert.

|
|
|

Unterschiede Stack & Heap
^^^^^^^^^^^^^^^^^^^^^^^^^

**Stack:**

        * Sehr schnelle Belegung und Freigabe
        * Potenziell begrenzter Platz
        * Beschränkt auf Instanzen, deren Größe zur Übersetzungszeit bekannt ist

**Heap:**

        * Höherer Aufwand in Belegung und Freigabe
        * Potenziell größerer Platz
        * Keine Einschränkungen bezüglich der Größe der Instanzen zur Übersetzungszeit

|
|
|

.. _ch:rust_und_der_speicher:

Rust und der Speicher
---------------------

* **Ziel von Rust:** 
    
    Rust strebt an, Speicherzugriffe performant zu gestalten, ohne Kompromisse bei der Verhinderung von Speicherlecks einzugehen.

* **Vergleich mit anderen Sprachen:** 

    Ähnlich wie C, C++ und Java setzt Rust auf verschiedene Modelle für den Umgang mit Variablen.

|
|
|

Zwei grundlegende Modelle in Rust
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. **Instanzen auf dem Stack:**

    * Skalare Datentypen, Felder, Aufzählungstypen, Tupel und strukturierte Datentypen aus skalaren Datentypen.
    * Größe zur Übersetzungszeit bekannt.
    * Direkte Anlage auf dem Stack für geringen Aufwand bei Erzeugung und Freigabe.

#. **Instanzen auf dem Heap:**
    
    * Komplexere Datentypen oder solche mit unbekannter Größe zur Übersetzungszeit.
    * Anlage auf dem Heap mit höherem Aufwand für Erzeugung und Freigabe.
    * Verwaltungsinformationen auf dem Stack.

|
|
|

.. admonition:: Einschränkungen und Unterschiede:

    * Tupel mit mehr als 12 Elementen: 
        
        In der aktuellen Rust-Version werden Tupel mit mehr als 12 Elementen aufgrund von Typsystemeinschränkungen im Hauptspeicher abgelegt.

    * Metainformation auf dem Heap:
        
        Zusätzliche Metainformationen werden auf dem Heap für die Verwaltung der Variable angelegt.

|
|
|

Copy-Semantik vs. Clone-Semantik
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Copy-Semantik:**

    Instanzen auf dem Stack.
    Geringer Aufwand für Erstellung und Freigabe.
    Trait: Copy

        * Besitzt keine Funktionalität.
        * Markiert strukturierte Datentypen.

**Clone-Semantik:**

    Instanzen auf dem Heap.
    Höherer Aufwand, insbesondere bei Verschachtelungen (deep copy oder cloning).
    Trait: Clone

        * Implementiert die Kopierfunktion.
        * Notwendig für Datentypen, die die Clone-Semantik erfordern.

|
|
|

.. _ch:modell_fuer_skalare_datentypen:

Modell für skalare Datentypen
-----------------------------

**Beispiel: Skalare Datentypen**

.. code-block:: rust
    :linenos:

    fn main() {
        let mut variable1 = 3;
        let variable2 = variable1;
        variable1 = 4;
        println!("{}, {}", variable1, variable2);
    }

* **Copy-Semantik**

* **Variable zuweisen:**
    
    Bei Zuweisung wird eine Kopie des Werts erstellt (Copy-Semantik).
    Unabhängige Gültigkeit der Variablen im Anweisungsblock.

* **Ausgabe:**

    4, 3

|
|
|

Wechsel von Gültigkeitsbereichen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* **Allgemein:**
    
    Neue Variablen existieren innerhalb ihres Gültigkeitsbereichs.
    Beim Verlassen des Bereichs werden sie freigegeben.

* **Kopieren von Variablen:**
    
    Zuweisung einer Variablen an eine andere bewirkt das Kopieren.

|
|
|

**Beispiel: Wechsel von Gültigkeitsbereichen**

.. code-block:: rust
    :linenos:

    fn main() {
        let mut variable1 = 1;
        let variable2 = 2;
        {
            let x = variable1;
            let mut y = variable2;
            y = 4;
            println!("{}, {}, {}, {}", variable1, variable2, x, y);
        }
        println!("{}, {}", variable1, variable2);
    }

|
|
|

Aufruf von Funktionen
^^^^^^^^^^^^^^^^^^^^^

* **Allgemein:**

    Funktionen erhalten Argumente als lokale Variablen auf dem Stack.
    Änderungen bleiben auf den Funktionskontext beschränkt.

|
|
|

**Beispiel: Aufruf von Funktionen**

.. code-block:: rust
    :linenos:

    fn main() {
        let mut variable1 = 1;
        let variable2 = 2;
        let (a, b) = return_tupel(variable1, variable2);
        println!("{}, {}, {}, {}", variable1, variable2, x, y);
    }

    fn return_tupel (v1: i32, mut v2: i32) -> (i32, i32) {
        let x = v1;
        v2 = 4;
        (x, v2)
    }

* **Copy-Semantik**
* **Ergebnis:**

    Ausgabe: 1, 2, 1, 4

* **Begründung:** 
    
    Änderungen an v1 und v2 innerhalb der Funktion beeinflussen nur den Funktionskontext.

|
|
|

.. _ch:das_allgemeine_modell:

Das allgemeine Modell
---------------------

Eigentum (Ownership)
^^^^^^^^^^^^^^^^^^^^

* **Regeln:**
        
    #. Jede Heap-Instanz hat genau einen Eigentümer.
    #. Instanzfreigabe erfolgt beim Verlassen des Eigentümer-Gültigkeitsbereichs.

* **Compiler-Überwachung:**
    
    * Diese Regeln werden vom Compiler überwacht und durchgesetzt.
    * Keine Laufzeit-Garbage Collection notwendig.

|
|
|

**Beispiel: Ownership**

.. code-block:: rust
    :linenos:
    :emphasize-lines: 6

    fn main() {
        let variable1 = Box::new(42);

        let variable2 = variable1; // Eigentumsübergang

        //println!("{}", variable1); // Fehler

        print!("{}, ", variable2);

        let variable3 = variable2; // Eigentumsübergang

        println!("{}", variable3);
    }

Ausgabe:

.. code-block:: rust
    
    42, 42

|
|
|

Wechsel von Gültigkeitsbereichen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* **Eigentumsübergang (Move):**
    
    Bei Datentypen mit Clone-Semantik kann das Verlassen eines Gültigkeitsbereichs zu unbeabsichtigten Eigentumsübergängen auf dem Heap führen.
    Regel 2 (Freigabe bei ungültigem Eigentümer) kann bewusst oder unbeabsichtigt angewendet werden.

|
|
|

**Beispiel: Wechsel von Gültigkeitsbereichen**

.. code-block:: rust
    :linenos:
    :emphasize-lines: 11

    fn main() {
        let variable1 = Box::new(42);
        let mut variable2 = Box::new(21);

        {
            let variable3 = variable1; // Eigentumsübergang
            let mut variable4 = variable2; // Eigentumsübergang
            variable2 = variable4; // Eigentumsübergang
        }

        //println!("{}", variable1); // Fehler
        println("{}", variable2);
    }

|
|
|

Aufruf von Funktionen
^^^^^^^^^^^^^^^^^^^^^

* **Eigentumsübergänge bei Funktionen:**
    
    * Funktionsaufruf: Übertragung von Eigentum an Funktionsparameter.
    * Rückkehr aus Funktion: Übertragung des Eigentums am Rückgabewert an den Aufrufkontext.

* **Bewusste Handhabung des Eigentums:**

    * Vermeidung unbeabsichtigter Zugriffe durch klare Eigentumszuweisungen.

|
|
|

**Beispiel: Aufruf von Funktionen**

.. code-block:: rust
    :linenos:
    :emphasize-lines: 17,20

    struct CloneMe {
        x: i32,
    }

    fn create_struct () -> CloneMe {
        CloneMe { x: 3 }
    }

    fn return_struct(input: cloneMe) -> cloneMe {
        input
    }

    fn main() {
        let val = create_struct();
        println!("{}", val.x);
        let val2 = return_struct(val);
        // println!("{}", val.x); // Fehler
        println!("{}", val2.x);
        return_struct(val2);
        //println!("{}", val2.x); // Fehler
    }

|
|
|

.. _ch:referenzen_in_rust:

Referenzen in Rust
------------------

* **Sicherer Zugriff:** 
    
    Ermöglicht Zugriff auf den Inhalt einer Variable ohne Eigentumsübertragung.

* **Syntax:** 

    Verwendung von & für die Erstellung von Referenzen und * für die Dereferenzierung.

|
|
|

Lesereferenzen auf nicht veränderbaren Variablen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Keine Veränderungen erlaubt:** 
    
    Für unveränderliche Variablen sind beliebig viele Lesereferenzen möglich.

**Copy-Semantik:** 
    
    Lesereferenzen folgen der Copy-Semantik, was die Nutzung in Funktionen vereinfacht.

**Effizienz:** 
    
    Der Compiler kann Optimierungen vornehmen, z. B. Caching von Werten in Prozessorregistern.

|
|
|

**Beispiel: Lesereferenzen auf nicht veränderbaren Variablen**

.. code-block:: rust
    :linenos:

    struct CloneMe {
        x: i32,
    }

    fn ausgabe_clone_me(reference: &CloneMe) {
        println!("{}", reference.x);
    }

    fn main() {
        let val = CloneMe { x: 1, };
        let ref1 = &val;
        let ref2 = ref1;
        ausgabe_clone_me(ref1);
        ausgabe_clone_me(&val);
        ausgabe_clone_me(ref2);
        println!("{}", val.x);
    }

|
|
|

Lesereferenzen auf veränderbaren Variablen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* **Schreibzugriff auf veränderbare Variable:** 
    
    Rust verbietet schreibenden Zugriff, wenn Lesereferenzen aktiv sind.

* **Fehlermeldung:** 
    
    Compiler verhindert potenziell ungültige Zugriffe und gewährleistet Konsistenz von Lesereferenzen.

|
|
|

**Beispiel: Lesereferenzen auf veränderbaren Variablen**

.. code-block:: rust
    :linenos:
    :emphasize-lines: 13,15,18

    struct CloneMe {
        x: i32,
    }

    fn ausgabe_clone_me(reference: &CloneMe) {
        println!("{}", reference.x);
    }

    fn main() {
        let val = CloneMe { x: 1, };
        val.x = 2;
        let ref1 = &val;
        // val.x = 3;               // Fehler in der nächsten Zeile
        ausgabe_clone_me(ref1);
        // val.x = 3;               // Fehler in der nächsten Zeile
        let ref2 = ref1;
        ausgabe_clone_me(&val);
        // val.x = 3;               // Fehler in der nächsten Zeile
        ausgabe_clone_me(ref2);
        val.x = 3;
    }

|
|
|

Effektive Nutzung von Lesereferenzen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    
* **Definiere vor Modifikation:** 

    Lesereferenzen vor jeglicher Modifikation einer Variable definieren.

* **Achte auf Gültigkeitsbereiche:** 
    
    Zugriff auf Lesereferenzen nur innerhalb ihres Gültigkeitsbereichs.

|
|
|

Veränderbaren Referenzen
^^^^^^^^^^^^^^^^^^^^^^^^

* **Definition:** 

    Veränderbare Referenzen mit &mut ermöglichen schreibenden Zugriff auf Variablen.

* **Einschränkungen:**

    * Nur eine aktive veränderbare Referenz gleichzeitig.
    * Kein paralleler Lesezugriff während aktiver veränderbarer Referenz.
    * Kein Zugriff über die Variable selbst während aktiver veränderbarer Referenz.

|
|
|

Effektive Nutzung von Move-Semantik
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Regel für schreibenden Zugriff:**

    * Maximal eine aktive Schreibreferenz: Kein paralleler Lesezugriff.
    * Kein Zugriff über Variable während aktiver Schreibreferenz.

|
|
|

**Beispiel: Effektive Nutzung von Reborrowing**

.. code-block:: rust
    :linenos:
    :emphasize-lines: 8,11,12

    struct CloneMe {
        x: i32,
    }

    fn main() {
        let val = CloneMe { x: 2, };
        let ref1 = &mut val;
        // val.x = 3;               // Fehler
        ref1.x = 4;
        let ref2 = ref1;            // Move-Semantik
        // ref1.x = 5;              // Fehler
        // val.x = 6;               // Fehler
        ref2.x = 7;
        val.x += 1;
    }

|
|
|

.. code-block:: rust
    :linenos:

    struct CloneMe {
        x: i32,
    }

    fn increment_clone_me(reference: &mut CloneMe) {
        reference.x += 1;
    }

    fn main() {
        let val = CloneMe { x: 1, };
        let ref1 = &mut val;
        increment_clone_me(ref1);               // Reborrow

        let ref2 = ref1;                        // Moved Referenzen

        let ref3: &mut cloneMe = ref2;          // Reborrow 1
        ref3.x = 2;                             // Reborrow 1

        let ref4: &mut _ = ref3;                // Reborrow 2
        ref4.x = 3;                             // Reborrow 2

        ref3.x = 4;                             // Reborrow 1

        ref2.x = 5;                             // Back to moved Referenzen

        increment_clone_me(ref2);               // Reborrow
        increment_clone_me(&mut val);           // Reborrow
    }

|
|
|

.. _ch:verwendung_von_variablen_und_referenzen:

Verwendung von Variablen und Referenzen
---------------------------------------

In Rust bevorzugen wir die Verwendung von Referenzen, soweit möglich, mit Ausnahmen für Definitionen.
Der Einsatz von Variablen erfolgt nur, wenn ein Eigentumsübergang notwendig ist.

**Unveränderliche Variablen vorziehen**

    * Die Nutzung von unveränderlichen Variablen steigert die Sicherheit und ermöglicht Optimierungen.
    * Betone die Verwendung von let für unveränderliche Bindungen.

|
|
|

**Effiziente Nutzung von Veränderbaren Variablen**

    * Kurze Lebensdauer für veränderbare Variablen anstreben.
    * Minimiere veränderbare Variablen, um die Lesbarkeit und Wartbarkeit des Codes zu verbessern.

|
|
|

**Lesereferenzen gegenüber Schreibreferenzen**

    * Priorisiere Lesereferenzen für verbesserte Parallelität und Nutzung der Copy-Semantik.
    * Schreibreferenzen sollten so kurz wie möglich verwendet werden.

|
|
|

**Funktionsparameter: Referenzen vs. Variablen**

    * Im Normalfall bevorzugen wir Referenzen als Funktionsparameter.
    * Die Verwendung von Variablen erfolgt nur, wenn ein expliziter Eigentumsübergang erforderlich ist.

|
|
|

**Rückgabewerte aus Funktionen**

    * Benutze Variablen für Rückgabewerte, wenn neue Werte innerhalb der Funktion erzeugt werden.
    * Verwende Referenzen nur, wenn Rückgabewerte auf Funktionargumente verweisen.

|
|
|

.. _ch:vor_und_nachteile_des_modells:

Vor- und Nachteile des Modells
------------------------------

.. list-table:: 
   :widths: 50 50
   :header-rows: 1

   * - **Vorteile**
     - **Nachteile**
   * - 
        .. line-block::
            **Garantien für Speicherverwendung:**
            Einzigartige Garantien für die Speicherverwendung,
            die über das hinausgehen, was andere Sprachen bieten.
     - 
        .. line-block::
            **Komplexität:**
            Das Speichermodell ist komplex und erfordert Umdenken 
            im Vergleich zu klassischen Sprachen.
   * - 
        .. line-block::
            **Übersetzungszeitprüfungen:**
            Prüfungen erfolgen zur Übersetzungszeit, was zu 
            sichererem und effizienterem Code führt.
     -
   * - 
        .. line-block::
            **Klare Programmiersemantik:**  
            Durch das Konzept der Referenzen und veränderbaren Referenzen
            (Reborrowing) wird eine klare Programmiersemantik ermöglicht.
     -
   * - 
        .. line-block::
            **Explizites Ownership-Modell:**
            Die explizite Verwendung des Ownership-Modells in APIs ermöglicht
            eine klare Kommunikation von Parametern und Rückgabewerten.
     -