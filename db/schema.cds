using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';
namespace redo.taskmanager;

/**
 * Aufgaben (Tasks) im System.
 */
entity Tasks : cuid, managed {
  creator      : Association to Users;                 // wer erstellt hat
  assignee     : Association to Users;                 // zuständig
  title        : String              @title : 'Title';
  description  : String              @title : 'Description';
  urgency      : Association to Urgency default 'M';
  status       : Association to Status  default 'N';
  dueAt        : Timestamp;                            // Fälligkeit
  comments     : Composition of many {
      key ID   : UUID;
      timestamp: type of managed:createdAt;
      author   : type of managed:createdBy;           // User-ID des Autors
      message  : String;
  };
}

/**
 * Nutzer, die Tasks erstellen/übernehmen können.
 */
entity Users : managed {
  key ID       : String;
  username     : String;
  firstName    : String;
  lastName     : String;
  name         : String = firstName || ' ' || lastName;
  email        : String;
  phone        : String;
  tasksCreated : Association to many Tasks on tasksCreated.creator  = $self;
  tasksOwned   : Association to many Tasks on tasksOwned.assignee   = $self;
}

/** Status-Codeliste */
entity Status : CodeList {
  key code : String enum {
    new         = 'N';
    in_progress = 'P';
    blocked     = 'B';
    done        = 'D';
    canceled    = 'X';
  };
  criticality : Integer;  // 1=Good,2=Warning,3=Error (für Fiori)
}

/** Dringlichkeit (Urgency) */
entity Urgency : CodeList {
  key code : String enum {
    high   = 'H';
    medium = 'M';
    low    = 'L';
  };
  criticality : Integer;  // optional, falls im UI gewünscht
}
