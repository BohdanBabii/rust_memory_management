.. _ch:Einfuehrung_in_das_speichermodell:

Einführung in das Speichermodell
================================

.. _ch:Einfuehrung_Einfuehrung_in_das_speichermodell:

Einführung
----------


.. _ch:Voraussetzungen:

Voraussetzungen
---------------


.. _ch:rust_und_der_speicher:

Rust und der Speicher
---------------------


.. _ch:modell_fuer_skalare_datentypen:

Model für skalare Datentypen
----------------------------

.. code-block:: rust
    :linenos:

    fn main() {
        let mut variable1 = 3;
        let variable2 = variable1;
        variable1 = 4;
        println!("{}, {}", variable1, variable2);
    }

Wechsel von Gültigkeitsbereichen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

Aufruf von Funktionen
^^^^^^^^^^^^^^^^^^^^^

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

.. _ch:das_allgemeine_modell:

Das allgemeine Modell
---------------------

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

Wechsel von Gültigkeitsbereichen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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


Aufruf von Funktionen
^^^^^^^^^^^^^^^^^^^^^

.. code-block:: rust
    :linenos:
    :emphasize-lines: 13,16

    struct CloneMe {
        x: i32,
    }

    fn create_struct () -> CloneMe {
        CloneMe { x: 3 }
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

.. _ch:referenzen_in_rust:

Referenzen in Rust
------------------

Lesereferenzen auf nicht veränderbaren Variablen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
        ausgabe_clone_me(&val3);
        ausgabe_clone_me(ref2);
        println!("{}", val.x);
    }

Lesereferenzen auf veränderbaren Variablen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

Veränderbaren Referenzen
^^^^^^^^^^^^^^^^^^^^^^^^

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

.. _ch:verwendung_von_variablen_und_referenzen:

Verwendung von Variablen und Referenzen
---------------------------------------

.. _ch:vor_und_nachteile_des_modells:

Vor- und Nachteile des Modells
------------------------------

