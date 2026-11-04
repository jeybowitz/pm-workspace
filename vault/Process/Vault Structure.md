# Vault Structure

Jak zorganizowany jest vault: foldery, pole Status w dokumentach Discovery i skalowanie szablonu.

Organizacja po **typie artefaktu**, nie po produkcie. Produkty (Admin panel, staff application, Customer application) są tagiem w plikach, nie folderem.

---

## Drzewko folderów

Drzewko na poziomie folderów - nie wymieniamy tu przykładowych plików, bo lista gnije:

```
Roadmap.md           - co, kiedy, dlaczego - jedyny widok całości
Decisions.md         - globalny log decyzji z tagami produktów
Todo.md / Weekly Plan.md - bieżąca praca
_Inbox/              - luźne wejście, czyścić raz w tygodniu

Reference/           - jak rzeczy działają TERAZ (stabilna wiedza)
  <product>/         - aktualny system: logika, moduły, konfiguracje
  Legacy/            - <legacy system>/ one folder per legacy system
  Data/              - liczby, macierze, tabele wartości per kraj (one folder per market)
  Integrations/      - integracje zewnętrzne (email itd.)
  Competitors/       - jeden folder per konkurent
  Markets.md         - różnice per rynek (płatności, VAT, dostawa, timezone)

Discovery/           - jeden plik = jeden ficzer (subfolder dla większych tematów, np. Fees/, Reports/); etap trackowany polem Status w nagłówku, nie lokalizacją folderu
Research/            - inputy i analizy zasilające ficzery, które nigdy nie staną się PRD (workshopy, Slack scany, zapytania o dane, feedback od dostawców)
Jira/                - gotowe tickety, jeden subfolder per epic
Stakeholders/        - Map.md, Persons.md, Team Structure.md
Meetings/            - notatki ze spotkań; Raw/ = surowe transkrypty
Process/             - procesy i opis setupu
```

## Bramka

**Zasada bramki:** dokument przechodzi na `Status: Spec ready` gdy sekcje 1-6 są wypełnione i żadne otwarte pytanie nie blokuje. Epiki i zbiorcze drafty wymagają `Spec ready`; wyjątki dla pojedynczych stories i zadań technicznych opisuje CLAUDE.md. Publikacja jest osobnym, autoryzowanym działaniem.

## Pole Status

**Dozwolone wartości pola Status - zamknięta lista, sześć pozycji:**

| Status | Kiedy wchodzi | Kiedy wychodzi |
| --- | --- | --- |
| `Active` | Ktoś nad tym pracuje teraz - od pierwszej notatki do prawie gotowej specyfikacji | Gdy wymagania są kompletne albo gdy praca staje |
| `Blocked on: <kto/co>` | Czekamy na kogoś z zewnątrz i nie da się iść dalej | Gdy odpowiedź przyjdzie |
| `Parked` | Nikt teraz nad tym nie pracuje - niezależnie czy to świadoma decyzja, czy po prostu kolejka | Gdy ktoś to podnosi |
| `Spec ready` | Sekcje 1-6 wypełnione, brak blokujących Draft, Blocked lub TBD | Gdy tickety powstaną |
| `In development` | Tickety są w Jirze | Gdy wchodzi na produkcję |
| `Shipped` | Na produkcji | Nigdy - plik dostaje przyrostek `(shipped)` |

Trzy reguły, bez wyjątków:

1. **W linii Status stoi wyłącznie wartość.** Żadnych dat, kluczy Jira ani wyjaśnień - to treść dokumentu, nie status.
2. **Tylko `Blocked on:` przyjmuje dopisek** i musi go mieć. Samo "Blocked" nic nie mówi.
3. **Etapów discovery nie kodujemy w statusie** ("ready for spec", "ready for design", "pre-spec"). Jak daleko jest praca, widać po tym, które sekcje są wypełnione i po znacznikach Draft / Blocked / TBD (uzgodnione bez znacznika) przy wymaganiach. Status mówi, czy ktoś nad tym pracuje - nie jak daleko zaszedł.

Gdy dokument opisuje kilka faz z własnymi statusami (np. `Discovery/Localized Emails.md`), fazy używają etykiety `**Phase status:**` i mogą mieć dowolne wartości. `**Status:**` występuje raz na dokument i opisuje całość.

## Konwencja "shipped"

Dokumenty o wdrożonych ficzerach zostają w `Discovery/`, dostają przyrostek nazwy pliku `(shipped)` i `Status: Shipped`. Gdy folder się zapełni, oznaczone pliki można zbiorczo przenieść do `_archive/` (np. przy Friday review).

## Skalowanie szablonu

Szablon to podłoga, nie gorset.

- Małe i średnie ficzery (większość folderu): jeden plik, pełny szablon.
- Duże tematy (Fees, Reports, Event Creation): temat to subfolder, a szablon dotyczy tylko pliku wiodącego. Plik wiodący trzyma niezmienniki - Status, Open Questions z właścicielami, Decisions - i linkuje do dokumentów pogłębionych (modele, specyfikacje per raport, handoffy, walidacje). Dokumenty pogłębione mają dowolną strukturę, jakiej wymaga ich treść.
- Trzy niezmienniki (Status / Open Questions / Decisions) są obowiązkowe na pliku wiodącym, bo z nich korzysta bramka i skille. Reszta to domyślna struktura, wymienna na linki.
