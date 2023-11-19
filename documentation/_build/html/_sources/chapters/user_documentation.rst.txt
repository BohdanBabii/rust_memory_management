.. _User_Documentation:

Benutzerdokumentation
=====================

.. _ch:introduction:

Einleitung
----------

Willkommen bei dem Vortrag "Rust Speichermanagement" ! Diese Benutzerdokumentation führt Sie durch den Prozess des Herunterladens des Quellcodes des Projekts von GitHub und dessen Kompilierung, damit Sie mit der Software arbeiten können.

.. _ch:Getting_Started:

Erste Schritte
--------------

Voraussetzungen
^^^^^^^^^^^^^^^

Bevor Sie beginnen können, stellen Sie sicher, dass die folgenden Voraussetzungen auf Ihrem System installiert sind:

* Python3
* Rust
* C++ (Version 11 oder höher)
* CMake
* git

Herunterladen des Codes
^^^^^^^^^^^^^^^^^^^^^^^

#. Öffnen Sie Ihr Terminal oder die Eingabeaufforderung.

#. Wechseln Sie in das Verzeichnis, in dem Sie das Projekt speichern möchten.

#. Führen Sie den folgenden Befehl aus, um das Projekt-Repository von GitHub zu klonen:

    .. code-block:: bash
        
        git clone https://github.com/BohdanBabii/rust_memory_management.git

.. _ch:Compiling_the_Code:

Code kompilieren
----------------

Dokumentation kompilieren
^^^^^^^^^^^^^^^^^^^^^^^^^

#. Führen Sie den folgenden Befehl aus, um die Dokumentation zu generieren:

    .. code-block::

        cd documentation
        make html

#. Öffnen Sie die Dokumentation jetzt in Ihrem bevorzugten Browser, indem Sie die folgende URL öffnen:

    .. code-block::

        file:///Pfad/zum/rust_memory_management/documentation/_build/html/index.html


.. _ch:Troubleshooting:

Fehlerbehebung
--------------

Wenn Sie während der Arbeit mit "Rust Speichermanagement" auf Probleme stoßen, konsultieren Sie die folgenden häufigen Probleme und die Kontaktdaten für Unterstützung.

Häufige Probleme
^^^^^^^^^^^^^^^^

* Kompilierungsfehler:
    Wenn Sie auf Kompilierungsfehler stoßen, stellen Sie sicher, dass alle erforderlichen Voraussetzungen installiert sind, wie im Abschnitt "Voraussetzungen" erwähnt. Überprüfen Sie, ob Sie die richtigen Versionen von Python, C++ und CMake haben.

Kontaktinformationen
^^^^^^^^^^^^^^^^^^^^

Wenn Sie Ihr Problem nicht lösen können oder auf andere hier nicht erwähnte Schwierigkeiten stoßen, kontaktieren Sie bitte die Betreuer von Parallel Computing 1 für Unterstützung. Sie können uns unter den folgenden E-Mail-Adressen erreichen:

* Bohdan Babii: bohdan.babii@uni-jena.de
