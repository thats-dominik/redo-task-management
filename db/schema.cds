using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';
namespace redo.taskmanager;

entity Tasks : cuid, managed {
  creator      : Association to Users;             // wer erstellt hat
  assignee     : Association to Users;                 // zuständig
  title        : String              @title : 'Title';
  description  : String              @title : 'Description';
  urgency      : Association to Urgency default 'M';
  status       : Association to Status  default 'N';
  dueAt        : Timestamp;                            // fälligkeitt
  comments     : Composition of many {
      key ID   : UUID;
      timestamp: type of managed:createdAt;
      author   : type of managed:createdBy;           // User id des Autors
      message  : String;
  };
}

// user die erstellentasks
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

//status
entity Status : CodeList {
  key code : String enum {
    new         = 'N';
    in_progress = 'P';
    blocked     = 'B';
    done        = 'D';
    canceled    = 'X';
  };
  criticality : Integer;
}

entity Urgency : CodeList {
  key code : String enum {
    high   = 'H';
    medium = 'M';
    low    = 'L';
  };
  criticality : Integer; 
}
